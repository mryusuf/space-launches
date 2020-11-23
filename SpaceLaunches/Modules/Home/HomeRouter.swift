//
//  HomeRouter.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 15/11/20.
//

import UIKit

protocol HomeRouterProtocol {
  
  var presenter: HomePresenterProtocol? { get set }
  func getViewControllers() -> [UIViewController]
  
}

class HomeRouter {
  
  weak var presenter: HomePresenterProtocol?
  weak var viewController: UIViewController?
  
}

extension HomeRouter: HomeRouterProtocol {
  
  func getViewControllers() -> [UIViewController] {
    
    let launchVC = LaunchesAssembly().build()
    launchVC.tabBarItem = UITabBarItem(title: "Launches", image: UIImage(named: "launches-true"), tag: 0)
    
    let watchlistVC = LaunchWatchlistAssembly().build()
    watchlistVC.tabBarItem = UITabBarItem(title: "Watchlist", image: UIImage(named: "watchlist-true"), tag: 0)
    
    let launchNC = UINavigationController(rootViewController: launchVC)
    launchNC.navigationBar.prefersLargeTitles = true
    
    let watchlistNC = UINavigationController(rootViewController: watchlistVC)
    return [
      launchNC,
      watchlistNC
    ]
  }
  
}
