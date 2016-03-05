//
//  DestinationCollectionHeader.swift
//  Breadtrip
//
//  Created by Feng on 15/10/18.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

class DestinationCollectionHeader: UICollectionReusableView
{
    var titleLabel: UILabel
    
    override init(frame: CGRect) {
        titleLabel = UILabel()
        
        super.init(frame: frame)
        
        initLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initLayout() {
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = NSTextAlignment.Left
//        titleLabel.textColor = UIColor(red: 0, green: 201, blue: 201, alpha: 1)
        titleLabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
    }
    
    // 设置标题
    func setTitle(title: String) {
        titleLabel.text = title
    }
}
