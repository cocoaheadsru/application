//
//  PushHandler.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 18/07/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

typealias PushSequence = [AnyHashable : Any]

final class PushHandler {

  private static let actionKey = "action"
  private var router: UniversalRouter?

  enum PushActionType {
    case updateRegistrationState
    case unknown
  }

  func handle(data: PushSequence, via router: UniversalRouter) {
    self.router = router
    let actionType = determinateAction(from: data)

    switch actionType {
    case .updateRegistrationState:
      registrationStatePush(data: data)
    case .unknown:
      fatalError("Unknown action for push")
    }
  }

  // MARK: - Private methods

  private  func determinateAction(from data: PushSequence) -> PushActionType {
    guard let action = data[PushHandler.actionKey] as? String else {
      return .unknown
    }

    switch action {
    case "update_registration_state":
      return .updateRegistrationState
    case "test_state":
      return .unknown
    default:
      return .unknown
    }
  }

  private func registrationStatePush(data: PushSequence) {
    guard
      let eventId = data["eventId"] as? Int,
      let status = data["status"] as? String
    else { return }

    router?.activate(section: .anonses)
    router?.updateAnonseStatus(for: eventId, status: status)
  }

}
