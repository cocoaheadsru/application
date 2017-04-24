//
//  AskQuestionViewController.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 16/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class AskQuestionViewController: UIViewController, ProfileHierarhyViewControllerType {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Задать вопрос".localized.uppercased()
    }
}
