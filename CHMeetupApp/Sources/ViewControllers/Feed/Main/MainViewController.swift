//
//  MainViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 22/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Main".localized
    // Do any additional setup after loading the view.
  }

  @IBAction func showEventAction(_ sender: UIButton) {
    navigationController?.pushViewController(ViewControllersFactory.eventPreviewViewController, animated: true)
  }

  override func customTabBarItemContentView() -> CustomTabBarItemView {
    return TabBarItemView.create(with: .main)
  }
}
