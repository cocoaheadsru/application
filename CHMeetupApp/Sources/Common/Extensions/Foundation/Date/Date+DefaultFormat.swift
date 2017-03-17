//
//  Date+DefaultFormat.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 17/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

extension Date {
  var defaultFormatString: String {
    let template = self.isThisYear ? "MMMMd" : "yMMMMd"
    let dateFormatString = DateFormatter.dateFormat(fromTemplate: template,
                                                    options: 0,
                                                    locale: Locale.current)

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormatString

    return dateFormatter.string(from: self)
  }
}
