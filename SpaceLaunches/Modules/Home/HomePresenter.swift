//
//  HomePresenter.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 14/11/20.
//

import Foundation
import RxSwift

protocol HomePresenterProtocol: class {
  
  var interactor: HomeUseCase? { get set }
  var router: HomeRouterProtocol? { get set }
  var view: HomeViewProtocol? { get set }
  func setupViewControllers()
  
}

class HomePresenter {
  
  var interactor: HomeUseCase?
  var router: HomeRouterProtocol?
  weak var view: HomeViewProtocol?
  fileprivate var bags = DisposeBag()
  
}

extension HomePresenter: HomePresenterProtocol {
  
  func setupViewControllers() {
    
    guard let controllers = router?.getViewControllers() else {
      return
    }
    self.view?.display(controllers)
  }
  
}
