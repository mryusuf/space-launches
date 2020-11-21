//
//  LaunchDetailSection.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 19/11/20.
//

import Foundation
import RxDataSources

struct LaunchDetailSection {
  
  var header: String
  var items: [Item]
  var id: String = "2"
  
}

extension LaunchDetailSection: AnimatableSectionModelType {
  
  typealias Identity = String
  typealias Item = LaunchDetail
  
  init(original: LaunchDetailSection, items: [LaunchDetail]) {
    self = original
    self.items = items
  }
  
  var identity: String {
    return id
  }
  
}

//enum LaunchDetailCellModel {
//  case description(LaunchDetailSection)
//  case infographic(LaunchDetailSection)
//}
