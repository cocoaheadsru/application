//
//  ProfileEditDisplayCollection.swift
//  CHMeetupApp
//
//  Created by Kirill Averyanov on 18/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class ProfileEditDisplayCollection: DisplayCollection {
  static var modelsForRegistration: [CellViewAnyModelType.Type] {
    return [ChooseProfilePhotoTableViewCellModel.self,
            LabelTableViewCellModel.self]
  }

  enum `Type` {
    case userHeader
    case userContacts
  }

  fileprivate var sections: [Type] = [.userHeader, .userContacts]

  var user: UserEntity!

  weak var delegate: ProfileHierarhyViewControllerType?

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
      return ChooseProfilePhotoTableViewCellModel(userEntity: user, delegate: self)
    case .userContacts:
      let key = Array(user.contacts.keys).sorted(by: > )[indexPath.row]
      let value = user.contacts[key] ?? ""
      return LabelTableViewCellModel(title: key, description: value)
    }
  }
}

extension ProfileEditDisplayCollection: ChooseProfilePhotoTableViewCellDelegate {
  func chooseProfilePhotoCellDidPressOnPhoto(_ cell: ChooseProfilePhotoTableViewCell) {
    let viewController = delegate?.getViewController()
    if let viewController = viewController as? ProfileEditViewController {
      PermissionsManager.requireAccess(from: viewController, to: .photosLibrary,
                                       completion: { _ in
                                        ImagePickerController.showImagePicker(on: viewController)
      })
    }
  }

  func didReciveMedia(_ picker: UIImagePickerController, info: [String : Any]) {
    if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
      changeCheckedImage(image: image)
    }
    picker.dismiss(animated: true, completion: nil)
  }

  func changeCheckedImage(image: UIImage) {
    // TODO: - Load image
  }
}
