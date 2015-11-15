//
//  FilterBarItem.swift
//  Breadtrip
//
//  Created by Feng on 15/10/28.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

class FilterBarItem: UIView
{
    var btn: UIButton
    var needsLine: Bool = true
    
    // 不能调用此构造函数
//    override init() {
//        btn = UIButton()
//        btn.userInteractionEnabled = false
//        
//        super.init()  // init()会调用init(frame: CGRect)，因为init()是便利构造函数，最终要调用指定构造函数，这样就会导致一个问题，重复调用了btn的初始化和initLayout，所以外部调用的只能是init(frame: CGRect)
//        
//        initLayout()
//    }
    
    override init(frame: CGRect) {
        btn = UIButton()
        btn.userInteractionEnabled = false  // 这里设置成false，否则父类的手势会被button给拦截，导致没触发到
        
        super.init(frame: frame)
        
//        self.backgroundColor = UIColor.clearColor()  // 这里需要设置背景色为透明，否则重写drawRect后，会导致背景变黑
        self.backgroundColor = UIColor.whiteColor()  // 后来发现即使改为其他颜色，也可以达到上述效果
        initLayout()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initLayout() {
        btn.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(btn)
        btn.autoPinEdgesToSuperviewEdges()
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)
//        btn.backgroundColor = UIColor.whiteColor()      // 这里不知道为啥会把drawRect画的东西挡住
    }
    
    override func drawRect(rect: CGRect) {
        if needsLine {
            drawLine()
        }
    }
    
    func drawLine() {
        let path = UIBezierPath()
        let startPoint = CGPoint(x: bounds.width, y: 10)
        let endPoint = CGPoint(x: bounds.width, y: bounds.height - 10)
        path.lineWidth = 1
        path.moveToPoint(startPoint)
        path.addLineToPoint(endPoint)
        let color = UIColor.blackColor()
        color.setStroke()
        path.stroke()
    }
    
    func setTitle(title: String) {
        btn.setTitle(title, forState: UIControlState.Normal)
    }
    
    func setColor(color: UIColor) {
        btn.setTitleColor(color, forState: UIControlState.Normal)
    }
}
