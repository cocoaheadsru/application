//
//  ActionCellConfigurationControllerLeakTests.swift
//  CHMeetupAppTests
//
//  Created by Chingis Gomboev on 05/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import XCTest
@testable import CHMeetupApp

// swiftlint:disable type_name
final class ActionCellConfigurationControllerLeakTests: XCTestCase {
// swiftlint:enable type_name

  weak var viewController: UIViewController?
  weak var actionCell: ActionCellConfigurationController?
  var actionObject: ActionPlainObject?

  override func tearDown() {
    super.tearDown()
    XCTAssertNil(actionCell, "ActionCell retail self, so its retain cycle leak")
    XCTAssertNil(viewController, "viewController still alive, its retain cycle leak")

    self.actionObject = nil
  }

  func testMemoryLeak() {

    // GIVEN
    class ImporterHelpMock: ImporterHelper {
      var vc: UIViewController?
      func importToSave(event: EventEntity?,
                        to type: ImportType,
                        from viewController: UIViewController,
                        with additionalAction: Action?) {
        self.vc = viewController
      }
      func isEventInStorage(_ event: EventEntity, type: ImportType) -> Bool {
        return false
      }
    }

    let event = EventEntity.templateEntity
    let actionCell = ActionCellConfigurationController(importerHelper: ImporterHelpMock())
    self.actionCell = actionCell
    let vc = UIViewController()
    self.viewController = vc

    // WHEN
    self.actionObject = actionCell.createImportAction(for: event,
                                          on: vc,
                                          for: .calendar) {}

    // THEN
    // Checking LEAK of actionCell & viewController in tearDown() func,
    // it's easiest way to keep this test synchronous
  }

}
