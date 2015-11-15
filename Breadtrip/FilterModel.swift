//
//  FilterModel.swift
//  Breadtrip
//
//  Created by Feng on 15/11/3.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import Foundation

class FilterModel
{
    let ITEM_HEIGHT = 40
    let ITEM_NUM = 6
    
    class var instance: FilterModel {
        struct Inner {
            static let instance = FilterModel()
        }
        return Inner.instance
    }
}