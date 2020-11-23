//
//  AboutPresenter.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 23/11/20.
//

import Foundation
import RxSwift

protocol AboutPresenterProtocol: class {
  
  var interactor: AboutUseCase? { get set }
  var router: AboutRouterProtocol? { get set }
  var view: AboutViewProtocol? { get set }
  func setupView()
  
}

class AboutPresenter {
  
  var interactor: AboutUseCase?
  var router: AboutRouterProtocol?
  weak var view: AboutViewProtocol?
  private var aboutModel: AboutModel?
  fileprivate var bags = DisposeBag()
  
}

extension AboutPresenter: AboutPresenterProtocol {
  
  func setupView() {
    
    self.interactor?.getAboutData()
      .observeOn(MainScheduler.instance)
      .subscribe() { result in
        self.aboutModel = result
      } onError: { (Error) in
        print("error: \(Error)")
      } onCompleted: {
        if let aboutModel = self.aboutModel {
          self.view?.display(aboutModel)
        }
      }
      .disposed(by: bags)

  }
  
}
