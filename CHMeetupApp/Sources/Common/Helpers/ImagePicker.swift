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
  private let isCameraAvailable = UIImagePickerController.isSourceTypeAvailable(.camera)

  weak var delegate: ImagePickerDelegate?

  init(delegate: ImagePickerDelegate) {
    self.delegate = delegate
  }

  func getPhotoLibrary(on viewController: UIViewController, canEdit: Bool = true) {
    if !isPhotoLibraryAvailable { return }
    let type = kUTTypeImage as String

    imagePicker.sourceType = .photoLibrary
    imagePicker.allowsEditing = canEdit
    imagePicker.delegate = delegate
    if let availableTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary),
      availableTypes.contains(type) {
      imagePicker.mediaTypes = [type]
    }
    viewController.present(imagePicker, animated: true, completion: nil)
  }

  func getCamera(on viewController: UIViewController, canEdit: Bool = true) {
    if !isCameraAvailable { return }
    let type = kUTTypeImage as String

    imagePicker.sourceType = .camera
    imagePicker.allowsEditing = canEdit
    imagePicker.delegate = delegate
    if let availableTypes = UIImagePickerController.availableMediaTypes(for: .camera),
      availableTypes.contains(type) {
      imagePicker.mediaTypes = [type]
    }
    imagePicker.showsCameraControls = true
    viewController.present(imagePicker, animated: true, completion: nil)
  }

  static func checkImage(on viewController: UIViewController) {
    guard let delegate = viewController as? ImagePickerDelegate else {
      assertionFailure("Your ViewContoller must implement ImagePickerDelegate")
      return
    }
    let source = ImagePicker(delegate: delegate)
    let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

    let takePhoto = UIAlertAction(title: "Сделать снимок".localized, style: .default) { _ in
      source.getCamera(on: viewController)
    }
    let sharePhoto = UIAlertAction(title: "Выбрать из библиотеки".localized, style: .default) { _ in
      source.getPhotoLibrary(on: viewController)
    }
    let cancelAction = UIAlertAction(title: "Отмена".localized, style: .cancel)

    actionSheet.addAction(takePhoto)
    actionSheet.addAction(sharePhoto)
    actionSheet.addAction(cancelAction)
    DispatchQueue.main.async {
      viewController.present(actionSheet, animated: true, completion: nil)
    }
  }
  
}
