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
        summary.text = data.summary
        flightNr.text = data.flightNr
        gateNr.text = data.gateNr
        departingFrom.text = data.departingFrom
        arrivingTo.text = data.arrivingTo
        flightStatus.text = data.flightStatus
        bgImageView.image = UIImage(named: data.weatherImageName)
        snowView.hidden = !data.showWeatherEffects
        
        //
        // schedule next flight
        //
        
        delay(seconds: 3) {
            self.changeFlightDataTo(data.isTakingOff ? parisToRome : londonToParis)
        }
    }
    
}

