//
//  SaleModel.swift
//  Breadtrip
//
//  Created by Feng on 15/10/25.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import Foundation

class SaleModel
{
    // 刷选列表
    lazy var filterList: [SaleFilterVo] = {
        var list = [SaleFilterVo]()
        var typeList: [String] = ["产品类型", "全部", "出发城市", "出发时间"]
        for i in 0..<4 {
            var list1 = [SaleTypeVo]()
            let name1 = typeList[i]
            for j in 0..<8 {
                var list2 = [SaleListVo]()
                let name2 = "\(name1)_\(j+1)"
                for k in 0..<8 {
                    var list3 = [SaleVo]()
                    let name3 = "\(name2)_\(k+1)"
                    for l in 0..<10 {
                        let name4 = "\(name3)_\(l+1)"
                        var vo4 = SaleVo(pic: "salePic\(l+1)", title: name4, dateArray: ["10月1","10月15","10月19","11月11"], place: "北京", salePrice: 388, originPrice: 500)
                        list3.append(vo4)
                    }
                    var vo3 = SaleListVo(name: name3, arr: list3)
                    list2.append(vo3)
                }
                var vo2 = SaleTypeVo(name: name2, arr: list2)
                list1.append(vo2)
            }
            var vo1 = SaleFilterVo(name: name1, arr: list1)
            list.append(vo1)
        }
        return list
    }()
    
    class var instance: SaleModel {
        struct Inner {
            static let instance = SaleModel()
        }
        return Inner.instance
    }
}