//
//  Date+ComponentsHelper.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 17/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

extension Date {
  var isThisYear: Bool {
    let date = Date()
    return isTheSame(.year, with: date)
  }

  var isPassed: Bool {
    return (self.isLater(then: Date()) == false)
  }

  var isToday: Bool {
    let date = Date()
    return isTheSame(.day, with: date) &&
      date.timeIntervalSince(self) < 86400 //24h
  }

  func isTheSame(_ component: Calendar.Component, with date: Date) -> Bool {
    let calendar = Calendar.current

    let today = calendar.component(component, from: date)
    let passed = calendar.component(component, from: self)

    return today == passed
  }
}
