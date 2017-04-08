//
//  ProfileViewDisplayCollection.swift
//  CHMeetupApp
//
//  Created by Dmitriy Lis on 29/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

struct ProfileViewDisplayCollection: DisplayCollection {
  static var modelsForRegistration: [CellViewAnyModelType.Type] {
    return [UserTableViewHeaderCellModel.self,
            LabelTableViewCellModel.self]
  }

  enum `Type` {
    case userHeader
    case userContacts
  }

  var sections: [Type] = [.userHeader, .userContacts]

  var user: UserEntity {
    guard let user = UserPreferencesEntity.value.currentUser else {
      fatalError("Authorization error")
    }
    return user
  }

  var numberOfSections: Int {
    return sections.count
  }

  func numberOfRows(in section: Int) -> Int {
    switch sections[section] {
    case .userHeader:
      return 1
    case .userContacts:
      return user.contacts.count
    }
  }

  func model(for indexPath: IndexPath) -> CellViewAnyModelType {
    switch sections[indexPath.section] {
    case .userHeader:
      return UserTableViewHeaderCellModel(userEntity: user)
    case .userContacts:
      let key = Array(user.contacts.keys).sorted(by: > )[indexPath.row]
      let value = user.contacts[key] ?? ""
      return LabelTableViewCellModel(title: key, description: value)
    }
  }
}
