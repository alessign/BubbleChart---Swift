//
//  ViewController.swift
//  BubbleChart
//
//  Created by Ales Olasz on 12/07/2016.
//  Copyright © 2016 ViralIdeasLtd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // background gradient
        self.view.backgroundColor = UIColor(red:91.0/255.0, green:136.0/255.0, blue:15.0/255.0, alpha:1)
        
    }

    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        
        if toInterfaceOrientation == .LandscapeLeft{
            
            let bubbleView = BubbleChartView()
            bubbleView.tag = 1001
            bubbleView.arrayOfValues = ["3.4", "-3.1", "3.1", "5.4", "2.7"]
            self.view.addSubview(bubbleView)
            
        }
        else if toInterfaceOrientation == .Portrait{
            
            for subView in self.view.subviews {
            
                if subView.tag == 1001{
                    subView.removeFromSuperview()
                }
            }
            
        }
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

