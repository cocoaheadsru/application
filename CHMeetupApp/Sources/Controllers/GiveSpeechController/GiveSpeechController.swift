//
//  GiveSpeechController.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 20/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

class GiveSpeechController {
  static func sendRequest(title: String, description: String, completion: @escaping (Bool) -> Void) {
    let currentUser = UserPreferencesEntity.value.currentUser
    guard let userId = currentUser?.remoteId,
          let token = currentUser?.token
      else {
        return
    }

    let request = RequestPlainObject.giveSpeech(title: title,
                                                description: description,
                                                userId: userId,
                                                token: token)
    Server.standard.request(request) { answer, _ in
      let success = answer?.success ?? false
      completion(success)
    }
  }
}
