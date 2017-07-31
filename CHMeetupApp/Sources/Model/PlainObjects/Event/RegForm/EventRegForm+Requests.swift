//
//  EventRegForm+Requests.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 07/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

extension EventRegFormPlainObject: PlainObjectType {

  struct Requests {
    static func form(with id: Int) -> Request<EventRegFormPlainObject> {
      let params = Constants.Server.baseParams
      return Request<EventRegFormPlainObject>(query: "event/active_form/\(id)", method: .post, params: params)
    }

    static func registration(with formData: FormData) -> Request<RequestPlainObject> {
      var registration = Constants.Server.baseParams
      registration["form"] = "\(formData.id)"

      for section in formData.sections {
        if let selectedAnswer = section.selectedAnswer, !selectedAnswer.isEmpty {
          registration["\(section.id)"] = selectedAnswer
        }
      }

      return Request<RequestPlainObject>(query: "event/registration", method: .post, params: registration)
    }
  }

  init?(json: JSONDictionary) {
    guard
      let id = json["id"] as? Int,
      let name = json["form_name"] as? String,
      let regFields = json["reg_fields"] as? [JSONDictionary]
    else { return nil }

    self.id = id
    self.name = name
    fields = regFields.flatMap(EventRegFormFieldPlainObject.init)
  }
}
