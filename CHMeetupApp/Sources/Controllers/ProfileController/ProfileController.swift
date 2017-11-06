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
    guard let user = UserPreferencesEntity.value.currentUser else {
        completion(false)
        return
    }

    let request = RequestPlainObject.Requests.editProfile(name: user.name,
                                                          lastName: user.lastName,
                                                          email: user.email,
                                                          phone: user.phone,
                                                          company: user.company,
                                                          position: user.position)
    Server.standard.request(request) { response, _ in
      completion(response?.success ?? false)
    }
  }

  static func updateUser(withToken token: String, completion: @escaping SuccessCompletionBlock) {
    let profileRequest = UserPlainObject.Requests.profile(token: token)
    Server.standard.request(profileRequest) { userProfile, _ in
      guard let user = userProfile else {
        completion(false)
        return
      }

      guard let currentUser = UserPreferencesEntity.value.currentUser else {
        fatalError("Not found any active user")
      }

      realmWrite {
        currentUser.photoURL = user.photoUrl
        currentUser.position = user.position
        currentUser.company = user.company
        currentUser.statusValue = user.status
        currentUser.phone = user.phone
        currentUser.email = user.email ?? ""
      }
    }
  }
}
