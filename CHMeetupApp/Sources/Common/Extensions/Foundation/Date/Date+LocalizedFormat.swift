//
//  Date+LocalizedFormat.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 28.03.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

extension Date {

  private static let dateFormatter = DateFormatter()

  var eventFormatDateString: String {
    Date.dateFormatter.dateFormat = eventDateFormat
    return Date.dateFormatter.string(from: self)
  }

  var eventDateFormat: String {
    let template = "MMMM dd, HH:mm"
    let localeCode = Bundle.main.preferredLocalizations.first! as String
    let locale = Locale(identifier: localeCode)
    return DateFormatter.dateFormat(fromTemplate: template,
                                    options: 0,
                                    locale: locale)!
  }
}
