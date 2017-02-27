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
    Importer.import(event: EventPO(), to: .reminder) { result in
      switch result {
      case .success:
        print("Added")
      case .permissionError:
        print("Show settings alert")
      case .saveError(let error):
        print("Error alert: \(error)")
      }
    }
  }

  @IBAction func addToCalendar(sender: UIButton) {
    Importer.import(event: EventPO(), to: .calendar) { result in
      switch result {
      case .success:
        print("Added")
      case .permissionError:
        print("Show settings alert")
      case .saveError(let error):
        print("Error alert: \(error)")
      }
    }
  }

}
