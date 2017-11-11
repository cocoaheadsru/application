//
//  Previewing.swift
//  CHMeetupApp
//
//  Created by Filipp Fediakov on 05.11.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

extension UIViewControllerPreviewingDelegate where Self: UIViewController {
  func registerForPreviewingIfAvailable() {
    if traitCollection.forceTouchCapability == .available {
      registerForPreviewing(with: self, sourceView: view)
    }
  }
}

protocol PreviewingContentProvider {
  func commitPreview(_ : UIViewController)
  func preview(at: IndexPath) -> UIViewController?
}
