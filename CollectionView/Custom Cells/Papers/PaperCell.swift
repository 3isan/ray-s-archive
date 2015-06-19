//
//  PaperCell.swift
//  Papers
//
//  Created by Mic Pringle on 09/01/2015.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit

class PaperCell: UICollectionViewCell {
  
  @IBOutlet private weak var paperImageView: UIImageView!
  @IBOutlet private weak var gradientView: GradientView!
  @IBOutlet private weak var captionLabel: UILabel!
  
  var paper: Paper? {
    didSet {
      if let paper = paper {
        paperImageView.image = UIImage(named: paper.imageName)
        captionLabel.text = paper.caption
      }
    }
  }
  
}
