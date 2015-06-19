//
//  ViewController.swift
//  flight-demo
//
//  Created by Marin Todorov on 7/31/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit
import QuartzCore

//
// Util delay function
//
func delay(#seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

enum AnimationDirection: Int {
  case Positive = 1
  case Negative = -1
}

//
// View controller methods
//
class ViewController: UIViewController {

    @IBOutlet var bgImageView: UIImageView!
    
    var snowView: SnowView!

    @IBOutlet var summaryIcon: UIImageView!
    @IBOutlet var summary: UILabel!
    
    @IBOutlet var flightNr: UILabel!
    @IBOutlet var gateNr: UILabel!
    @IBOutlet var departingFrom: UILabel!
    @IBOutlet var arrivingTo: UILabel!
    @IBOutlet var planeImage: UIImageView!
    
    @IBOutlet var flightStatus: UILabel!
    @IBOutlet var statusBanner: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //adjust ui
        statusBanner.addSubview(flightStatus)
        summary.addSubview(summaryIcon)
        summaryIcon.center.y = summary.frame.size.height/2
        
        //add the snow effect layer
        snowView = SnowView(frame: CGRect(x: -150, y:-100, width: 300, height: 50))
        let snowClipView = UIView(frame: CGRectOffset(view.frame, 0, 50))
        snowClipView.clipsToBounds = true
        snowClipView.addSubview(snowView)
        view.addSubview(snowClipView)
        
        //start rotating the flights
        changeFlightDataTo(londonToParis)
    }
    
    func changeFlightDataTo(data: FlightData) {

        //
        // populate the UI with the next flight's data
        //
        summary.text = data.summary as String
        flightNr.text = data.flightNr as String
        gateNr.text = data.gateNr as String
        departingFrom.text = data.departingFrom as String
        arrivingTo.text = data.arrivingTo as String
        flightStatus.text = data.flightStatus as String
        bgImageView.image = UIImage(named: data.weatherImageName as String)
        snowView.hidden = !data.showWeatherEffects
        
        //
        // schedule next flight
        //
        
        delay(seconds: 3) {
            self.changeFlightDataAnimatedTo(data.isTakingOff ? parisToRome : londonToParis)
        }
    }
  
  func changeFlightDataAnimatedTo(data: FlightData) {
    
    fadeImageView(bgImageView, toImage: UIImage(named: data.weatherImageName as String)!, showEffects: data.showWeatherEffects)
    
    let direction: AnimationDirection = data.isTakingOff ? .Positive : .Negative
    cubeTransition(flightNr, text: data.flightNr as String, direction: direction)
    cubeTransition(gateNr, text: data.gateNr as String, direction: direction)
    
    let offsetDeparting = CGPoint(x: direction == .Positive ? 80: -80, y: 0)
    let offsetArriving  = CGPoint(x: 0, y: direction == .Positive ? -50: 50)
    
    moveLabel(departingFrom, text: data.departingFrom as String, offset: offsetDeparting)
    moveLabel(arrivingTo, text: data.arrivingTo as String, offset: offsetArriving)
    
    delay(seconds: 3) {
      self.changeFlightDataAnimatedTo(data.isTakingOff ? parisToRome : londonToParis)
    }

  }
  
  func fadeImageView(imageView: UIImageView, toImage: UIImage, showEffects: Bool) {
    
    let newImageView = UIImageView(image: toImage)
    newImageView.frame = view.frame
    newImageView.alpha = 0.0
    
    view.insertSubview(newImageView, aboveSubview: imageView)
    
    UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseOut, animations: {
      newImageView.alpha = 1.0
      self.snowView.alpha = showEffects ? 1.0: 0.0
    }, completion: {_ in
      
      imageView.image = newImageView.image
      newImageView.removeFromSuperview()
    })
    
  }
  
  func cubeTransition(label: UILabel, text: String, direction: AnimationDirection) {
    let originalFrame = label.frame
    
    let newLabel = UILabel(frame: originalFrame)
    newLabel.text = text
    newLabel.font = label.font
    newLabel.textAlignment = label.textAlignment
    newLabel.textColor = label.textColor
    newLabel.backgroundColor = UIColor.clearColor()
    
    let newLabelOffset = CGFloat(direction.rawValue) * originalFrame.size.height/2
    
    newLabel.transform = CGAffineTransformConcat(
      CGAffineTransformMakeScale(1, 0),
      CGAffineTransformMakeTranslation(0, newLabelOffset)
    )
    
    view.addSubview(newLabel)
    
    //animate the label
    
    UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: {
      
      newLabel.transform = CGAffineTransformIdentity
      label.transform = CGAffineTransformConcat(
        CGAffineTransformMakeScale(1, 0.1),
        CGAffineTransformMakeTranslation(0, -newLabelOffset))
      
    }, completion: {_ in
      
      label.text = newLabel.text
      label.transform = CGAffineTransformIdentity
      
      newLabel.removeFromSuperview()
      
    })
    
  }
  
  func moveLabel(label: UILabel, text: String, offset: CGPoint) {
    
    let originalFrame = label.frame
    
    let newLabel = UILabel(frame:  originalFrame)
    newLabel.text = text
    newLabel.font = label.font
    newLabel.textAlignment = label.textAlignment
    newLabel.textColor = label.textColor
    newLabel.backgroundColor = UIColor.clearColor()
    
    newLabel.transform = CGAffineTransformMakeTranslation(offset.x, offset.y)
    newLabel.alpha = 0.0
    view.addSubview(newLabel)
    
    UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: {
      label.transform = CGAffineTransformMakeTranslation(offset.x, offset.y)
      label.alpha = 0.0
    }, completion: nil)
    
    UIView.animateWithDuration(0.25, delay: 0.25, options: .CurveEaseIn, animations: {
      
      newLabel.transform = CGAffineTransformIdentity
      newLabel.alpha = 1.0
      
    }, completion: {_ in
    
      newLabel.removeFromSuperview()
      
      label.text = newLabel.text
      label.transform = CGAffineTransformIdentity
      label.alpha = 1.0
      
    })
    
  }
  
}

