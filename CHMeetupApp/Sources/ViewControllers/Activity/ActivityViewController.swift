//
//  ActivityViewController.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 02/12/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class ActivityViewController {
  enum ActivityType {
    case event(EventEntity)
    case speech(SpeechEntity)
  }

  static func share(_ activityType: ActivityType) -> UIActivityViewController {
    var activityItems: [Any] = []
    let site = URL(string: Constants.site)
    switch activityType {
    case .event(let eventEntity):
      activityItems.append(eventEntity.title)
      activityItems.append(eventEntity.descriptionText)
      activityItems.append(eventEntity.startDate.defaultFormatString)
      if let site = site {
        activityItems.append(site)
      }
    case .speech(let speech):
      activityItems.append(speech.title)
    }

    return UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
  }
}
