//
//  HomeAssembly.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 15/11/20.
//

import UIKit

final class HomeAssembly {
  
  func build() -> UIViewController {
    
    let view = HomeView()
    let interactor = HomeInteractor()
    let presenter = HomePresenter()
    let router = HomeRouter()
    
    view.presenter = presenter
    
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    
    interactor.presenter = presenter
    
    router.presenter = presenter
    router.viewController = view
    
    presenter.setupViewControllers()
    
    return view
  }

}
