//
//  LaunchesInteractor.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 15/11/20.
//

import Foundation
import RxSwift

protocol LaunchesUseCase {
  
  var presenter: LaunchesPresenterProtocol? { get set }
  func getUpcomingGoLaunches() -> Observable<[LaunchModel]>
  func getPreviousLaunches() -> Observable<[LaunchModel]>
  
}

class LaunchesInteractor: LaunchesUseCase {
  
  weak var presenter: LaunchesPresenterProtocol?
  private let repository: SpaceRepositoryProtocol
  
  required init(repo: SpaceRepositoryProtocol) {
    self.repository = repo
  }
  
  func getUpcomingGoLaunches() -> Observable<[LaunchModel]> {
    return repository.getUpcomingGoLaunches()
  }
  
  func getPreviousLaunches() -> Observable<[LaunchModel]> {
    return repository.getPreviousLaunches()
  }
  
}
