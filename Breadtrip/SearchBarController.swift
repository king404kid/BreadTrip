//
//  SearchBarController.swift
//  Breadtrip
//
//  Created by Feng on 15/7/31.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

import UIKit

@objc protocol SearchBarDelegate: class {
    optional func editBegin()    // 可选，因为原生的swift协议里面没有可选，只能通过objc的方式实现
    func clickBtn()    // 点击取消
    optional func nearbyBtn()    // 点击附近
}

class SearchBarController: UIViewController, UITextFieldDelegate
{
    var delegate: SearchBarDelegate?
    
    @IBOutlet weak var searchBtn: UIButton!
    
    private var _isEditing:Bool = false     // 是否在编辑中
    
    var isEditing: Bool {
        set {
            _isEditing = newValue
            if _isEditing {
                if searchTxt.text == SearchContent.DEFAULT_CONTENT {
                    searchTxt.text = ""
                }
                // 这里要注意！设置文本的时候要对应按钮的状态，否则会不显示
                searchBtn.setTitle("取消", forState: UIControlState.Normal)
                searchTxt.becomeFirstResponder()
            } else {
                if searchTxt.text == "" {
                    searchTxt.text = SearchContent.DEFAULT_CONTENT
                }
                searchBtn.setTitle("附近", forState: UIControlState.Normal)
                searchTxt.resignFirstResponder()   // 释放键盘
            }
        }
        get {
            return _isEditing
        }
    }
    
    struct SearchContent {
        static let DEFAULT_CONTENT = "附近国家、城市、景区、游记名"
        static let EMPTY_CONTENT = ""
    }
    
    // 搜索文本
    @IBOutlet weak var searchTxt: UITextField! {
        didSet {
            searchTxt.backgroundColor = UIColor(red: 11/255, green: 141/255, blue: 138/255, alpha: 1)    // 记得除以255
            // 设置圆角
            searchTxt.layer.cornerRadius = searchTxt.bounds.height / 2
            searchTxt.layer.masksToBounds = true
            searchTxt.tintColor = UIColor.whiteColor()  // 改变光标颜色
            searchTxt.delegate = self
        }
    }
    
    // 点下textfield
    @IBAction func clearContent() {
        isEditing = true
        delegate?.editBegin?()
    }
    
    // 搜索
    @IBAction func search() {
        if isEditing == true {   // 编辑状态，按钮为：取消
            isEditing = !isEditing
            delegate?.clickBtn()
        } else {   // 非编辑状态，按钮为：附近
            delegate?.nearbyBtn?()
        }
    }
    
    // 代理，按下回车键，暂时不处理
    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        isEditing = false
//        return true
        return false
    }
    
    // 点击开始编辑，断点发现：当addSubview的时候，textfield会获得焦点(firstResponder)，然后会调用此方法，所以以下代理放到点击textfield函数处
    func textFieldDidBeginEditing(textField: UITextField) {
        println("search bar textFieldDidBeginEditing called when added")
//        delegate?.editBegin?(textField)
    }
    
    // 弹出键盘
    func setFristResponder() {
        isEditing = true
    }
    
    // 收回键盘
    func resignFristResponder() {
        isEditing = false
    }
}
