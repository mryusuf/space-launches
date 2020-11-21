//
//  LaunchSection.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 17/11/20.
//

import Foundation
import RxDataSources

struct LaunchSection {
  
  var header: String
  var items: [Item]
  var id: String = "1"
  
}

extension LaunchSection: AnimatableSectionModelType {
  
  typealias Identity = String
  typealias Item = LaunchModel
  
  init(original: LaunchSection, items: [LaunchModel]) {
    self = original
    self.items = items
  }
  
  var identity: String {
    return id
  }
  
}
