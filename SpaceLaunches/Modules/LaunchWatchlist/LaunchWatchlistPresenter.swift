//
//  LaunchWatchlistPresenter.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 20/11/20.
//

import Foundation
import RxSwift

protocol LaunchWatchlistPresenterProtocol: class {
  
  var interactor: LaunchWatchlistUseCase? { get set }
  var router: LaunchWatchlistRouterProtocol? { get set }
  var view: LaunchWatchlistViewProtocol? { get set }
  func loadLaunches()
  func showDetailLaunch(with launch: LaunchModel)
}

class LaunchWatchlistPresenter {
  
  internal var interactor: LaunchWatchlistUseCase?
  internal var router: LaunchWatchlistRouterProtocol?
  internal weak var view: LaunchWatchlistViewProtocol?
  fileprivate var bags = DisposeBag()
  
  fileprivate var launches: [LaunchModel] = []
  
}

extension LaunchWatchlistPresenter: LaunchWatchlistPresenterProtocol {
  
  func loadLaunches() {
    self.view?.startLoading()
    self.interactor?.getWatchlistedLaunches()
      .observeOn(MainScheduler.instance)
      .subscribe() { result in
        self.launches = result
      } onError: { (Error) in
        print("error: \(Error)")
      } onCompleted: {
        self.view?.stopLoading()
        if self.launches.isEmpty {
          self.view?.showEmptyState()
        } else {
          self.view?.displayLaunches(self.launches)
        }
      }
      .disposed(by: bags)
  }
  
  func showDetailLaunch(with launch: LaunchModel) {
    
    self.router?.showLaunchDetail(with: launch)
    
  }
  
}
