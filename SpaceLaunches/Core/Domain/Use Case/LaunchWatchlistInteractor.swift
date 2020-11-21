//
//  LaunchWatchlistInteractor.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 20/11/20.
//

import Foundation
import RxSwift

protocol LaunchWatchlistUseCase {
  
  var presenter: LaunchWatchlistPresenterProtocol? { get set }
  func getWatchlistedLaunches() -> Observable<[LaunchModel]>
  
}

class LaunchWatchlistInteractor: LaunchWatchlistUseCase {
  
  weak var presenter: LaunchWatchlistPresenterProtocol?
  
  private let repository: SpaceRepositoryProtocol
  
  required init(repo: SpaceRepositoryProtocol) {
    self.repository = repo
  }
  
  func getWatchlistedLaunches() -> Observable<[LaunchModel]> {
    self.repository.getWatchlistedLaunches()
  }
  
}
