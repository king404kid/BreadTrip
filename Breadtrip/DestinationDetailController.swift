//
//  DestinationDetailController.swift
//  Breadtrip
//
//  Created by Feng on 15/10/20.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

class DestinationDetailController: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // 没有通过nib或者storyboard创建的vc一定要重写此方法，否则会调用默认的loadView返回一个空白的UIView对象。而一个空白的UIView不知道为什么会显示有点问题(我猜有可能跟转场有关)，详细效果可以手动模拟clearColor。所以我们要赋个whiteColor
    override func loadView() {
        // 设不设置frame都可以
//        let view = UIView(frame: UIScreen.mainScreen().applicationFrame)
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
//        view.backgroundColor = UIColor.clearColor()
        self.view = view
    }
}
