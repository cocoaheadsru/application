//
//  POType.swift
//  CHMeetupApp
//
//  Created by Sam on 28/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import Foundation
typealias JSONDictionary = [String: Any]

protocol POType {
  associatedtype RequestsEnum
  init?(json: JSONDictionary)
}
