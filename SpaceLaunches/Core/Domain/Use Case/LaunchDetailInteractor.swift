//
//  LaunchDetailInteractor.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 18/11/20.
//

import Foundation
import RxSwift

protocol LaunchDetailUseCase {
  
  var presenter: LaunchDetailPresenterProtocol? { get set }
  func getLaunch() -> LaunchModel
  func checkIfInWatchlist(_ launchModel: LaunchModel) -> Bool
  func toggleWatchlist(_ id: String) -> Observable<Bool>
}

class LaunchDetailInteractor: LaunchDetailUseCase {
  
  weak var presenter: LaunchDetailPresenterProtocol?
  private let repository: SpaceRepositoryProtocol
  private let launch: LaunchModel
  
  required init(repo: SpaceRepositoryProtocol, launch: LaunchModel) {
    self.repository = repo
    self.launch = launch
  }
  
  func getLaunch() -> LaunchModel {
    return launch
  }
  
  func checkIfInWatchlist(_ launchModel: LaunchModel) -> Bool {
    return launchModel.isInWatchlist
  }
  
  func toggleWatchlist(_ id: String) -> Observable<Bool> {
    return self.repository.toggleWatchlist(id)
  }
  
}
