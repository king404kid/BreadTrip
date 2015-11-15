//
//  DestinationDetailController.swift
//  Breadtrip
//
//  Created by Feng on 15/10/20.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

class DestinationDetailController: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func loadView() {
        // 设不设置frame都可以
//        let view = UIView(frame: UIScreen.mainScreen().applicationFrame)
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        self.view = view
    }
}
