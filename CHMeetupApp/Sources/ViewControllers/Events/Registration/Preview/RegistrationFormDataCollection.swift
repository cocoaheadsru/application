//
//  RegistrationFormDataCollection.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 05.03.17.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import Foundation

class FormDataCollection {

  static func loadRegFromServer(with id: Int,
                                complitionBlock: @escaping (_ form: EventRegFormPlainObject) ->
    Void) {
    // FIXME: - just for test, delete after linking with real model
    Server.standard.request(EventRegFormPlainObject.Requests.form(with: id)) { form, error in
      if let error = error {
        print(error)
      }
      if form != nil {
        complitionBlock(form!)
      }
    }
  }
}
