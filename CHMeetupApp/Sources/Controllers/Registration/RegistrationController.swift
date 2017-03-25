//
//  RegistrationController.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 19.03.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

class RegistrationController {

  static func loadRegFromServer(
    with id: Int,
    completion: @escaping (_ displayCollection: FormDisplayCollection?, _ error: ServerError?) -> Void) {
    Server.standard.request(EventRegFormPlainObject.Requests.form(with: id)) { form, error in

      guard error == nil else {
        DispatchQueue.main.async {
          completion(nil, error)
        }
        return
      }

      guard let form = form else {
        return
      }

      let formData = FormData(with: form)
      let displayCollection = FormDisplayCollection(formData: formData)
      DispatchQueue.main.async {
        completion(displayCollection, nil)
      }
    }
  }
}
