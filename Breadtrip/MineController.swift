//
//  MineController.swift
//  Breadtrip
//
//  Created by Feng on 15/5/25.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

class MineController: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testLayoutMargin()
    }
    
    override func loadView() {
        super.loadView()
        
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        self.view = view
    }
    
    // layoutMargin和preservesSuperviewLayoutMargins的实验结论如下：
    // 1.layoutMargin是uiview的默认内边距(8,8,8,8)，当使用自动布局且pinEdge到margin时，会以此为参考
    // 2.preservesSuperviewLayoutMargins是控制viewA的子view是否需要参照viewA的父类layoutMargin来布局，默认此参数为false，即不需要，所以往往我们用到的layoutMargin就是父类的layoutMargin
    // 3.当preservesSuperviewLayoutMargins为true的时候，viewA的子view就需要考虑viewA的父类layoutMargin，考虑方式是：取viewA的layoutMargin和viewA父类的layoutMargin最大值来作为参考标准，具体事例如下
    func testLayoutMargin() {
        let blueView = UIView()
//        blueView.preservesSuperviewLayoutMargins = true
        blueView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        blueView.backgroundColor = UIColor.blueColor()
        blueView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(blueView)
        blueView.autoPinEdgesToSuperviewEdges()
        
        let yellowView = UIView()
        yellowView.preservesSuperviewLayoutMargins = true
        yellowView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        yellowView.backgroundColor = UIColor.yellowColor()
        yellowView.setTranslatesAutoresizingMaskIntoConstraints(false)
        blueView.addSubview(yellowView)
        yellowView.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        yellowView.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        yellowView.autoMatchDimension(ALDimension.Width, toDimension: ALDimension.Width, ofView: blueView)
        yellowView.autoMatchDimension(ALDimension.Height, toDimension: ALDimension.Height, ofView: blueView, withMultiplier: 1/2)
        
        let greenView = UIView()
        greenView.backgroundColor = UIColor.greenColor()
        greenView.setTranslatesAutoresizingMaskIntoConstraints(false)
        yellowView.addSubview(greenView)
        greenView.preservesSuperviewLayoutMargins = true
        greenView.autoPinEdgesToSuperviewMargins()
        
        let blackView = UIView()
        blackView.backgroundColor = UIColor.blackColor()
        blackView.setTranslatesAutoresizingMaskIntoConstraints(false)
        greenView.addSubview(blackView)
//        blackView.preservesSuperviewLayoutMargins = true
        blackView.autoPinEdgesToSuperviewMargins()
    }
}
