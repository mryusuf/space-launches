//
//  LaunchDetailRouter.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 15/11/20.
//

import UIKit
import Lightbox

protocol LaunchDetailRouterProtocol: class {
  
  var presenter: LaunchDetailPresenterProtocol? { get set }
  func showInfographicImage(for image: UIImage)
  
}

class LaunchDetailRouter {
  
  weak var presenter: LaunchDetailPresenterProtocol?
  weak var viewController: UIViewController?
  
}

extension LaunchDetailRouter: LaunchDetailRouterProtocol {
  
  func showInfographicImage(for image: UIImage) {
    let image = [LightboxImage(image: image)]
    
    let lightBoxController = LightboxController(images: image, startIndex: 0)
    lightBoxController.pageDelegate = self.viewController as? LightboxControllerPageDelegate
    lightBoxController.dismissalDelegate = self.viewController as? LightboxControllerDismissalDelegate
    lightBoxController.dynamicBackground = true
    
    print("LaunchDetailRouter showInfographicImage")
    
    self.viewController?.present(lightBoxController, animated: true, completion: nil)
  }
}
