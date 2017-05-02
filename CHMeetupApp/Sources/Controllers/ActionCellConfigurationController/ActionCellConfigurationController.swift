//
//  ActionCellConfigurationController.swift
//  CHMeetupApp
//
//  Created by Егор Петров on 25/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class ActionCellConfigurationController {

  typealias Action = () -> Void

  func addActionCell(on viewController: UIViewController,
                     for type: PermissionsType,
                     with additionalAction: Action?) -> ActionPlainObject? {
    var actionPlainObject: ActionPlainObject? = nil

    let texts: [PermissionsType: String] = [.calendar: "Добавить в календарь".localized,
                                            .reminders: "Добавить в напоминания".localized]
    let imagesNames: [PermissionsType: String] = [.calendar: "img_icon_calendar",
                                                  .reminders: "img_icon_reminders"]

    if let text = texts[type] {
      let imageName = imagesNames[type]
      actionPlainObject = ActionPlainObject(text: text,
                                            imageName: imageName, action: {
                                              self.requireAccess(from: viewController, to: type,
                                                                 with: {
                                                                  additionalAction?()
                                              })
      })
    }

    return actionPlainObject
  }

  func checkAccess(on viewController: UIViewController,
                   for type: PermissionsType, with additionalAction: Action?) -> ActionPlainObject? {
    var actionPlainObject: ActionPlainObject?

    switch  type {
    case .reminders:
      if !PermissionsManager.isAllowed(type: type) {
        actionPlainObject = ActionPlainObject(text: "Включите напоминания, чтобы не пропустить событие".localized,
                                              imageName: "img_icon_reminders", action: {
                                              self.requireAccess(from: viewController, to: type,
                                                                 with: {
                                                                  additionalAction?()
                                              })
        })
        return actionPlainObject
      }
    case .calendar:
      if !PermissionsManager.isAllowed(type: type) {
        actionPlainObject = ActionPlainObject(text: "Включите календарь, чтобы не пропустить событие".localized,
                                              imageName: "img_icon_calendar", action: {
                                                self.requireAccess(from: viewController, to: type,
                                                                   with: {
                                                                    additionalAction?()
                                                })
        })
        return actionPlainObject
      }
    case .notifications:
      if !PermissionsManager.isAllowed(type: type) {
        actionPlainObject = ActionPlainObject(text: "Включите оповещения, чтобы не пропустить анонсы".localized,
                                              imageName: "img_icon_notifications", action: {
                                                self.requireAccess(from: viewController, to: type,
                                                                   with: {
                                                                    additionalAction?()
                                                })
        })
        return actionPlainObject
      }
    case .photosLibrary, .camera:
      break
    }
    return nil
  }

  private func requireAccess(from viewController: UIViewController,
                             to type: PermissionsType, with action: Action?) {
      PermissionsManager.requireAccess(from: viewController,
                                       to: type, completion: { success in
                                        if success {
                                          DispatchQueue.main.async {
                                            action?()
                                          }
                                        }
      })
  }

  func modelForActionCell(with actionPlainObject: ActionPlainObject) -> ActionTableViewCellModel {
    return ActionTableViewCellModel(action: actionPlainObject)
  }
}
