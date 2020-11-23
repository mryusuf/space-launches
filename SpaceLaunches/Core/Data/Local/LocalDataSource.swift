//
//  LocalDataSource.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 13/11/20.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocalDataSourceProtocol {
  
  func getUpcomingGoLaunches() -> Observable<[LaunchEntity]>
  func getPreviousLaunches() -> Observable<[LaunchEntity]>
  func addLaunches(from launches: [LaunchEntity]) -> Observable<Bool>
  func getWatchlistedLaunches() -> Observable<[LaunchEntity]>
  func toggleWatchlist(_ id: String) -> Observable<Bool>
  func getAboutData() -> Observable<AboutModel>
}

final class LocalDataSource: NSObject {
  
  private let realm: Realm?
  
  private init(realm: Realm?) {
    self.realm = realm
  }
  
  static let shared: (Realm?) -> LocalDataSource = {
    realmDB in return LocalDataSource(realm: realmDB)
  }
  
}

extension LocalDataSource: LocalDataSourceProtocol {
  
  func getUpcomingGoLaunches() -> Observable<[LaunchEntity]> {
    return Observable<[LaunchEntity]>.create { observer in
      if let realm = self.realm {
        let launches: Results<LaunchEntity> = {
          realm.objects(LaunchEntity.self)
            .filter("type == %@ AND net > %@", LaunchType.upcomingGo.rawValue, Date())
            .sorted(byKeyPath: "net", ascending: true)
        }()
        observer.onNext(launches.toArray(ofType: LaunchEntity.self))
        observer.onCompleted()
      } else {
        observer.onError(DatabaseError.invalidInstance)
      }
      return Disposables.create()
    }
  }
  
  func getPreviousLaunches() -> Observable<[LaunchEntity]> {
    return Observable<[LaunchEntity]>.create { observer in
      if let realm = self.realm {
        let launches: Results<LaunchEntity> = {
          realm.objects(LaunchEntity.self)
            .filter("type == %@", LaunchType.previous.rawValue)
            .sorted(byKeyPath: "net", ascending: true)
        }()
        observer.onNext(launches.toArray(ofType: LaunchEntity.self))
        observer.onCompleted()
      } else {
        observer.onError(DatabaseError.invalidInstance)
      }
      return Disposables.create()
    }
  }
  
  func addLaunches(from launches: [LaunchEntity]) -> Observable<Bool> {
    return Observable<Bool>.create { observer in
      if let realm = self.realm {
        do {
          try realm.write {
            for launch in launches {
              realm.add(launch, update: .all)
            }
            observer.onNext(true)
            observer.onCompleted()
          }
        } catch {
          observer.onError(DatabaseError.requestFailed)
        }
      } else {
        observer.onError(DatabaseError.invalidInstance)
      }
      return Disposables.create()
    }
  }
  
  func getWatchlistedLaunches() -> Observable<[LaunchEntity]> {
    return Observable<[LaunchEntity]>.create { observer in
      if let realm = self.realm {
        let launches: Results<LaunchEntity> = {
          realm.objects(LaunchEntity.self)
            .filter("isInWatchlist == %@", true)
            .sorted(byKeyPath: "net", ascending: true)
        }()
        observer.onNext(launches.toArray(ofType: LaunchEntity.self))
        observer.onCompleted()
      } else {
        observer.onError(DatabaseError.invalidInstance)
      }
      return Disposables.create()
    }
  }
  
  func toggleWatchlist(_ id: String) -> Observable<Bool> {
    return Observable<Bool>.create { observer in
      if let realm = self.realm {
        do {
          try realm.write {
            if let launch = realm.object(ofType: LaunchEntity.self, forPrimaryKey: id) {
              launch.isInWatchlist.toggle()
              observer.onNext(launch.isInWatchlist)
              observer.onCompleted()
            } else {
              observer.onError(DatabaseError.requestFailed)
            }
          }
        } catch {
          observer.onError(DatabaseError.requestFailed)
        }
      } else {
        observer.onError(DatabaseError.invalidInstance)
      }
      return Disposables.create()
    }
  }
  
  func getAboutData() -> Observable<AboutModel> {
    return Observable<AboutModel>.create { observer in
      let about = Injection.init().prodideAboutData()
      observer.onNext(about)
      observer.onCompleted()
      return Disposables.create()
    }
  }
  
}

extension Results {
  
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
}
