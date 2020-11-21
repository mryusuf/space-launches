//
//  LaunchAssembly.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 15/11/20.
//

import UIKit

final class LaunchesAssembly {
  
  func build() -> UIViewController {
    let repo = Injection.init().provideRepository()
    let view = LaunchesView()
    let interactor = LaunchesInteractor(repo: repo)
    let presenter = LaunchesPresenter()
    let router = LaunchesRouter()
    
    view.presenter = presenter
    
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    
    interactor.presenter = presenter
    
    router.presenter = presenter
    router.viewController = view
    
    return view
  }
  
}
