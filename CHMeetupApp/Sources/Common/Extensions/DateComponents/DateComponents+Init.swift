//
//  DateComponents+Init.swift
//  CHMeetupApp
//
//  Created by Егор Петров on 27/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import Foundation

extension DateComponents {
  init(date: EventPO) {
    let calendar = Calendar.current
    let yearComponent = Int(calendar.component(.year, from: date.startTime))
    let monthComponent = Int(calendar.component(.month, from: date.startTime))
    let dayComponent = Int(calendar.component(.day, from: date.startTime))
    let hourComponent = Int(calendar.component(.hour, from: date.startTime))
    let minuteComponent = Int(calendar.component(.minute, from: date.startTime))
    // swiftlint:disable line_length
    self.init(year: yearComponent, month: monthComponent, day: dayComponent, hour: hourComponent, minute: minuteComponent)
  }
}
