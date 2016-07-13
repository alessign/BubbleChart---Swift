# BubbleChart-Swift
![](http://www.viralideasltd.com/github/cast.gif)

BubbleChart graph is light-weight simple solution to draw graph with weekly data (Mo - Sun).

# Requirements
* iOS 9.3

# Usage
* Simply drag and drop BubbleChartView.swift to your project
* Set up device rotation 

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

* You're done!
 
# NOTE!
The arrayOfValues is expecting maximum 7 objects. Filter your data before displaying the BubbleChartView on rotation change, or adjust the code to accept more values

## Licence - Free usage

## Source: www.blnzapp.com


