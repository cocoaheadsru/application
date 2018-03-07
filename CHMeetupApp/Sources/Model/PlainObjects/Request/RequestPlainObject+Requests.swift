//
//  RequestPlainObject+Requests.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 05/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

extension RequestPlainObject: PlainObjectType {

  enum RequestError: String {
    case accessForbidden
    case notFound
    case failedRequest
  }

  init?(json: JSONDictionary) {
    guard
      let code = json["code"] as? Int,
      let answer = json["answer"] as? String
      else { return nil }

    self.code = code
    self.answer = answer

    if let error = json["error"] as? String {
      self.error = RequestError(rawValue: error)
      self.success = false
    } else {
      self.success = true
      self.error = nil
    }
  }
}

extension RequestPlainObject {

  struct Requests {

    // swiftlint:disable:next function_parameter_count
    static func editProfile(name: String,
                            lastName: String,
                            email: String,
                            phone: String?,
                            company: String?,
                            position: String?) -> Request<RequestPlainObject> {
      var params: [String: String] = [:]

      params["name"] = name
      params["last_name"] = lastName
      params["email"] = email
      params["phone"] = phone ?? ""
      params["company"] = company ?? ""
      params["position"] = position ?? ""
      return Request(query: "user/edit",
                     method: .post,
                     params: params)
    }

    static func giveSpeech(title: String,
                           description: String,
                           userId: Int,
                           token: String) -> Request<RequestPlainObject> {
      let params = ["title": title, "description": description]

      return Request(query: "user/givespeech",
                     method: .post,
                     params: params)
    }

    static func registerPush(pushToken: String) -> Request<RequestPlainObject> {
      let params = ["push_token": pushToken]

      return Request(query: "user/register_push",
                     method: .post,
                     params: params)
    }

    static func updatePhoto(photo: Data) -> Request<RequestPlainObject> {
      let params = ["photo": photo.base64EncodedString()]

      return Request(query: "user/update_photo",
                     method: .post,
                     params: params)
    }
  }
}
