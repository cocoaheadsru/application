//
//  String+Empty.swift
//  CHMeetupApp
//
//  Created by Dmitriy Lis on 08/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

extension String {
  var ifNotEmpty: String? {
    if self.isEmpty {
      return nil
    }
    return self
  }
}
