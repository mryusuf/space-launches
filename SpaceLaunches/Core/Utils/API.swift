//
//  API.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 10/11/20.
//

import Foundation
// API list: https://ll.thespacedevs.com/2.0.0/launch/upcoming/?status=1
struct API {
  
  static let baseUrl = "https://ll.thespacedevs.com/2.0.0/"
  
}

protocol Endpoint {
  
  var url: String { get }
  
}

enum Endpoints {
  
  enum Gets: Endpoint {
    
    case upcomingGo
    case previous
    
    public var url: String {
      switch self {
      case .upcomingGo:
        return "\(API.baseUrl)launch/upcoming/?status=1"
      case .previous:
        return "\(API.baseUrl)launch/previous"
        
      }
    }
      
  }
}
