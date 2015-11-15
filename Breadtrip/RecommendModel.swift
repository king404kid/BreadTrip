//
//  RecommendModel.swift
//  Breadtrip
//
//  Created by Feng on 15/6/10.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import Foundation

class RecommendModel
{
    lazy var recommendVoList:[RecommendVo] = {
        var arr:[RecommendVo] = []
        for var i = 0; i < 15; i++ {
            var vo = RecommendVo(picName: "recommendPic\(i+1).jpg", headPic: "", destination: "", date: "", like: 0, mile: 0, flightNum: 0, hotelNum: 0, sceneNum: 0, resturantNum: 0)
            arr.append(vo)
        }
        return arr
    }()
    
//    static let instance: RecommendModel = RecommendModel()    1.2版本后swift支持静态类变量，且是lazy initialization
    
    // 这种写法支持早期的swift，因为1.2之前的swift不支持静态类变量
    class var instance: RecommendModel {
        struct Inner {
            static let instance = RecommendModel()
        }
        return Inner.instance
    }
}