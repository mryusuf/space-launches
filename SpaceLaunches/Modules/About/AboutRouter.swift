//
//  AboutRouter.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 23/11/20.
//

import UIKit

protocol AboutRouterProtocol {
  
  var presenter: AboutPresenterProtocol? { get set }
  
}

class AboutRouter {
  
  weak var presenter: AboutPresenterProtocol?
  weak var viewController: UIViewController?
  
}

extension AboutRouter: AboutRouterProtocol {
  
}
