//
//  ActionCellConfigurationController.swift
//  CHMeetupApp
//
//  Created by Егор Петров on 25/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

typealias Action = () -> Void

class ActionCellConfigurationController {

  private let importerHelper: ImporterHelper

  init(importerHelper: ImporterHelper = ImporterHelperProvider()) {
    self.importerHelper = importerHelper
  }

  func createImportAction(for event: EventEntity,
                          on viewController: UIViewController,
                          for importType: ImportType,
                          with additionalAction: Action? = nil) -> ActionPlainObject? {
    let importToPermission: [ImportType: PermissionsType] = [.calendar: .calendar,
                                                             .reminder: .reminders]
    guard let permission = importToPermission[importType] else {
      assertionFailure("No such permission")
      return nil
    }
    guard !importerHelper.isEventInStorage(event, type: importType) else {
      return nil
    }

    return addActionCell(on: viewController, for: permission, with: { [weak self, weak viewController] in
      guard let vc = viewController else {
        assertionFailure("view controller did release already")
        return
      }
      self?.importerHelper.importToSave(event: event, to: importType, from: vc) {
        additionalAction?()
      }
    })
  }

  private func addActionCell(on viewController: UIViewController,
                             for type: PermissionsType,
                             with additionalAction: Action?) -> ActionPlainObject? {
    var actionPlainObject: ActionPlainObject?

    let texts: [PermissionsType: String] = [.calendar: "Добавить в календарь".localized,
                                            .reminders: "Добавить в напоминания".localized]
    let imagesNames: [PermissionsType: String] = [.calendar: "img_icon_calendar",
                                                  .reminders: "img_icon_reminders"]

    if let text = texts[type] {
      let imageName = imagesNames[type]
      actionPlainObject = ActionPlainObject(
        text: text,
        imageName: imageName, action: { [weak self, weak viewController] in
          guard let vc = viewController else {
            assertionFailure("view controller did release already")
            return
          }

          self?.requireAccess(from: vc, to: type,
                             with: {
                              additionalAction?()
          })
      })
    } else {
      assertionFailure("No such permission")
    }

    return actionPlainObject
  }

  private func requireAccess(from viewController: UIViewController,
                             to type: PermissionsType, with action: Action?) {
    PermissionsManager.requireAccess(
      from: viewController,
      to: type, completion: { success in
        if success {
          DispatchQueue.main.async {
            action?()
          }
        }
    })
  }

  private func modelForActionCell(with actionPlainObject: ActionPlainObject) -> ActionTableViewCellModel {
    return ActionTableViewCellModel(action: actionPlainObject)
  }
}
