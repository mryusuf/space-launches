//
//  LaunchesResponse.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 10/11/20.
//

import Foundation

struct LaunchesResult: Decodable {
  let count: Int
  let results: [Launch]
}

struct Launch: Decodable {
  let id: String
  let url: String
  let name: String
  let net: String?
  let tbdtime: Bool
  let tbddate: Bool
  let status: Status
  let holdreason: String?
  let failreason: String?
  let image: String?
  let infographic: String?
  let launch_service_provider: Agency
  let rocket: Rocket
  let mission: Mission?
  let pad: Pad
}

struct Status: Decodable {
  let id: Int
  let name: String
}

struct Agency: Decodable {
  let id: Int
  let url: String?
  let name: String?
  let type: String?
}

struct Rocket: Decodable {
  let id: Int
  let configuration: RocketConfiguration
}

struct RocketConfiguration: Decodable {
  let id: Int
  let name: String?
  let url: String?
}

struct Mission: Decodable {
  let id: Int
  let name: String?
  let description: String?
  let type: String?
}

struct Pad: Decodable {
  let id: Int
  let name: String?
  let wiki_url: String?
  let location: PadLocation
}

struct PadLocation: Decodable {
  let name: String
  let country_code: String
}
