//
//  BannerDetailViewController.swift
//  Breadtrip
//
//  Created by Feng on 15/7/18.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

class BannerDetailViewController: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 显示导航栏
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
