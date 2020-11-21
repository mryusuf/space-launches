//
//  HomeInteractor.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 10/11/20.
//

import Foundation
import RxSwift

protocol HomeUseCase {
  
  var presenter: HomePresenterProtocol? { get set }
  
}

class HomeInteractor: HomeUseCase {
  
  weak var presenter: HomePresenterProtocol?
  
}
