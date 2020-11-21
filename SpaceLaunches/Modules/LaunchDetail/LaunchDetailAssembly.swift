//
//  LaunchDetailAssembly.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 18/11/20.
//

import UIKit

final class LaunchDetailAssembly {
  
  func build(_ launch: LaunchModel) -> UIViewController {
    let repo = Injection.init().provideRepository()
    let view = LaunchDetailView()
    let interactor = LaunchDetailInteractor(repo: repo, launch: launch)
    let presenter = LaunchDetailPresenter()
    let router = LaunchDetailRouter()
    
    view.presenter = presenter
    
    presenter.view = view
    presenter.interactor = interactor
//    presenter.router = router
    
    interactor.presenter = presenter
    
//    router.presenter = presenter
    router.viewController = view
    
    return view
  }
  
}
