//
//  Date+LocalizedFormat.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 28.03.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

extension Date {
  var eventFormatDateString: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = eventDateFormat
    return dateFormatter.string(from: self)
  }

  var eventDateFormat: String {
    let template = "MMMM dd, HH:mm"
    return DateFormatter.dateFormat(fromTemplate: template,
                                    options: 0,
                                    locale: .current)!
  }
}
