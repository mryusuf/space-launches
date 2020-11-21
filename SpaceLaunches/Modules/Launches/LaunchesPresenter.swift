//
//  LaunchesPresenter.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 15/11/20.
//

import Foundation
import RxSwift

protocol LaunchesPresenterProtocol: class {
  
  var interactor: LaunchesUseCase? { get set }
  var router: LaunchesRouterProtocol? { get set }
  var view: LaunchesViewProtocol? { get set }
  func loadLaunches()
  func showDetailLaunch(with launch: LaunchModel)
}

class LaunchesPresenter {
  
  internal var interactor: LaunchesUseCase?
  internal var router: LaunchesRouterProtocol?
  internal weak var view: LaunchesViewProtocol?
  fileprivate var bags = DisposeBag()
  
  fileprivate var upcomingGoLaunches: [LaunchModel] = []
  fileprivate var previousLaunches: [LaunchModel] = []
  
}

extension LaunchesPresenter: LaunchesPresenterProtocol {
  
  func loadLaunches() {
    
    self.view?.startLoading()
    self.interactor?.getUpcomingGoLaunches()
      .observeOn( MainScheduler.instance)
      .subscribe() { result in
        self.upcomingGoLaunches = result
      } onError: { (Error) in
        print("error: \(Error)")
      } onCompleted: {
        self.view?.stopLoading()
        self.view?.displayUpcomingGoLaunches(self.upcomingGoLaunches)
      }
      .disposed(by: bags)
    
    self.interactor?.getPreviousLaunches()
      .observeOn( MainScheduler.instance)
      .subscribe() { result in
        self.previousLaunches = result
      } onError: { (Error) in
        print("error: \(Error)")
      } onCompleted: {
//        self.view?.stopLoading()
        self.view?.displayPreviousLaunches(self.previousLaunches)
      }
      .disposed(by: bags)
    
  }
  
  func showDetailLaunch(with launch: LaunchModel) {
    
    self.router?.showLaunchDetail(with: launch)
    
  }
  
}
