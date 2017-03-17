//
//  SpeakerTableViewCell.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 17.03.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class SpeakerTableViewCell: UITableViewCell {
  @IBOutlet weak var backplateView: UIView! {
    didSet {
      backplateView.layer.cornerRadius = 4
    }
  }
  @IBOutlet weak var avatarImageView: UIImageView! {
    didSet {
      avatarImageView.layer.cornerRadius = avatarImageView.bounds.size.height/2
    }
  }
  @IBOutlet weak var fullNameLabel: UILabel! {
    didSet {
      fullNameLabel.font = UIFont.appFont(.gothamPro(size: 16))
      fullNameLabel.textColor = UIColor(.black)
    }
  }
  @IBOutlet weak var speakerDescriptionLabel: UILabel! {
    didSet {
      speakerDescriptionLabel.font = UIFont.appFont(.systemFont(size: 14))
      speakerDescriptionLabel.textColor = UIColor(.darkGray) // should be #666666
    }
  }
  @IBOutlet weak var topicPreLabel: UILabel! {
    didSet {
      topicPreLabel.font = UIFont.appFont(.gothamPro(size: 15))
      topicPreLabel.textColor = UIColor(.black)
    }
  }
  @IBOutlet weak var topicLabel: UILabel! {
    didSet {
      topicLabel.font = UIFont.appFont(.systemFont(size: 17))
      topicLabel.textColor = UIColor(.black)
    }
  }
  @IBOutlet weak var seporatorLineView: UIView! {
    didSet {
      seporatorLineView.backgroundColor = UIColor(.lightGray)
    }
  }
  @IBOutlet weak var speachDescriptionLabel: UILabel! {
    didSet {
      speachDescriptionLabel.font = UIFont.appFont(.systemFont(size: 15))
      speachDescriptionLabel.textColor = UIColor(.darkGray) // should be #666666
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}
