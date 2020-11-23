//
//  LaunchEntity.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 13/11/20.
//

import Foundation
import RealmSwift

class LaunchEntity: Object {
  @objc dynamic var id: String = ""
  @objc dynamic var url: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var net: Date?
  @objc dynamic var status: StatusEntity?
  @objc dynamic var tbdtime: Bool = false
  @objc dynamic var tbddate: Bool = false
  @objc dynamic var holdreason: String = ""
  @objc dynamic var failreason: String = ""
  @objc dynamic var image: String = ""
  @objc dynamic var infographic: String = ""
  @objc dynamic var agency: AgencyEntity?
  @objc dynamic var rocket: RocketEntity?
  @objc dynamic var mission: MissionEntity?
  @objc dynamic var pad: PadEntity?
  @objc dynamic var type: Int = 0
  @objc dynamic var isInWatchlist: Bool = false
  override class func primaryKey() -> String? {
    return "id"
  }
}

class StatusEntity: Object {
  @objc dynamic var id: Int = 0
  @objc dynamic var name: String = ""
  override class func primaryKey() -> String? {
    return "id"
  }
}

class AgencyEntity: Object {
  @objc dynamic var id: Int = 0
  @objc dynamic var url: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var type: String = ""
  override class func primaryKey() -> String? {
    return "id"
  }
}

class RocketEntity: Object {
  @objc dynamic var id: Int = 0
  var configuration: RocketConfigurationEntity?
  override class func primaryKey() -> String? {
    return "id"
  }
}

class RocketConfigurationEntity: Object {
  @objc dynamic var id: Int = 0
  @objc dynamic var name: String = ""
  @objc dynamic var url: String = ""
  override class func primaryKey() -> String? {
    return "id"
  }
}

class MissionEntity: Object {
  @objc dynamic var id: Int = 0
  @objc dynamic var name: String = ""
  @objc dynamic var desc: String = ""
  @objc dynamic var type: String = ""
  override class func primaryKey() -> String? {
    return "id"
  }
}

class PadEntity: Object {
  @objc dynamic var id: Int = 0
  @objc dynamic var name: String = ""
  @objc dynamic var wiki_url: String = ""
  @objc dynamic var location: PadLocationEntity?
  override class func primaryKey() -> String? {
    return "id"
  }
}

class PadLocationEntity: Object {
  @objc dynamic var name: String = ""
  @objc dynamic var country_code: String = ""
  override class func primaryKey() -> String? {
    return "name"
  }
}

enum LaunchType: Int {
  case upcomingGo = 1
  case previous = 2
}
