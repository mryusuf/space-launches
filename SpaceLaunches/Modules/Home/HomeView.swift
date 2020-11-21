//
//  HomeView.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 15/11/20.
//

import UIKit

protocol HomeViewProtocol: class {
  
  var presenter: HomePresenterProtocol? { get set }
  func display(_ viewControllers: [UIViewController])
  
}

class HomeView: UITabBarController {
  
  var presenter: HomePresenterProtocol?
  
}

extension HomeView: HomeViewProtocol {
  
  func display(_ viewControllers: [UIViewController]) {
    
    self.viewControllers = viewControllers
    
  }
  
}
