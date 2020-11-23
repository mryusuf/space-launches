//
//  RemoteDataSource.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 10/11/20.
//

import Foundation
import Alamofire
import RxSwift

protocol RemoteDataSourceProtocol: class {
  
  func getUpcomingGoLaunches() -> Observable<[Launch]>
  func getPreviousLaunches() -> Observable<[Launch]>
  
}

final class RemoteDataSource: NSObject {
  
  private override init() {}
  
  static let shared: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
  
  func getUpcomingGoLaunches() -> Observable<[Launch]> {
    return Observable<[Launch]>.create { observer in
      if let url = URL(string: Endpoints.Gets.upcomingGo.url) {
        AF.request(url)
          .validate()
          .responseDecodable(of: LaunchesResult.self) { response in
            switch response.result {
            case .success(let values):
              observer.onNext(values.results)
              observer.onCompleted()
            case .failure(let error):
              observer.onError(error)
            }
          }
      }
      return Disposables.create()
    }
  }
  
  func getPreviousLaunches() -> Observable<[Launch]> {
    return Observable<[Launch]>.create { observer in
      if let url = URL(string: Endpoints.Gets.previous.url) {
        AF.request(url)
          .validate()
          .responseDecodable(of: LaunchesResult.self) { response in
            switch response.result {
            case .success(let values):
              observer.onNext(values.results)
              observer.onCompleted()
            case .failure(let error):
              observer.onError(error)
            }
          }
      }
      return Disposables.create()
    }
  }
}
