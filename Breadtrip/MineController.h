//
//  MineController.h
//  Breadtrip
//
//  Created by Feng on 15/11/16.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterController.h"

@interface MineController : UIViewController

@property UIButton *closeBtn;   /**< 关闭按钮*/
@property UIButton *weixinBtn;  /**< 微信按钮*/
@property UIButton *weiboBtn;   /**< 微博按钮*/
@property UIButton *qqBtn;      /**< qq按钮*/
@property UIButton *moreBtn;    /**< 更多平台按钮*/
@property UIButton *phoneBtn;   /**< 手机号码按钮*/
@property UIButton *emailBtn;   /**< 邮箱按钮*/
@property UIButton *forgetBtn;   /**< 忘记密码按钮*/
@property UIButton *registerBtn; /**< 注册按钮*/

@property RegisterController *registerController;  /**< 注册controller*/

- (void)layoutUI;

@end