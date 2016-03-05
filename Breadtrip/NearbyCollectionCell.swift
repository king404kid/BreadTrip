//
//  NearbyViewCell.swift
//  Breadtrip
//
//  Created by Feng on 15/8/18.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

class NearbyCollectionCell: UICollectionViewCell
{
    // 此方法会被系统自动调用选中状态，无须手动执行
    override var selected: Bool {
        get {
            return super.selected
        }
        set {
            super.selected = newValue
            if selected {
                print(nearbyItem.currentTitle!)
            }
        }
    }
    
    // 区别上面的方法，这里是自己手动调用，用于控制滑块动画
    private var _animateSelected: Bool = false
    var animateSelected: Bool {
        get {
            return _animateSelected
        }
        set {
            _animateSelected = newValue
            
            if _animateSelected {
                nearbyItem.backgroundColor = UIColor(red: 11/255, green: 141/255, blue: 138/255, alpha: 1)
//                nearbyItem.tintColor = UIColor.whiteColor()  // 此方法没效果
                nearbyItem.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                nearbyItem.layer.cornerRadius = nearbyItem.bounds.height / 2
                nearbyItem.layer.masksToBounds = true
            } else {
                nearbyItem.backgroundColor = UIColor.clearColor()
                nearbyItem.setTitleColor(UIColor(red: 43/255, green: 235/255, blue: 255/255, alpha: 1), forState: UIControlState.Normal)
                nearbyItem.layer.cornerRadius = 0
                nearbyItem.layer.masksToBounds = false
            }
        }
    }
    
    @IBOutlet weak var nearbyItem: UIButton! {
        didSet {
            nearbyItem.userInteractionEnabled = false
        }
    }
}
