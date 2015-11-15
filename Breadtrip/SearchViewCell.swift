//
//  SearchViewCell.swift
//  Breadtrip
//
//  Created by Feng on 15/7/19.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

class SearchViewCell: UICollectionViewCell
{
    @IBOutlet weak var contentBtn: UIButton! {
        didSet {
//            contentBtn.layer.backgroundColor = UIColor.grayColor().CGColor
//            contentBtn.backgroundColor = UIColor.grayColor()
            contentBtn.layer.borderWidth = 1.0
            contentBtn.layer.borderColor = UIColor(red: 0, green: 201/255, blue: 201/255, alpha: 1).CGColor
            contentBtn.layer.cornerRadius = contentBtn.bounds.height / 2
            contentBtn.layer.masksToBounds = true
        }
    }
    
    // 选择地点
    @IBAction func choosePlace(sender: UIButton) {
        println("sender name: \(sender.currentTitle!)")
    }
}
