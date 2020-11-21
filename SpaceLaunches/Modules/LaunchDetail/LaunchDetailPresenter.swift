//
//  LaunchDetailPresenter.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 15/11/20.
//

import Foundation
import RxSwift

protocol LaunchDetailPresenterProtocol: class {
  
  var interactor: LaunchDetailUseCase? { get set }
  var view: LaunchDetailViewProtocol? { get set }
  var router: LaunchDetailRouter? { get set }
  func loadDetailLaunch()
  func checkIfInWatchlist() -> Bool
  func toggleWatchlist()
  
}

class LaunchDetailPresenter {
  
  internal var interactor: LaunchDetailUseCase?
  internal weak var view: LaunchDetailViewProtocol?
  internal weak var router: LaunchDetailRouter?
  internal var launchModel: LaunchModel?
  internal var isInWatchlist: Bool?
  internal var bags = DisposeBag()
  
}

extension LaunchDetailPresenter: LaunchDetailPresenterProtocol {
  
  func loadDetailLaunch() {
    
    guard let launch = self.interactor?.getLaunch() else { return }
    
    self.launchModel = launch
    let launchDetails = LaunchMapper.mapLaunchModelToDetail(input: launch)
    
//    let launchInfographicDetails = launchDetails.filter { $0.label == "infographic" }
//    let launchDescDetails = launchDetails.filter { $0.label != "infographic" }
    
    let splitLaunchDetails = launchDetails.reduce(([LaunchDetail](), [LaunchDetail]()) ) { (value, object) -> ([LaunchDetail], [LaunchDetail]) in
      var value = value
      if object.label == "Infographic" {
        value.1.append(object)
      } else {
        value.0.append(object)
      }
      return value
    }
    
//    print("split launchDetails \(splitLaunchDetails)")
    
    // Map LaunchModel into LaunchDetail
    self.view?.displayLaunch(name: launch.name, image: launch.image, desc: splitLaunchDetails.0, infographic: splitLaunchDetails.1)
    
  }
  
  func checkIfInWatchlist() -> Bool {
    guard let launchModel = launchModel, let interactor = interactor else { return false }
    return interactor.checkIfInWatchlist(launchModel)
  }
  
  func toggleWatchlist() {
    
    guard let launchModel = self.launchModel else { return }
    
    self.interactor?.toggleWatchlist(launchModel.id)
      .observeOn(MainScheduler.instance)
      .subscribe() { result in
        self.isInWatchlist = result
      } onError: { (Error) in
        print("error: \(Error)")
      } onCompleted: {
        if let isInWatchlist = self.isInWatchlist {
          print("LaunchDetailPresenter toggleWatchlist \(self.isInWatchlist)")
          DispatchQueue.main.async {
            self.view?.updateToggleWatchlist(isInWatchlist: isInWatchlist)
          }
        }
      }
      .disposed(by: bags)
  }
  
}
