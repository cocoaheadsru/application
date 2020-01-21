//
//  UIColor+asImage.swift
//  CHMeetupApp
//
//  Created by Ярослав Попов on 07.01.2020.
//  Copyright © 2020 CocoaHeads Community. All rights reserved.
//

import UIKit

extension UIColor {
  var asImage: UIImage {
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context!.setFillColor(self.cgColor)
    context!.fill(rect)
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return img!
  }
}
