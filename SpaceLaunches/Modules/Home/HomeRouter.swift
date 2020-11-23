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
    watchlistVC.tabBarItem = UITabBarItem(title: "Watchlist", image: UIImage(named: "watchlist-true"), tag: 1)
    
    let aboutVC = AboutAssembly().build()
    aboutVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
    
    let launchNC = UINavigationController(rootViewController: launchVC)
    let watchlistNC = UINavigationController(rootViewController: watchlistVC)
    let aboutNC = UINavigationController(rootViewController: aboutVC)
    
    return [
      launchNC,
      watchlistNC,
      aboutNC
    ]
  }
  
}
