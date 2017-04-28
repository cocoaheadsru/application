//
//  ImagePicker.swift
//  CHMeetupApp
//
//  Created by Kirill Averyanov on 27/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit
import MobileCoreServices

typealias ImagePickerDelegate = UINavigationControllerDelegate & UIImagePickerControllerDelegate

final class ImagePicker {
  private let imagePicker = UIImagePickerController()
  private let isPhotoLibraryAvailable = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)

  weak var delegate: ImagePickerDelegate?

  init(delegate: ImagePickerDelegate) {
    self.delegate = delegate
  }

  func getPhotoLibrary(on viewController: UIViewController) {
    if !isPhotoLibraryAvailable { return }
    getSource(on: viewController, component: .photoLibrary)
  }

  private func getSource(on viewController: UIViewController, component: UIImagePickerControllerSourceType) {
    let type = kUTTypeImage as String

    imagePicker.sourceType = component
    imagePicker.allowsEditing = true
    imagePicker.delegate = delegate
    if let availableTypes = UIImagePickerController.availableMediaTypes(for: component),
      availableTypes.contains(type) {
      imagePicker.mediaTypes = [type]
    }
    viewController.present(imagePicker, animated: true, completion: nil)
  }

  static func checkImage(on viewController: UIViewController) {
    guard let delegate = viewController as? ImagePickerDelegate else {
      assertionFailure("Your ViewContoller must implement ImagePickerDelegate")
      return
    }
    let source = ImagePicker(delegate: delegate)
    source.getPhotoLibrary(on: viewController)
  }
}
