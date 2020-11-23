//
//  LaunchWatchlistAssembly.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 20/11/20.
//

import UIKit

final class LaunchWatchlistAssembly {
  
  func build() -> UIViewController {
    
    let repo = Injection.init().provideRepository()
    let view = LaunchWatchlistView()
    let interactor = LaunchWatchlistInteractor(repo: repo)
    let presenter = LaunchWatchlistPresenter()
    let router = LaunchWatchlistRouter()
    
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
