//
//  Error+Ext.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 14/11/20.
//

import Foundation

enum DatabaseError: LocalizedError {

  case invalidInstance
  case requestFailed
  
  var errorDescription: String? {
    switch self {
    case .invalidInstance: return "Database can't instance."
    case .requestFailed: return "Your request failed."
    }
  }

}
