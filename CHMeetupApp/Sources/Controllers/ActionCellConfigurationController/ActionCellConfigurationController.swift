//
//  ActionCellConfigurationController.swift
//  CHMeetupApp
//
//  Created by Егор Петров on 25/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class ActionCellConfigurationController {

  enum `Type` {
    case reminders
    case calendar
  }

  typealias Action = () -> Void

  func checkAccess(on viewController: UIViewController, for type: Type, with action: Action?) -> ActionPlainObject? {
    var actionPlainObject: ActionPlainObject?

    switch  type {
    case .reminders:
      if !PermissionsManager.isAllowed(type: .reminders) {
        actionPlainObject = ActionPlainObject(text: "Включите оповещения, чтобы не пропустить событие".localized,
                                              imageName: "img_icon_notification", action: {
                                              self.requireAccess(from: viewController, to: .reminders,
                                                                 with: action)
        })
        return actionPlainObject
      }
    case .calendar:
      if !PermissionsManager.isAllowed(type: .calendar) {
        actionPlainObject = ActionPlainObject(text: "Включите календарь, чтобы не пропустить событие".localized,
                                              imageName: "img_icon_notification", action: {
                                                self.requireAccess(from: viewController, to: .calendar,
                                                                   with: action)
        })
        return actionPlainObject
      }
    }
    return nil
  }

  private func requireAccess(from viewController: UIViewController, to type: Type, with action: Action?) {
    switch type {
    case .reminders:
      PermissionsManager.requireAccess(from: viewController,
                                       to: .reminders, completion: { success in
                                        if success {
                                          DispatchQueue.main.async {
                                            action?()
                                          }
                                        }
      })
    case .calendar:
      PermissionsManager.requireAccess(from: viewController,
                                       to: .calendar, completion: { success in
                                        if success {
                                          DispatchQueue.main.async {
                                            action?()
                                          }
                                        }
      })
    }
  }

  func modelForActionCell(with actionPlainObject: ActionPlainObject) -> ActionTableViewCellModel {
    return ActionTableViewCellModel(action: actionPlainObject)
  }
}
