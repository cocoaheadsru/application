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

  private var plateAppearanceValue: PlateTableViewCellAppearance? {
    didSet {
      updateAppearance()
    }
  }

  // For UIAppearance proxy
  dynamic var plateAppearance: PlateTableViewCellAppearance? {
    set {
      plateAppearanceValue = newValue
    }
    get {
      return plateAppearanceValue
    }
  }

  private var plateCornerRadius: CGFloat = 0
  private var plateMarginValue: CGFloat = 0

  var roundType: RoundType = .none {
    didSet {
      if oldValue != roundType {
        setNeedsUpdateAppearance()
      }
    }
  }

  var shouldHaveVerticalMargin: Bool = true {
    didSet {
      if oldValue != shouldHaveVerticalMargin {
        setNeedsUpdateAppearance()
      }
    }
  }

  override var frame: CGRect {
    didSet {
      updateRoundShape()
    }
  }

  private let shape: CAShapeLayer = CAShapeLayer()
  private let selectionShape: CAShapeLayer = CAShapeLayer()

  private var defaultLayoutMargins = UIEdgeInsets.zero

  override func awakeFromNib() {
    super.awakeFromNib()

    layer.addSublayer(shape)

    selectedBackgroundView = UIView()
    selectedBackgroundView?.backgroundColor = UIColor(.red)
    selectedBackgroundView?.layer.mask = selectionShape

    defaultLayoutMargins = contentView.layoutMargins

    backgroundColor = UIColor.clear
    contentView.backgroundColor = UIColor.clear
  }

  // Optimization part
  private var needUpdateAppearance = false
  private func setNeedsUpdateAppearance() {
    if needUpdateAppearance == false {
      OperationQueue.main.addOperation { [weak self] in
        self?.updateAppearance()
      }
      needUpdateAppearance = true
    }

  }

  private func updateAppearance() {
    needUpdateAppearance = false

    guard let plateAppearance = plateAppearanceValue else {
      return
    }

    var newMargins = defaultLayoutMargins
    newMargins.left += plateAppearance.horizontalMarginValue
    newMargins.right += plateAppearance.horizontalMarginValue

    if shouldHaveVerticalMargin {
      newMargins.top += plateAppearance.verticalMarginValues
      newMargins.bottom += plateAppearance.verticalMarginValues
    }

    contentView.layoutMargins = newMargins
    updateRoundShape()
  }

  private func updateRoundShape() {
    guard let plateAppearance = plateAppearanceValue else {
      return
    }

    let frame = CGRect(x: plateAppearance.horizontalMarginValue,
                       y: plateAppearance.verticalMarginValues,
                       width: self.frame.width - plateAppearance.horizontalMarginValue * 2,
                       height: self.frame.height - plateAppearance.verticalMarginValues * 2)

    let path: UIBezierPath
    if let cornersType = cornersType {
      path = UIBezierPath(roundedRect: frame,
                          byRoundingCorners: cornersType,
                          cornerRadii: CGSize(width: plateAppearance.cornerRadius,
                                              height: plateAppearance.cornerRadius))
    } else {
      path = UIBezierPath(rect: frame)
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
      return []
    }
  }

}
