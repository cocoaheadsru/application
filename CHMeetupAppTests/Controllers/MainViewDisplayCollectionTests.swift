//
//  MainViewDisplayCollectionTests.swift
//  CHMeetupAppTests
//
//  Created by Chingis Gomboev on 06/08/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import XCTest
@testable import CHMeetupApp
import RealmSwift

final class MainViewDisplayCollectionTests: XCTestCase {

  var controller: MainViewDisplayCollection!

  override func setUp() {
    super.setUp()

    controller = MainViewDisplayCollection()
  }

  func testNeedShowSwitchCell() {

    // GIVEN
    controller.modelCollection = TemplateModelCollection<EventEntity>(list: eventList())

    // WHEN
    let need = controller.needShowSwitchCell()

    // THEN
    XCTAssert(controller.modelCollection.count == 2, "modelCollection has incorrect objects count")
    XCTAssert(need, "incorrect value for showing swift cell")
  }

  private func eventList() -> List<EventEntity> {
    let list = List<EventEntity>()
    list.append({
      let event = EventEntity.templateEntity
      event.id = 1
      return event
    }())
    list.append({
      let event = EventEntity.templateEntity
      event.id = 2
      event.status = .approved
      event.startDate = Date()
      return event
      }())
    return list
  }
}
