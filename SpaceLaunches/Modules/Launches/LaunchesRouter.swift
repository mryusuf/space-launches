//
//  LaunchRouter.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 15/11/20.
//

import UIKit

protocol LaunchesRouterProtocol {
  
  var presenter: LaunchesPresenterProtocol? { get set }
  func showLaunchDetail(with launch: LaunchModel)
  
}

class LaunchesRouter {
  
  weak var presenter: LaunchesPresenterProtocol?
  weak var viewController: UIViewController?
  
}

extension LaunchesRouter: LaunchesRouterProtocol {
  
  func showLaunchDetail(with launch: LaunchModel) {
    let launchDetailVC = LaunchDetailAssembly().build(launch)
    launchDetailVC.hidesBottomBarWhenPushed = true
    self.viewController?.navigationController?.pushViewController(launchDetailVC, animated: true)
  }
  
}
