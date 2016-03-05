//
//  BreadtripTabBarController.swift
//  Breadtrip
//
//  Created by Feng on 15/5/25.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

class BreadtripTabBarController: UITabBarController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 尝试通过修改tabbar内部的结构，达到图片填充效果，但是还是不行
//        printViewHierarchy(self.tabBar)

        // 尝试修改tabbar的图片
//        var tabbarItems = self.tabBar.items
//        var tabbarItem = tabbarItems?.first as? UITabBarItem
//        tabbarItem?.image = getModifyTabbarItemImage("tabbar_destination_normal")
//        tabbarItem?.selectedImage = getModifyTabbarItemImage("tabbar_destination_normal")
        
        // 这个的确可以改变图片的位置，但是如何完全填充整个tabbarItem还是没解决
//        tabbarItem?.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    }
    
    var level:Int = 0
    
    // 打印view的层次结构
    func printViewHierarchy(superView: UIView) {
        for (var i:Int = 0; i < level; i++){
            print("\t", terminator: "");
        }
        // swift这里还不可以实现反射获取类名
//        let className = object_getClassName(superView)
//        println("\(className):")
        print("frame: \(superView.frame)")
        
        ++level
        for tempView in superView.subviews {
            self.printViewHierarchy(tempView as UIView)
        }
        --level
    }
    
    // 返回修改后的tabbar item图片
    func getModifyTabbarItemImage(imgName:String) -> UIImage? {
        var image = UIImage(named: imgName)
        image = scaleImageToSize(image, size: CGSize(width: 30, height: 30))
        // 这里记得修改的是返回值！
        image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        return image
    }
    
    // 修改图片大小和控件一致
    func scaleImageToSize(img:UIImage?, size:CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        img?.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let scaledImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return scaledImage
    }
}
