//
//  PlateTableViewCell.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 11/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

// Working from xib only
class PlateTableViewCell: UITableViewCell {

  enum RoundType {
    case none, topRounded, bottomRounded, allRounded
  }

  // For UIAppearance proxy
  dynamic var plateAppearance: PlateTableViewCellAppearance {
    set {
      plateCornerRadius = newValue.cornerRadius
      plateMarginValue = newValue.marginValue
    }
    get {
      return PlateTableViewCellAppearance(cornerRadius: plateCornerRadius, marginValue: plateMarginValue)
    }
  }

  private var plateCornerRadius: CGFloat = 0
  private var plateMarginValue: CGFloat = 0

  struct Apperance {
    static var defaultSpace: CGFloat = 8
    static var defaultCornerRadius: CGFloat = 8
  }

  var roundType: RoundType = .none {
    didSet {
      updateRoundShape()
    }
  }

  override var frame: CGRect {
    didSet {
      updateRoundShape()
    }
  }

  private let shape: CAShapeLayer = CAShapeLayer()
  private let selectionShape: CAShapeLayer = CAShapeLayer()

  override func awakeFromNib() {
    super.awakeFromNib()

    self.selectedBackgroundView = UIView()
    self.selectedBackgroundView?.backgroundColor = UIColor(.red)
    self.selectedBackgroundView?.layer.mask = selectionShape

    self.contentView.layoutMargins.left += Apperance.defaultSpace
    self.contentView.layoutMargins.right += Apperance.defaultSpace
  }

  private func updateRoundShape() {
    let frame = CGRect(x: Apperance.defaultSpace,
                       y: 0,
                       width: self.frame.width - Apperance.defaultSpace * 2,
                       height: self.frame.height)

    let path: UIBezierPath
    if let cornersType = cornersType {
      path = UIBezierPath(roundedRect: frame,
                          byRoundingCorners: cornersType,
                          cornerRadii: CGSize(width: Apperance.defaultCornerRadius,
                                              height: Apperance.defaultCornerRadius))
    } else {
      path = UIBezierPath(roundedRect: frame,
                          cornerRadius: Apperance.defaultCornerRadius)
    }

    shape.path = path.cgPath
    shape.fillColor = UIColor.clear.cgColor
    shape.strokeColor = UIColor(.red).cgColor

    selectionShape.path = path.cgPath
    selectionShape.fillColor = UIColor(.red).cgColor
  }

  private var cornersType: UIRectCorner? {
    switch roundType {
    case .topRounded:
      return [.topLeft, .topRight]
    case .bottomRounded:
      return [.bottomLeft, .bottomRight]
    case .allRounded:
      return .allCorners
    case .none:
      return nil
    }
  }

}
