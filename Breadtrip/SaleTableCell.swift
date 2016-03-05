//
//  SaleTableCell.swift
//  Breadtrip
//
//  Created by Feng on 15/10/25.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

class SaleTableCell: UITableViewCell
{
    var picView: UIImageView
    var titleLabel: UILabel
    var dateLable: UILabel
    var placeLabel: UILabel
    var salePriceLabel: UILabel
    var originPriceLabel: UILabel
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        picView = UIImageView()
        titleLabel = UILabel()
        dateLable = UILabel()
        placeLabel = UILabel()
        salePriceLabel = UILabel()
        originPriceLabel = UILabel()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 布局
    func initLayout() {
        picView.layer.masksToBounds = true
        picView.layer.cornerRadius = 5
        picView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(picView)
        picView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0), excludingEdge: ALEdge.Right)
        picView.autoMatchDimension(ALDimension.Width, toDimension: ALDimension.Height, ofView: picView)
        
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        titleLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: picView, withOffset: 10)
        titleLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: picView, withOffset: 0)
        titleLabel.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 10)
        
        dateLable.numberOfLines = 0
        dateLable.font = UIFont(name: dateLable.font.fontName, size: 12)
        dateLable.textColor = UIColor.grayColor()
        dateLable.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dateLable)
        dateLable.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: picView, withOffset: 10)
        dateLable.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: titleLabel, withOffset: 5)
        dateLable.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 10)
        
        placeLabel.numberOfLines = 0
        placeLabel.font = UIFont(name: placeLabel.font.fontName, size: 12)
        placeLabel.textColor = UIColor.grayColor()
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(placeLabel)
        placeLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: picView, withOffset: 10)
        placeLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: dateLable, withOffset: 5)
        placeLabel.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 10)
        
        salePriceLabel.font = UIFont(name: placeLabel.font.fontName, size: 20)
        salePriceLabel.textColor = UIColor.orangeColor()
        salePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(salePriceLabel)
        salePriceLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: picView, withOffset: 12)
        salePriceLabel.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: picView, withOffset: 0)
        
        originPriceLabel.font = UIFont(name: originPriceLabel.font.fontName, size: 12)
        originPriceLabel.textColor = UIColor.grayColor()
        originPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(originPriceLabel)
        originPriceLabel.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 10)
        originPriceLabel.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: picView, withOffset: 0)
    }
}
