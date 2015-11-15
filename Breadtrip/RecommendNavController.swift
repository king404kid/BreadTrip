//
//  RecommendNavController.swift
//  Breadtrip
//
//  Created by Feng on 15/7/5.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

class RecommendNavController: UINavigationController
{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 此方法若没有被调用，是因为不同版本的ios sdk有所区别，需要此方法写的地方也不一样(搞不懂为什么苹果公司要设么改动，完全没做好向下兼容的东西)
    // 假设场景tabbarcontroller-navigationcontroller-viewcontroller1-viewcontroller2，自定义的unwind segue从viewcontroller2到viewcontroller1
    // 例如我参考的例子里面，是把此方法放在viewcontroller1的，但是，我当前使用的sdk是8.2，经过试验发现，只有把此方法在navigationcontroller才能正常的被调用。在stackoverflow参考到的sdk8.0以及8.0.x都是需要放在tabbarcontroller才能正常被调用
    override func segueForUnwindingToViewController(toViewController: UIViewController, fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue {
        if let id = identifier {
            if id == "unwindSearchSegueId" {
                let unwindSegue = SearchUnwindSegue(identifier: identifier, source: fromViewController, destination: toViewController, performHandler: { () -> Void in
                    
                })
                return unwindSegue
            }
        }
        return super.segueForUnwindingToViewController(toViewController, fromViewController: fromViewController, identifier: identifier)
    }
    
    // 当我们调用setNeedsStatusBarAppearanceUpdate时，系统会调用application.window的rootViewController的preferredStatusBarStyle方法，我们的程序里一般都是用UINavigationController做root，如果是这种情况，那我们自己的UIViewController里的preferredStatusBarStyle根本不会被调用，所以要重新指向当前viewcontroller
    override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return self.topViewController
    }
}
