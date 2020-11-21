//
//  Injection.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 15/11/20.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
  
   func provideRepository() -> SpaceRepositoryProtocol {

    let remote: RemoteDataSource = RemoteDataSource.shared
    let realm = try? Realm()
    let local: LocalDataSource = LocalDataSource.shared(realm)
    
    return SpaceRepository.shared(remote, local)
  }
  
}
