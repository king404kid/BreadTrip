//
//  FilterBgView.swift
//  Breadtrip
//
//  Created by Feng on 15/11/3.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

class FilterBgView: UIView
{
    var isFolding: Bool = true {  // 是否折叠中
        didSet {
            if isFolding {  // 折叠中
                self.layer
            } else {  // 展开中
                
            }
        }
    }
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        if isFolding {
            return point.y <= CGFloat(FilterModel.instance.ITEM_HEIGHT)
        } else {
            return true   // 整块区域都被灰色覆盖住
//            return point.y <= CGFloat(FilterModel.instance.ITEM_HEIGHT * (FilterModel.instance.ITEM_NUM + 1))
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        println("测试fitlerBgView的layoutSubviews次数: \(layoutTime++)")
    }
    
    var layoutTime: Int = 1
}
