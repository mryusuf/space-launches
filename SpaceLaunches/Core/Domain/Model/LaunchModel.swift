//
//  LaunchModel.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 10/11/20.
//

import Foundation
import RxDataSources

struct LaunchModel: Equatable, Identifiable {
  let id: String
  let url: String
  let name: String
  let net: String
  let status: StatusModel
  let tbdtime: Bool
  let tbddate: Bool
  let holdreason: String
  let failreason: String
  let image: String
  let infographic: String
  let agency: AgencyModel
  let rocket: RocketModel
  let mission: MissionModel?
  let pad: PadModel
  let isInWatchlist: Bool
}

extension LaunchModel: IdentifiableType {
    
    typealias Identity = String
    
    var identity: String {
        return id
    }
    
    static func == (lhs: LaunchModel, rhs: LaunchModel) -> Bool {
        return lhs.id == rhs.id
    }
}

struct StatusModel: Equatable {
  let id: Int
  let name: String
}

struct AgencyModel: Equatable {
  let id: Int
  let url: String
  let name: String
  let type: String
}

struct RocketModel: Equatable {
  let id: Int
  let configuration: RocketConfigurationModel
}

struct RocketConfigurationModel: Equatable {
  let id: Int
  let name: String
  let url: String
}

struct MissionModel: Equatable {
  let id: Int
  let name: String
  let description: String
  let type: String
}

struct PadModel: Equatable {
  let id: Int
  let name: String
  let wiki_url: String
  let location: PadLocationModel
}

struct PadLocationModel: Equatable {
  let name: String
  let country_code: String
}
