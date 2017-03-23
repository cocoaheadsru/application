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
    completion: @escaping (_ displayCollection: FormDisplayCollection) -> Void) {
    Server.standard.request(EventRegFormPlainObject.Requests.form(with: id)) { form, error in
      if let error = error {
        print(error)
      }

      guard let form = form else {
        return
      }

      let formData = FormData(with: form)
      let displayCollection = FormDisplayCollection(with: formData)
      DispatchQueue.main.async {
        completion(displayCollection)
      }
    }
  }

}
