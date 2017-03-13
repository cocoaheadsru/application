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
    case none, top, bottom, all

    var cornersType: UIRectCorner? {
      switch self {
      case .top:
        return [.topLeft, .topRight]
      case .bottom:
        return [.bottomLeft, .bottomRight]
      case .all:
        return .allCorners
      case .none:
        return []
      }
    }
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
  private var defaultLayoutMargins = UIEdgeInsets.zero

  override func awakeFromNib() {
    super.awakeFromNib()

    layer.insertSublayer(shape, at: 0)

    defaultLayoutMargins = contentView.layoutMargins

    backgroundColor = UIColor.clear
    contentView.backgroundColor = UIColor.clear
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    updateSelection(shouldSelect: selected)
  }

  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    updateSelection(shouldSelect: highlighted)
  }

  func updateSelection(shouldSelect: Bool) {
    guard let plateAppearance = plateAppearanceValue else { return }
    if isSelected || isHighlighted || shouldSelect {
      shape.fillColor = plateAppearance.selectedBackgroundColor.cgColor
    } else {
      shape.fillColor = plateAppearance.backgroundColor.cgColor
    }
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
    guard let plateAppearance = plateAppearanceValue else { return }

    var verticalMarginValues: CGFloat = 0
    if shouldHaveVerticalMargin {
      verticalMarginValues = plateAppearance.verticalMarginValues
    }

    let frame = CGRect(x: plateAppearance.horizontalMarginValue,
                       y: verticalMarginValues,
                       width: self.frame.width - plateAppearance.horizontalMarginValue * 2,
                       height: self.frame.height - verticalMarginValues * 2)

    let path: UIBezierPath
    if let cornersType = roundType.cornersType {
      path = UIBezierPath(roundedRect: frame,
                          byRoundingCorners: cornersType,
                          cornerRadii: CGSize(width: plateAppearance.cornerRadius,
                                              height: plateAppearance.cornerRadius))
    } else {
      path = UIBezierPath(rect: frame)
    }

    shape.path = path.cgPath
  }
}
