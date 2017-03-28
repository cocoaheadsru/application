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
        actionPlainObject = ActionPlainObject(text: "Включите оповещения, чтобы не пропустить событие",
                                              imageName: "img_icon_notification", action: {
                                              PermissionsManager.requireAccess(from: viewController,
                                                                               to: .reminders,
                                                                               completion: { success in
                                                                                if success {
                                                                                  DispatchQueue.main.async {
                                                                                    action?()
                                                                                  }
                                                                                }
                                                })
        })
        return actionPlainObject
      }
    case .calendar:
      if !PermissionsManager.isAllowed(type: .calendar) {
        actionPlainObject = ActionPlainObject(text: "Включите календарь, чтобы добавить мероприятие в ваш календарь",
                                              imageName: "img_icon_notification", action: {
                                                PermissionsManager.requireAccess(from: viewController,
                                                                                 to: .calendar,
                                                                                 completion: { success in
                                                                                  if success {
                                                                                    DispatchQueue.main.async {
                                                                                      action?()
                                                                                    }
                                                                                  }
                                                })
        })
        return actionPlainObject
      }
    }
    return nil
  }

  func modelForActionCell(with actionPlainObject: ActionPlainObject) -> ActionTableViewCellModel {
    return ActionTableViewCellModel(action: actionPlainObject)
  }
}
