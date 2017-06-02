//
//  ProfileController.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 04/05/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

class ProfileController {
  static func save(completion: @escaping SuccessCompletionBlock) {
    guard let user = UserPreferencesEntity.value.currentUser,
      let token = user.token else {
        completion(false)
        return
    }

    let request = RequestPlainObject.Requests.editProfile(token: token,
                                                          email: user.email,
                                                          phone: user.phone,
                                                          company: user.company,
                                                          position: user.position)
    Server.standard.request(request) { response, _ in
      completion(response?.success ?? false)
    }
  }

  static func updateUser(with token: String, completion: @escaping SuccessCompletionBlock) {
    let profileRequest = UserPlainObject.Requests.profile(token: token)
    Server.standard.request(profileRequest) { userProfile, error in
      guard let user = userProfile else {
        completion(false)
        return
      }

      LoginProcessController.setCurrentUser(user)
    }
  }
}
