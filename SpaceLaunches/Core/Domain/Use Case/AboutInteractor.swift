//
//  AboutInteractor.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 23/11/20.
//

import Foundation
import RxSwift

protocol AboutUseCase {
  
  var presenter: AboutPresenterProtocol? { get set }
  func getAboutData() -> Observable<AboutModel>
  
}

class AboutInteractor: AboutUseCase {
  
  weak var presenter: AboutPresenterProtocol?
  private let repository: SpaceRepositoryProtocol
  
  required init(repo: SpaceRepositoryProtocol) {
    self.repository = repo
  }
  
  func getAboutData() -> Observable<AboutModel> {
    return self.repository.getAboutData()
  }
  
}
