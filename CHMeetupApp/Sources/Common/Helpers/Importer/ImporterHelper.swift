//
//  ImporterHelper.swift
//  CHMeetupApp
//
//  Created by Kirill Averyanov on 02/05/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class ImporterHelper {
  static func importToSave(event: EventEntity?,
                           to type: ImportType,
                           from viewController: UIViewController,
                           with additionalAction: Action? = nil) {
    if let event = event {
      Importer.import(event: event, to: type, completion: { result in
        defer {
          additionalAction?()
        }

        switch result {
        case let .success(identifier):
          viewController.showMessageAlert(title: "Событие успешно добавлено".localized)
          realmWrite {
            switch type {
            case .calendar:
              event.importingState.calendarIdentifier = identifier
            case .reminder:
              event.importingState.reminderIdentifier = identifier
            }
          }
        case .permissionError:
          viewController.showMessageAlert(title: "Нет прав доступа".localized)
        case .saveError(error: _):
          viewController.showMessageAlert(title: "Ошибка сохранения".localized)
        }
      })
    } else {
      assertionFailure("No event entity")
    }
  }
}
