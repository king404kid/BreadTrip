//
//  SearchUnwindSegue.swift
//  Breadtrip
//
//  Created by Feng on 15/8/2.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

class SearchUnwindSegue: UIStoryboardSegue
{
    override func perform() {
        print("SearchUnwindSegue")
        let sourceView = self.sourceViewController.view as UIView!
        let destinationView = self.destinationViewController.view as UIView!
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        destinationView.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: screenHeight)
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(destinationView, belowSubview: sourceView)
//        (self.destinationViewController as RecommendController).setResignFristResponder()
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            sourceView.frame = CGRectOffset(sourceView.frame, 0, -screenHeight)
            destinationView.frame = CGRectOffset(destinationView.frame, 0, -screenHeight)
            }) { (finished: Bool) -> Void in
                print("search unwind segue finished")
                self.sourceViewController.dismissViewControllerAnimated(false, completion: { () -> Void in
                    // 可以在上面insertSubview后写，与SearchSegue的情况不一样
                    (self.destinationViewController as! RecommendController).setResignFristResponder()
                })
        }
    }
}
