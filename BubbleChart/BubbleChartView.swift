//
//  BubbleChartView.swift
//  BubbleChart
//
//  Created by Ales Olasz on 12/07/2016.
//  Copyright © 2016 ViralIdeasLtd. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    
    class func alkalineColor() -> UIColor{
        return UIColor(red:194.0/255.0, green:60.0/255.0, blue:159.0/255.0, alpha:1.0)
    }
    class func acidicColor() -> UIColor{
        return UIColor(red:220.0/255.0, green:210.0/255.0, blue:75.0/255.0, alpha:1.0)
    }
    class func balanzColor() -> UIColor{
        return UIColor(red:91.0/255.0, green:136.0/255.0, blue:15.0/255.0, alpha:1.0)
    }
}


class BubbleChartView: UIView {
    
    let fr = UIScreen.mainScreen().bounds
    
    var arrayOfValues: Array<String>!
    
    init() {
        
        // set up for landscape
        super.init(frame: CGRectMake(0, 0, fr.height, fr.width))
        
        return
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")
    }
    
    override class func layerClass() -> AnyClass {
        return CAGradientLayer.self
    }
    
    override func drawRect(rect: CGRect) {
        
        let view = UIView(frame: rect)
        
        // background gradient color
        let grad = CAGradientLayer()
        grad.frame = view.bounds
        
        let topColor = UIColor(red: 40.0/255.0, green: 60.0/255.0, blue: 0.0/255.0, alpha: 1.0) as UIColor
        let bottomColor = UIColor(red: 25.0/255.0, green: 40.0/255.0, blue: 0.0/255.0, alpha: 1.0) as UIColor
        
        let colorsArr: Array <AnyObject> = [topColor.CGColor, bottomColor.CGColor]
        let gradLocationsArr = [0.0, 1.0]
        
        grad.colors = colorsArr
        grad.locations = gradLocationsArr
        
        view.layer.insertSublayer(grad, atIndex: 0)
        self.addSubview(view)
        
        
        self.showBubbleChart(self.arrayOfValues)
    }
    
    func showBubbleChart(vals: Array<String>){
    
        print("vals: \(vals)")
        // vals : 0.0 format where:    balance = 3;   alkaline > 3;   acidic < 3
        
        // calculate grid = week = 7 days + 1 space for label
        let xSections = fr.height/8
        let halfXsection = xSections / 2
        let yPoint = fr.width / 2
        
        // ------------------------              SET UP BUBBLE CHART
        
        let dayz = ["Blnz", "Mo", "Tue", "We", "Thu", "Fri", "Sat", "Sun"]
        
        // add day labels
        for i in 0..<8{
        
            let lbl = UILabel(frame: CGRectMake(xSections * CGFloat(i), fr.width - 45, xSections, 45))
            lbl.textAlignment = .Center
            lbl.textColor = UIColor.whiteColor()
            lbl.text = dayz[i]
            
            // first label not a day value, set it in the middle
            if i == 0{
                lbl.frame = CGRectMake(0, yPoint - 23, xSections, 45)
                lbl.alpha = 0.5
            }
            
            // set alpha for empty days
            if i > vals.count{
                lbl.alpha = 0.2
            }

            // add label to view
            self.addSubview(lbl)
        }
        
        // add circles
        for i in 0..<vals.count{
        
            var val:Double = Double(vals[i])!
            
            var circleSize:Double = 0
            var sizeFactor:Double = 0
            let maxSize = xSections + (xSections/2)
            let minSize = xSections / 4
            
            var status = ""
            
            if val < 0{
            
                val = (val * (-1))// convert to positive to calculate correct circle size
                sizeFactor = (val * 100) / 3
                circleSize = ((sizeFactor * Double(xSections)) / 100) + Double(xSections)
                
                status = "acidic"
            }
            else if val < 2.8 && val >= 0{
                
                sizeFactor = (val * 100) / 3
                circleSize = ((100 - sizeFactor) * Double(xSections)) / 100
                
                status = "acidic"
            }
            else if val >= 2.8 && val <= 3.3{
                
                val = 3
                
                circleSize =  Double(xSections) // full size
                
                status = "balanz"
            }
            else if val > 3.3{
                
                val = val - 3 // reset
                sizeFactor = (val * 100) / 3
                circleSize = (sizeFactor * Double(xSections)) / 100
                
                status = "alkaline"
            }
            
            // handle size bigger than maximum allowed
            if circleSize > Double(maxSize){
               circleSize = Double(maxSize)
            }
            // handle size smaller than minimum
            if circleSize < Double(minSize){
               circleSize = Double(minSize)
            }
        
            // formula to create path for each circle in loop increment
            let bPath:UIBezierPath = UIBezierPath(ovalInRect: CGRectMake(-xSections, yPoint - CGFloat(circleSize/2), CGFloat(circleSize), CGFloat(circleSize)))
            let circleLayer = CAShapeLayer()
            circleLayer.path = bPath.CGPath
            
            if status == "balanz"{
            
                circleLayer.fillColor = UIColor.balanzColor().CGColor
            }
            else if status == "alkaline"{
                
                circleLayer.fillColor = UIColor.alkalineColor().CGColor
            }
            else if status == "acidic"{
                
                circleLayer.fillColor = UIColor.acidicColor().CGColor
            }
        
            circleLayer.opacity = 0.5
            self.layer.addSublayer(circleLayer)
            
            // animate
            let tt = (xSections * 2) + (xSections * CGFloat(i))
            let toVal = (tt - CGFloat(circleSize / 2)) + halfXsection
            
            let move = CABasicAnimation()
            move.keyPath = "transform.translation.x"
            move.fromValue = (-xSections)
            move.toValue = toVal
            move.duration = 0.6
            move.fillMode = kCAFillModeForwards
            move.removedOnCompletion = false
            
            circleLayer.setValue(move.toValue, forKeyPath: move.keyPath!)
            circleLayer.addAnimation(move, forKey: "transform.translation.x")
        }
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
