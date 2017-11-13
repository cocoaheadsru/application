//
//  Previewing.swift
//  CHMeetupApp
//
//  Created by Filipp Fediakov on 05.11.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

extension UIViewControllerPreviewingDelegate where Self: UIViewController {
  @discardableResult
  func registerForPreviewing() -> Bool {
    if traitCollection.forceTouchCapability == .available {
      registerForPreviewing(with: self, sourceView: view)
      return true
    } else {
      return false
    }
  }
}

protocol PreviewingContentProvider {
  func commitPreview(_ : UIViewController)
  func preview(at: IndexPath) -> UIViewController?
}

extension UIViewControllerPreviewingDelegate where Self: UIViewControllerWithTableView {
  func previewingContextProvided(by contentProvider: PreviewingContentProvider,
                                 at location: CGPoint,
                                 previewingContext: UIViewControllerPreviewing) -> UIViewController? {
    guard let indexPath = tableView.indexPathForRow(at: location),
      let viewController = contentProvider.preview(at: indexPath) else {
        return nil
    }

    let sourceRect = tableView.rectForRow(at: indexPath)
    previewingContext.sourceRect = sourceRect
    return viewController
  }
}

extension UIViewControllerPreviewingDelegate {
  func commitPreview(by contentProvider: PreviewingContentProvider,
                     viewController: UIViewController) {
    contentProvider.commitPreview(viewController)
  }
}
