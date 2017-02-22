//
//  ProfileHierarhyViewControllerType.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 23/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import UIKit

protocol ProfileHierarhyViewControllerType: class {
  
}

extension ProfileHierarhyViewControllerType where Self: UIViewController {
  var profileNavigationController: ProfileNavigationControllerType? {
    return navigationController as? ProfileNavigationControllerType
  }
}
