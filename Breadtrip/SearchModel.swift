//
//  SearchModel.swift
//  Breadtrip
//
//  Created by Feng on 15/7/19.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import Foundation

class SearchModel
{
    let OFFSET: Int = 10
    
    lazy var headerList: [String] = {
        var list: [String] = ["国外热门目的地", "国内热门目的地"]
        return list
    }()
    
    lazy var favoriteForeignPlaceList: [String] = {
        var list: [String] = ["泰国", "韩国", "日本", "法国", "美国", "意大利", "马来西亚", "英国", "新加坡", "希腊", "瑞士", "德国"]
        return list
    }()
    
    lazy var favoriteDomesticPlaceList: [String] = {
        var list: [String] = ["台湾", "香港", "厦门", "北京", "丽江", "成都", "上海", "拉萨", "西安", "大理", "三亚"]
        return list
    }()
    
    class var instance: SearchModel {
        struct Inner {
            static let instance: SearchModel = SearchModel()
        }
        return Inner.instance
    }
}