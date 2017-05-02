//
//  ImportingStateEntity.swift
//  CHMeetupApp
//
//  Created by Kirill Averyanov on 02/05/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation
import RealmSwift

class ImportingState: Object {
  dynamic var toCalendar: Bool = false
  dynamic var toReminder: Bool = false
}
