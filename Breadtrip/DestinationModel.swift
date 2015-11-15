//
//  DestinationModel.swift
//  Breadtrip
//
//  Created by Feng on 15/10/18.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import Foundation

class DestinationModel
{
    // 目的地类别
    lazy var typeList: [String] = {
        var list: [String] = ["本月推荐", "热门地点", "魅力港澳台", "祖国山河"]
        return list
    }()
    
    // 目的地信息
    lazy var destinationList: [[DestinationVo]] = {
        var myList: [[DestinationVo]] = []
        for (var j: Int = 0; j < 4; j++) {
            var list: [DestinationVo] = []
            for (var i: Int = 0; i < 4; i++) {
                var vo = DestinationVo(name: "地点\(j+1)-\(i+1)", pic: "destinationPic\(j*4+i+1)")
                list.append(vo)
            }
            myList.append(list)
        }
        return myList
    }()
    
    class var instance: DestinationModel {
        struct Inner {
            static let instance = DestinationModel()
        }
        return Inner.instance
    }
}