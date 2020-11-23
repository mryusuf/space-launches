//
//  SpaceRepository.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 10/11/20.
//

import Foundation
import RxSwift

protocol SpaceRepositoryProtocol {
  
  func getUpcomingGoLaunches() -> Observable<[LaunchModel]>
  func getPreviousLaunches() -> Observable<[LaunchModel]>
  func getWatchlistedLaunches() -> Observable<[LaunchModel]>
  func toggleWatchlist(_ id: String) -> Observable<Bool>
  func getAboutData() -> Observable<AboutModel>
  
}

final class SpaceRepository: NSObject {
  
  typealias SpaceInstance = (RemoteDataSource, LocalDataSource) -> SpaceRepository
  
  fileprivate let remote: RemoteDataSource
  fileprivate let local: LocalDataSource
  
  private init(remote: RemoteDataSource, local: LocalDataSource) {
    self.remote = remote
    self.local = local
  }
  
  static let shared: SpaceInstance = { remoteRepo, localRepo in
    return SpaceRepository(remote: remoteRepo, local: localRepo)
  }
}

extension SpaceRepository: SpaceRepositoryProtocol {
  
  func getUpcomingGoLaunches() -> Observable<[LaunchModel]> {
    return self.local.getUpcomingGoLaunches()
      .map { LaunchMapper.mapLaunchEntityToDomain(input: $0) }
      .filter { !$0.isEmpty }
      .ifEmpty(
        switchTo: self.remote.getUpcomingGoLaunches()
          .map { LaunchMapper.mapLaunchResponsesToEntity(input: $0, type: LaunchType.upcomingGo.rawValue) }
          .flatMap { self.local.addLaunches(from: $0) }
          .filter { $0 }
          .flatMap { _ in self.local.getUpcomingGoLaunches()
            .map { LaunchMapper.mapLaunchEntityToDomain(input: $0) }
          }
      )
   }
  
  func getPreviousLaunches() -> Observable<[LaunchModel]> {
    return self.local.getPreviousLaunches()
      .map { LaunchMapper.mapLaunchEntityToDomain(input: $0) }
      .filter { !$0.isEmpty }
      .ifEmpty(
        switchTo: self.remote.getPreviousLaunches()
          .map { LaunchMapper.mapLaunchResponsesToEntity(input: $0, type: LaunchType.previous.rawValue) }
          .flatMap { self.local.addLaunches(from: $0) }
          .filter { $0 }
          .flatMap { _ in self.local.getPreviousLaunches()
            .map { LaunchMapper.mapLaunchEntityToDomain(input: $0) }
          }
      )
   }
  
  func getWatchlistedLaunches() -> Observable<[LaunchModel]> {
    return self.local.getWatchlistedLaunches()
      .map { LaunchMapper.mapLaunchEntityToDomain(input: $0) }
  }
  
  func toggleWatchlist(_ id: String) -> Observable<Bool> {
    return self.local.toggleWatchlist(id)
  }
  
  func getAboutData() -> Observable<AboutModel> {
    return self.local.getAboutData()
  }
  
}
