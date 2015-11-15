//
//  DestinationCollectionCell.swift
//  Breadtrip
//
//  Created by Feng on 15/10/18.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

protocol DestinationDelegate: class {
    func clickCell(destinationName: String)
}

class DestinationCollectionCell: UICollectionViewCell
{
    var imageBtn: UIButton
    var nameLabel: UILabel
    var delegate: DestinationDelegate?
    
    override init(frame: CGRect) {
        imageBtn = UIButton()
        nameLabel = UILabel()
        super.init(frame: frame)
        
        initLayout()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initLayout() {
        self.addSubview(imageBtn)
        imageBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        imageBtn.layer.cornerRadius = 5
        imageBtn.layer.masksToBounds = true
        imageBtn.autoPinEdgesToSuperviewEdges()
        imageBtn.addTarget(self, action: "clickCell", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(nameLabel)
        nameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        nameLabel.textAlignment = NSTextAlignment.Center
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 5), excludingEdge: ALEdge.Top)
    }
    
    // 点击按钮
    func clickCell() {
        delegate?.clickCell(nameLabel.text!)
    }
    
    // 设置背景图
    func setBackgroundImage(pic: String) {
        imageBtn.setBackgroundImage(UIImage(named: pic), forState: UIControlState.Normal)
    }
    
    // 设置标题
    func setTitle(title: String) {
        nameLabel.text = title
    }
}
