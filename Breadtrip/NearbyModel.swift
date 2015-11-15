//
//  NearbyModel.swift
//  Breadtrip
//
//  Created by Feng on 15/8/18.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import Foundation

class NearbyModel
{
    // 导航栏类别
    lazy var typeList: [String] = {
        var list: [String] = ["全部", "附近", "厦门", "北京", "丽江", "成都", "上海"]
        return list
    }()
    
    // 附近信息
    lazy var nearbyList: [[NearbyVo]] = {
        var myList: [[NearbyVo]] = []
        for (var j: Int = 0; j < 7; j++) {
            var list: [NearbyVo] = []
            for (var i: Int = 0; i < 10; i++) {
                // 设置不同长度的两种文本，通过设置sb的autolayout属性使他们自适应，详细看nearbytablecell和sb的设置和说明
                var vo = NearbyVo(pic: "nearby\(i+1)", name: "分类\(j+1)：第\(i+1)个地方名", desc: "第\(i+1)个很长很长的地方描述，真的很长很长很长很长!很长很长很长很长第\(i+1)个很长很长的地方描述，真的很长很长很长很长!很长很长很长很长", distance: i*500, num: i*2)
                if i % 2 == 0 {
                    vo.desc = "第\(i+1)个的描述很短"
                }
                list.append(vo)
            }
            myList.append(list)
        }
        return myList
    }()
    
    class var instance: NearbyModel {
        struct Inner {
            static let instance = NearbyModel()
        }
        return Inner.instance
    }
}