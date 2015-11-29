//
//  MineController.m
//  Breadtrip
//
//  Created by Feng on 15/11/16.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

#import "MineController.h"
#import <PureLayout.h>

@interface MineController ()

@end

@implementation MineController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 隐藏tabbar
    [[self.tabBarController tabBar] setHidden:true];
}

#pragma mark - 布局UI
- (void)layoutUI {
    // 注意要显示使用浮点数，否则会直接返回整数，导致颜色值不对
    [self.view setBackgroundColor:[UIColor colorWithRed:(CGFloat)(43/255) green:235/255.0 blue:255/255.0f alpha:1.0]];
    
    // 关闭按钮
    self.closeBtn = [[UIButton alloc] init];
    [self.closeBtn setImage:[UIImage imageNamed:@"closePic"] forState:UIControlStateNormal];
    [self.closeBtn setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.view addSubview:self.closeBtn];
    [self.closeBtn autoSetDimensionsToSize:CGSizeMake(20, 20)];
    [self.closeBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:30];
    [self.closeBtn autoPinEdgeToSuperviewMargin:ALEdgeLeft];
    [self.closeBtn addTarget:self action:@selector(closeHandler:) forControlEvents:UIControlEventTouchUpInside];
    // 描述
    UILabel *label = [[UILabel alloc] init];
    [label setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.view addSubview:label];
    [label autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.closeBtn withOffset:26];
    [label autoAlignAxisToSuperviewAxis:ALAxisVertical];
    label.text = @"你好，面粉！";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:28];
    // 微信
    self.weixinBtn = [[UIButton alloc] init];
    [self.weixinBtn setImage:[UIImage imageNamed:@"weixinIconPic"] forState:UIControlStateNormal];
    [self.weixinBtn setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.view addSubview:self.weixinBtn];
    // 微博
    self.weiboBtn = [[UIButton alloc] init];
    [self.weiboBtn setImage:[UIImage imageNamed:@"weiboIconPic"] forState:UIControlStateNormal];
    [self.weiboBtn setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.view addSubview:self.weiboBtn];
    // qq
    self.qqBtn = [[UIButton alloc] init];
    [self.qqBtn setImage:[UIImage imageNamed:@"qqIconPic"] forState:UIControlStateNormal];
    [self.qqBtn setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.view addSubview:self.qqBtn];
    // 布局，之所以不写在上面初始化后，是因为自动布局是要先addSubview的，假如a控件依赖于b控件的约束，则必须等到b控件addSubview后才添加自身的约束，所以后面才加约束
    [self.weixinBtn autoSetDimensionsToSize:CGSizeMake(50, 181/149.0*50)];
    [self.weixinBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:label withOffset:22];
    [self.weixinBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:50];
    [self.weixinBtn addTarget:self action:@selector(choosePlatform:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.weiboBtn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.weixinBtn];
    [self.weiboBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.weixinBtn];
    [self.weiboBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.weixinBtn];
    [self.weiboBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.weiboBtn addTarget:self action:@selector(choosePlatform:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.qqBtn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.weixinBtn];
    [self.qqBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.weixinBtn];
    [self.qqBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.weixinBtn];
    [self.qqBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
    [self.qqBtn addTarget:self action:@selector(choosePlatform:) forControlEvents:UIControlEventTouchUpInside];
    // 更多平台
    self.moreBtn = [[UIButton alloc] init];
    [self.moreBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.moreBtn setTitle:@"更多社交平台" forState:UIControlStateNormal];
    [self.moreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.moreBtn setContentEdgeInsets:UIEdgeInsetsMake(8, 24, 8, 24)];  // 区分setTitleEdgeInsets不同，前者是设置内容的inset，后者是设置title的inset(会导致显示不全)
    [self.moreBtn.layer setBorderWidth:1];
    [self.moreBtn.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.moreBtn.layer setMasksToBounds:true];
    [self.moreBtn.layer setCornerRadius:20];   // 如果想设置成高度的一半，可以在viewDidAppear里面设置
    [self.view addSubview:self.moreBtn];
    [self.moreBtn setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.moreBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.weixinBtn withOffset:20];
    [self.moreBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.moreBtn addTarget:self action:@selector(choosePlatform:) forControlEvents:UIControlEventTouchUpInside];
    // 登录描述
    UILabel *desc = [[UILabel alloc] init];
    [desc setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.view addSubview:desc];
    [desc autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.moreBtn withOffset:40];
    [desc autoAlignAxisToSuperviewAxis:ALAxisVertical];
    desc.text = @"使用面包账号登录";
    desc.textColor = [UIColor whiteColor];
    desc.font = [UIFont boldSystemFontOfSize:12];
    // 通过手机号码登录
    self.phoneBtn = [[UIButton alloc] init];
    [self.phoneBtn setBackgroundColor:[UIColor whiteColor]];
    [self.phoneBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.phoneBtn setTitle:@"通过手机号码登录" forState:UIControlStateNormal];
    [self.phoneBtn setTitleColor:[UIColor colorWithRed:(CGFloat)(43/255) green:235/255.0 blue:255/255.0f alpha:1.0] forState:UIControlStateNormal];
    [self.phoneBtn.layer setBorderWidth:1];
    [self.phoneBtn.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.phoneBtn.layer setMasksToBounds:true];
    [self.phoneBtn.layer setCornerRadius:20];   // 如果想设置成高度的一半，可以在viewDidAppear里面设置
    [self.view addSubview:self.phoneBtn];
    [self.phoneBtn setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.phoneBtn autoSetDimension:ALDimensionHeight toSize:40];
    [self.phoneBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:desc withOffset:20];
    [self.phoneBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:20];
    [self.phoneBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-20];
    [self.phoneBtn addTarget:self action:@selector(choosePlatform:) forControlEvents:UIControlEventTouchUpInside];
    // 通过email登录
    self.emailBtn = [[UIButton alloc] init];
    [self.emailBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.emailBtn setTitle:@"面包用户名或邮箱登录" forState:UIControlStateNormal];
    [self.emailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.emailBtn.layer setBorderWidth:1];
    [self.emailBtn.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.emailBtn.layer setMasksToBounds:true];
    [self.emailBtn.layer setCornerRadius:20];   // 如果想设置成高度的一半，可以在viewDidAppear里面设置
    [self.view addSubview:self.emailBtn];
    [self.emailBtn setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.emailBtn autoSetDimension:ALDimensionHeight toSize:40];
    [self.emailBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.phoneBtn withOffset:12];
    [self.emailBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:20];
    [self.emailBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-20];
    [self.emailBtn addTarget:self action:@selector(choosePlatform:) forControlEvents:UIControlEventTouchUpInside];
    // 忘记密码
    self.forgetBtn = [[UIButton alloc] init];
    [self.forgetBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [self.forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.forgetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.forgetBtn];
    [self.forgetBtn setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.forgetBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.forgetBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.forgetBtn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withMultiplier:1/2.0];
    [self.forgetBtn autoSetDimension:ALDimensionHeight toSize:60];
    [self.forgetBtn addTarget:self action:@selector(choosePlatform:) forControlEvents:UIControlEventTouchUpInside];
    // 注册账号
    self.registerBtn = [[UIButton alloc] init];
    [self.registerBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [self.registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.registerBtn];
    [self.registerBtn setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.registerBtn autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.registerBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.registerBtn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withMultiplier:1/2.0];
    [self.registerBtn autoSetDimension:ALDimensionHeight toSize:60];
    [self.registerBtn addTarget:self action:@selector(registerHandler) forControlEvents:UIControlEventTouchUpInside];
    // 画线
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line1];
    [line1 setTranslatesAutoresizingMaskIntoConstraints:false];
    [line1 autoSetDimension:ALDimensionHeight toSize:1];
    [line1 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [line1 autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [line1 autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.forgetBtn];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line2];
    [line2 setTranslatesAutoresizingMaskIntoConstraints:false];
    [line2 autoSetDimension:ALDimensionWidth toSize:1];
    [line2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line1];
    [line2 autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:15];
    [line2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.forgetBtn];
}

#pragma mark - 事件

/**
 *  关闭页面
 *  @param sender 发送事件
 */
- (void)closeHandler:(UIButton *)sender {
    [[self.tabBarController tabBar] setHidden:false];
    [self.tabBarController setSelectedIndex:0];
}

/**
 *  选择平台登录
 *  @param sender 平台来源
 */
- (void)choosePlatform:(UIButton *)sender {
    
}

/**
 *  注册
 */
- (void)registerHandler {
    if (_registerController == nil) {
        _registerController = [[RegisterController alloc] init];
    }
    [self presentViewController:_registerController animated:true completion:^{
        
    }];
}

#pragma mark - 注册部分



@end