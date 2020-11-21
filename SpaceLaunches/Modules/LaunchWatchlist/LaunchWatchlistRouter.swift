//
//  LaunchWatchlistRouter.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 20/11/20.
//

import UIKit

protocol LaunchWatchlistRouterProtocol {
  
  var presenter: LaunchWatchlistPresenterProtocol? { get set }
  func showLaunchDetail(with launch: LaunchModel)
  
}

class LaunchWatchlistRouter {
  
  weak var presenter: LaunchWatchlistPresenterProtocol?
  weak var viewController: UIViewController?
  
}

extension LaunchWatchlistRouter: LaunchWatchlistRouterProtocol {
  
  func showLaunchDetail(with launch: LaunchModel) {
    let launchDetailVC = LaunchDetailAssembly().build(launch)
//    launchDetailVC.modalPresentationStyle = .fullScreen
    self.viewController?.navigationController?.pushViewController(launchDetailVC, animated: true)
  }
  
}
