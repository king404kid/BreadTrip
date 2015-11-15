//
//  SearchHeaderView.swift
//  Breadtrip
//
//  Created by Feng on 15/8/13.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

class SearchHeaderView: UICollectionReusableView
{
    @IBOutlet weak var name: UILabel!
    
    let color = UIColor(red: 0, green: 201/255, blue: 201/255, alpha: 1)
    
    override func drawRect(rect: CGRect) {
        // 画一根线
        var path = UIBezierPath()
        let startPoint = CGPoint(x: CGFloat(SearchModel.instance.OFFSET), y: bounds.height - 10)
        let endPoint = CGPoint(x: bounds.width - CGFloat(SearchModel.instance.OFFSET), y: bounds.height - 10)
        path.lineWidth = 1
        path.moveToPoint(startPoint)
        path.addLineToPoint(endPoint)
        color.setStroke()
        path.stroke()
    }
}