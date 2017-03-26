//
//  ActionCellConfigurationController.swift
//  CHMeetupApp
//
//  Created by Егор Петров on 25/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class ActionCellConfigurationController {

  var actionPlainObjects: [ActionPlainObject] = []

  // instantiate action block before checking permisson
  var action: (() -> Void)?

  // write what will be happen if will be successful request.
  var successfulRequest: (() -> Void)?

  // use it in ViewDidLoad after instantiation action
  func checkPermission() {
    if !PermissionsManager.isAllowed(type: .reminders) {
      let actionPlainObject = ActionPlainObject(text: "Включите оповещения чтобы не пропустить события".localized,
                                                imageName: "img_icon_notification",
                                                action:  action )
      actionPlainObjects.append(actionPlainObject)
    }
  }

  func modelForRemindersPermission(at indexPath: IndexPath) -> ActionTableViewCellModel {
    return ActionTableViewCellModel(action: actionPlainObjects[indexPath.row])
  }
}
