//
//  ImportToCalendarAndReminder.swift
//  CHMeetupApp
//
//  Created by Егор Петров on 23/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import EventKit
import UIKit

enum ImportToType {
  case calendar
  case reminder
}

class Importer {

  private static let calendarEventStore = EKEventStore()
  private static let remindersEventStore = EKEventStore()

  static func `import`(event: EventPO, to type: ImportToType) {
    switch type {
    case .calendar:
      importToCalendar(infoAboutEvent: event)
    case .reminder:
      importToReminder(infoAboutEvent: event)
    }
  }

  private static func importToCalendar(infoAboutEvent: EventPO) {
    calendarEventStore.requestAccess(to: .event, completion: { granted, error in
      guard granted else {
        openSettings()
        return
      }

      let event = EKEvent(eventStore: self.calendarEventStore)
      let structuredLocation = EKStructuredLocation(title: infoAboutEvent.locationTitle)
      //warn the user for five hours before event 5 hours = 18000 seconds
      let alarm = EKAlarm(relativeOffset:-(5 * 60 * 60))

      event.title = infoAboutEvent.title
      event.startDate = Date(timeIntervalSince1970: infoAboutEvent.startTime.timeIntervalFrom1970)
      event.endDate = Date(timeIntervalSince1970: infoAboutEvent.endTime.timeIntervalFrom1970)
      event.notes = infoAboutEvent.notes
      event.addAlarm(alarm)
      event.calendar = self.calendarEventStore.defaultCalendarForNewEvents

      structuredLocation.geoLocation = infoAboutEvent.location
      event.structuredLocation = structuredLocation

      do {
        try self.calendarEventStore.save(event, span: .thisEvent)
      } catch {
        print("Event Store save error: \(error), event: \(event)")
      }

    })
  }

  private static func importToReminder(infoAboutEvent: EventPO) {
    remindersEventStore.requestAccess(to: .reminder, completion: { granted, error in
      guard granted else {
        openSettings()
        return
      }

      let reminder = EKReminder(eventStore: self.remindersEventStore)
      let intervalSince1970 = infoAboutEvent.startTime.timeIntervalFrom1970
      let alarmDate = Date(timeIntervalSince1970:  intervalSince1970 - (5 * 60 * 60))
      let alarm = EKAlarm(absoluteDate: alarmDate)

      reminder.title = infoAboutEvent.title
      reminder.calendar = self.remindersEventStore.defaultCalendarForNewReminders()
      reminder.addAlarm(alarm)

      do {
        try self.remindersEventStore.save(reminder, commit: true)
      } catch {
        print("Event Store save error: \(error), event: \(reminder)")
      }
    })
  }

  private static func openSettings() {
    let settingsURL = URL(string: UIApplicationOpenSettingsURLString)!
    UIApplication.shared.open(settingsURL, options: [:]) { (success) in
      print("Settings opened: \(success)")
    }
  }
}
