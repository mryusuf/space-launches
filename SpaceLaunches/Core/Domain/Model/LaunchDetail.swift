//
//  LaunchDetail.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 19/11/20.
//

import Foundation
import RxDataSources

struct LaunchDetail: Equatable {
  
  let label: String
  let detail: String
  
}

extension LaunchDetail: IdentifiableType {
  
  typealias Identity = String
  
  var identity: String {
      return label
  }
  
  static func == (lhs: LaunchDetail, rhs: LaunchDetail) -> Bool {
      return lhs.label == rhs.label
  }
  
}
