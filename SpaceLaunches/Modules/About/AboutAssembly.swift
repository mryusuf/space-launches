//
//  AboutAssembly.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 23/11/20.
//

import UIKit

final class AboutAssembly {
  
  func build() -> UIViewController {
    let repo = Injection.init().provideRepository()
    let view = AboutView()
    let interactor = AboutInteractor(repo: repo)
    let presenter = AboutPresenter()
    let router = AboutRouter()
    
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
