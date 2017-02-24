//
//  EventPreviewViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 23/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import UIKit

class EventPreviewViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  @IBAction func addToReminder(sender: UIButton) {
    ImportController.importEventTo(infoAboutEvent: EventPO(), toType: .reminder)
  }

  @IBAction func addToCalendar(sender: UIButton) {
    ImportController.importEventTo(infoAboutEvent: EventPO(), toType: .calendar)
  }

}
