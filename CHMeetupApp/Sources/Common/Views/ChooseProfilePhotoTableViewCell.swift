//
//  ChooseProfilePhotoTableViewCell.swift
//  CHMeetupApp
//
//  Created by Dmitriy Lis on 20/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

protocol ChooseProfilePhotoTableViewCellDelegate: class {
  func chooseProfilePhotoCell(_ cell: ChooseProfilePhotoTableViewCell)
}

class ChooseProfilePhotoTableViewCell: UITableViewCell {

  @IBOutlet var photoImageView: UIImageView!
  @IBOutlet var addImageView: UIImageView!

  private let photoBorder: CAShapeLayer = {
    let border = CAShapeLayer()
    border.strokeColor = UIColor.white.cgColor
    border.fillColor = UIColor.clear.cgColor
    return border
  }()

  private let addBorder: CAShapeLayer = {
    let border = CAShapeLayer()
    border.strokeColor = UIColor.white.cgColor
    border.fillColor = UIColor.clear.cgColor
    return border
  }()

  weak var delegate: ChooseProfilePhotoTableViewCellDelegate?

  @IBAction func chooseButtonAction(_ sender: Any) {
     delegate?.chooseProfilePhotoCell(self)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    photoImageView.roundCorners()
    addImageView.roundCorners()

    let lineWidth = (photoImageView.bounds.height * 0.08).round(0.5) // borderWidth = 4% of view height
    photoBorder.frame = photoImageView.bounds
    photoBorder.lineWidth = lineWidth
    photoBorder.path = UIBezierPath(ovalIn: photoBorder.bounds).cgPath

    addBorder.frame = addImageView.bounds
    addBorder.lineWidth = lineWidth
    addBorder.path = UIBezierPath(ovalIn: addBorder.bounds).cgPath
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    photoImageView.layer.addSublayer(photoBorder)
    addImageView.layer.addSublayer(addBorder)
    contentView.backgroundColor = UIColor(.lightGray)
    selectionStyle = .none
  }
}
