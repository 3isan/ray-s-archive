//
//  AvatarView.swift
//  MyStats3
//
//  Created by Main Account on 5/11/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit

@IBDesignable
class AvatarView: UIView {
  
  let margin = CGFloat(10.0)
  let labelName = UILabel()
  let imageView = UIImageView()
  
  @IBInspectable var imageAvatar: UIImage? {
    didSet {
      configure()
    }
  }
  
  func setup() {

    // Setup image view
    imageView.contentMode = .ScaleAspectFit
    imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
    addSubview(imageView)
    
    // Setup label
    labelName.font = UIFont(name: "AvenirNext-Bold", size: 26.0)
    labelName.textColor = UIColor.blackColor()
    labelName.text = "Ray Wenderlich"
    labelName.setTranslatesAutoresizingMaskIntoConstraints(false)
    addSubview(labelName)
    
    labelName.setContentHuggingPriority(1000, forAxis: .Vertical)
    
    // Setup constraints
    let labelNameCenterX = NSLayoutConstraint(item: labelName, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0)
    let labelNameBottomY = NSLayoutConstraint(item: labelName, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0)
    NSLayoutConstraint.activateConstraints([labelNameCenterX, labelNameBottomY])

    let imageViewCenterX = NSLayoutConstraint(item: imageView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0)
    let imageViewTopY = NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: margin)
    let imageViewBottomY = NSLayoutConstraint(item: imageView, attribute: .Bottom, relatedBy: .Equal, toItem: labelName, attribute: .Top, multiplier: 1, constant: -margin)
    let imageViewWidth = NSLayoutConstraint(item: imageView, attribute: .Width, relatedBy: .Equal, toItem: imageView, attribute: .Height, multiplier: 1, constant: 0)
    NSLayoutConstraint.activateConstraints([imageViewCenterX, imageViewTopY, imageViewBottomY, imageViewWidth])

  }
  
  func configure() {
    
    // Configure image view
    imageView.image = imageAvatar
    
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
    configure()
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    setup()
    configure()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()    
  }
  
}
