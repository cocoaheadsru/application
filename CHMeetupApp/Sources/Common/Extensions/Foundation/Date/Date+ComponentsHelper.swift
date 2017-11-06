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
    let calendar = Calendar.current

    let todayYear = calendar.component(.year, from: date)
    let dateYear = calendar.component(.year, from: self)

    return todayYear == dateYear
  }

  var isFutureDate: Bool {
    let thisTime = Date().timeIntervalSince1970
    let dateTime = timeIntervalSince1970

    return thisTime <= dateTime
  }

  var isPassed: Bool {
    return (self.isLater(then: Date()) == false)
  }
}
