//
//  NearbyTableCell.swift
//  Breadtrip
//
//  Created by Feng on 15/8/29.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

class NearbyTableCell: UITableViewCell
{
    @IBOutlet weak var locationView: UIImageView!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var locationDesc: UILabel!
    @IBOutlet weak var locationFav: UILabel!
    
    // 这里注意一下实际显示的描述内容部分，有些地方很长，有些地方很短，实际显示可以根据文本的长度动态摆放好位置或者截断多余语句。这是通过sb里面的autolayout实现的(下面说明)，另外通过设置其content hugging priority和content compression resistance priority来达到目的，需要动态改变的label只需要把这两个值设置低一些就可以了。详细请对照这sb来理解
    // 另外一个很重要的概念：约束！随意双击一个约束，可以看到里面有first item和second item以及他们的关系：first(=,>=,<=)second*multiplier+constant。这里主要说明一下关系的用途，例如这个例子里面，当文本过长的时候，文本不能全部显示导致会截断部分，这时候主要用到了first=second*multiplier；当文本过短的时候，由于位置比较充足，文本沿着顶部对齐，下面部分留出多余的位置，这时候主要用到了first>=second*multiplier。当然，通过其他的约束关系会有其他不同的效果
    func setData(vo: NearbyVo) {
        locationView.image = UIImage(named: vo.pic)
        locationName.text = vo.name
        locationDesc.text = vo.desc
        locationFav.text = "距我\(vo.distance)m  /  \(vo.num)人去过"
    }
}