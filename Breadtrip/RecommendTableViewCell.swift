//
//  RecommendTableViewCell.swift
//  Breadtrip
//
//  Created by Feng on 15/6/9.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

class RecommendTableViewCell: UITableViewCell
{
    @IBOutlet weak var pic: UIImageView! {
        didSet {
            pic.contentMode = UIViewContentMode.ScaleToFill
            pic.layer.cornerRadius = 5
            pic.layer.masksToBounds = true
        }
    }
}
