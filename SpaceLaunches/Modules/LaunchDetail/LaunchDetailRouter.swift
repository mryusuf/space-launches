//
//  LaunchDetailRouter.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 15/11/20.
//

import UIKit

protocol LaunchDetailRouterProtocol {
  
  var presenter: LaunchDetailPresenterProtocol? { get set }
  func showInfographicImage()
  
}

class LaunchDetailRouter {
  
  weak var presenter: LaunchDetailPresenterProtocol?
  weak var viewController: UIViewController?
  
}

extension LaunchDetailRouter: LaunchDetailRouterProtocol {
  
  func showInfographicImage() {
    
  }
}
