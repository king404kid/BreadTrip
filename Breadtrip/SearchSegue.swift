//
//  SearchSegue.swift
//  Breadtrip
//
//  Created by Feng on 15/8/2.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

class SearchSegue: UIStoryboardSegue
{
    override func perform() {
        println("SearchSegue")
        var sourceView = self.sourceViewController.view as UIView!
        var destinationView = self.destinationViewController.view as UIView!
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        destinationView.frame = CGRect(x: 0, y: -screenHeight, width: screenWidth, height: screenHeight)
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(destinationView, aboveSubview: sourceView)
//        (self.destinationViewController as SearchViewController).setFirstResponder()
        UIView.animateWithDuration(0.4, animations: { () -> Void in
//            sourceView.frame = CGRectOffset(sourceView.frame, 0, screenHeight)
            destinationView.frame = CGRectOffset(destinationView.frame, 0, screenHeight)
            }) { (finished: Bool) -> Void in
                println("search segue finished")
                self.sourceViewController.presentViewController(self.destinationViewController as UIViewController, animated: false, completion: nil)
                // 一定要在这里写焦点获取，而不能在上面insertSubview后写，不知道为何在那句后写系统会拒绝获得焦点，而且导致后面的获取焦点也无效。反正在真正的presentViewController后获得焦点就没问题。做过一个试验，SearchViewController的viewDidAppear会触发两次，第一次获取焦点无效，第二次才有效，正好验证此想法
                (self.destinationViewController as SearchViewController).setFirstResponder()
            }
    }
}
