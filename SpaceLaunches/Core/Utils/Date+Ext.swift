//
//  Date+Ext.swift
//  SpaceLaunches
//
//  Created by Indra Permana on 10/11/20.
//

import Foundation

extension String {
  
  func toDate() -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = .current
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let date = dateFormatter.date(from: self)
    return date
  }
  
  func modelToDate() -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = .current
    dateFormatter.timeStyle = .short
    dateFormatter.dateStyle = .short
    let date = dateFormatter.date(from: self)
    return date
  }
  
}

extension Date {
  
  func toString() -> String? {
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = .current
    dateFormatter.timeZone = .current
    dateFormatter.timeStyle = .short
    dateFormatter.dateStyle = .short
    let dateString = dateFormatter.string(from: self)
    return dateString
  }
}
