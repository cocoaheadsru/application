//
//  StringContainerEntity.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 05/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation
import RealmSwift

class StringContainerEntity: Object {
  @objc dynamic var value: String = ""
}
