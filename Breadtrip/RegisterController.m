//
//  RegisterController.m
//  Breadtrip
//
//  Created by Feng on 15/11/21.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

#import "RegisterController.h"
#import <PureLayout.h>

@interface RegisterController ()

@property UIButton *backBtn;    /**< 返回按钮*/
@property UIButton *countryBtn; /**< 国家按钮*/
@property UILabel *phonePrefix; /**< 电话区号*/
@property UITextField *phoneTxt; /**< 电话号码*/
@property UITextField *messageTxt; /**< 短信验证码*/
@property UIButton *messageBtn; /**< 短信验证码按钮*/
@property UITextField *passwordTxt; /**< 密码*/
@property UIButton *yesBtn; /**< 同意按钮*/
@property UIButton *loginBtn; /**< 登录按钮*/

@end

@implementation RegisterController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
}

#pragma mark - 布局UI
- (void)layoutUI {
    // 注意要显示使用浮点数，否则会直接返回整数，导致颜色值不对
    [self.view setBackgroundColor:[UIColor colorWithRed:(CGFloat)(43/255) green:235/255.0 blue:255/255.0f alpha:1.0]];
    
    // 关闭按钮
    self.backBtn = [[UIButton alloc] init];
    [self.backBtn setImage:[UIImage imageNamed:@"backPic"] forState:UIControlStateNormal];
    [self.backBtn setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.view addSubview:self.backBtn];
    [self.backBtn autoSetDimensionsToSize:CGSizeMake(20, 20)];
    [self.backBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:30];
    [self.backBtn autoPinEdgeToSuperviewMargin:ALEdgeLeft];
    [self.backBtn addTarget:self action:@selector(backHandler) forControlEvents:UIControlEventTouchUpInside];
    
    // 国家描述
    UILabel *countryLabel = [[UILabel alloc] init];
    countryLabel.textColor = [UIColor whiteColor];
    countryLabel.font = [UIFont systemFontOfSize:16];
    countryLabel.text = @"国家和地区";
    [countryLabel setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.view addSubview:countryLabel];
    [countryLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.backBtn withOffset:50];
    [countryLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40];
    
    // 国家按钮
    self.countryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.countryBtn setTitle:@"中国" forState:UIControlStateNormal];
    [self.countryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.countryBtn setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.view addSubview:self.countryBtn];
    [self.countryBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:countryLabel];
    [self.countryBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
    
    // 箭头
    UIImageView *rightArrow = [[UIImageView alloc] init];
    [rightArrow setImage:[UIImage imageNamed:@"arrowRightPic"]];
    [rightArrow setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.view addSubview:rightArrow];
    [rightArrow autoSetDimensionsToSize:CGSizeMake(14, 20)];
    [rightArrow autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.countryBtn withOffset:8];
    [rightArrow autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.countryBtn];
    
    // 画横线
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line1];
    [line1 setTranslatesAutoresizingMaskIntoConstraints:false];
    [line1 autoSetDimension:ALDimensionHeight toSize:1];
    [line1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:countryLabel];
    [line1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:countryLabel withOffset:8];
    [line1 autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:rightArrow];
    
    // 画横线
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line2];
    [line2 setTranslatesAutoresizingMaskIntoConstraints:false];
    [line2 autoSetDimension:ALDimensionHeight toSize:1];
    [line2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:line1];
    [line2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line1 withOffset:60];
    [line2 autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:line1];
    
    // 电话区号
    self.phonePrefix = [[UILabel alloc] init];
    self.phonePrefix.textColor = [UIColor whiteColor];
    self.phonePrefix.font = [UIFont systemFontOfSize:16];
    self.phonePrefix.text = @"+86";
    [self.phonePrefix setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.view addSubview:self.phonePrefix];
    [self.phonePrefix autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:line2 withOffset:-8];
    [self.phonePrefix autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:line2];
    
    // 画竖线
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line3];
    [line3 setTranslatesAutoresizingMaskIntoConstraints:false];
    [line3 autoSetDimension:ALDimensionWidth toSize:1];
    [line3 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.phonePrefix withOffset:8];
    [line3 autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:line2];
    [line3 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.phonePrefix];
    
    // 电话号码
    self.phoneTxt = [[UITextField alloc] init];
    self.phoneTxt.textColor = [UIColor whiteColor];
    self.phoneTxt.tintColor = [UIColor whiteColor];
    self.phoneTxt.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:self.phoneTxt];
    [self.phoneTxt setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.phoneTxt autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:line3 withOffset:8];
    [self.phoneTxt autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.phonePrefix];
    [self.phoneTxt autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.phonePrefix];
    [self.phoneTxt autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:line2];
    [self.phoneTxt setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];  // 默认的是defaultLow，所以要设置更第一级的约束
    
    // 画横线
    UIView *line4 = [[UIView alloc] init];
    line4.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line4];
    [line4 setTranslatesAutoresizingMaskIntoConstraints:false];
    [line4 autoSetDimension:ALDimensionHeight toSize:1];
    [line4 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:line2];
    [line4 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line2 withOffset:60];
    [line4 autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:line2];
    
    // 短信验证码
    self.messageTxt = [[UITextField alloc] init];
    self.messageTxt.textColor = [UIColor whiteColor];
    self.messageTxt.tintColor = [UIColor whiteColor];
    self.messageTxt.font = [UIFont systemFontOfSize:16];
    self.messageTxt.text = @"短信验证码";
    [self.messageTxt setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.view addSubview:self.messageTxt];
    [self.messageTxt autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:line4 withOffset:-8];
    [self.messageTxt autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:line4];
    
    // 短信验证码按钮
    self.messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.messageBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.messageBtn setContentEdgeInsets:UIEdgeInsetsMake(6, 12, 6, 12)];  // 区分setTitleEdgeInsets不同，前者是设置内容的inset，后者是设置title的inset(会导致显示不全)
    [self.messageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.messageBtn setTitleColor:[UIColor colorWithRed:(CGFloat)(43/255) green:235/255.0 blue:255/255.0f alpha:1.0] forState:UIControlStateNormal];
    [self.messageBtn setBackgroundColor:[UIColor whiteColor]];
    [self.messageBtn.layer setBorderWidth:0];
    [self.messageBtn.layer setMasksToBounds:true];
    [self.messageBtn.layer setCornerRadius:12];   // 如果想设置成高度的一半，可以在viewDidAppear里面设置
    [self.view addSubview:self.messageBtn];
    [self.messageBtn setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.messageBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.messageTxt];
    [self.messageBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.messageTxt];
    [self.messageBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:line4];
    
    // 画横线
    UIView *line5 = [[UIView alloc] init];
    line5.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line5];
    [line5 setTranslatesAutoresizingMaskIntoConstraints:false];
    [line5 autoSetDimension:ALDimensionHeight toSize:1];
    [line5 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:line4];
    [line5 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line4 withOffset:60];
    [line5 autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:line4];
    
    // 短信验证码
    self.passwordTxt = [[UITextField alloc] init];
    self.passwordTxt.textColor = [UIColor whiteColor];
    self.passwordTxt.tintColor = [UIColor whiteColor];
    self.passwordTxt.font = [UIFont systemFontOfSize:16];
    self.passwordTxt.text = @"输入登录密码，至少6位";
    [self.passwordTxt setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.view addSubview:self.passwordTxt];
    [self.passwordTxt autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:line5 withOffset:-8];
    [self.passwordTxt autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:line5];
    
    // 同意按钮
    self.yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.yesBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.yesBtn setContentEdgeInsets:UIEdgeInsetsMake(12, 30, 12, 30)];  // 区分setTitleEdgeInsets不同，前者是设置内容的inset，后者是设置title的inset(会导致显示不全)
    [self.yesBtn setTitle:@"同意协议并注册" forState:UIControlStateNormal];
    [self.yesBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.yesBtn.layer setBorderWidth:1];
    [self.yesBtn.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.yesBtn.layer setMasksToBounds:true];
    [self.yesBtn.layer setCornerRadius:22];   // 如果想设置成高度的一半，可以在viewDidAppear里面设置
    [self.view addSubview:self.yesBtn];
    [self.yesBtn setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.yesBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line5 withOffset:80];
    [self.yesBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    // 条款说明
    UILabel *description = [[UILabel alloc] init];
    description.textColor = [UIColor whiteColor];
    description.font = [UIFont systemFontOfSize:12];
//    description.text = @"面包旅行用户隐私协议";
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"面包旅行用户隐私协议"];
    NSRange contentRange = {0, [content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    description.attributedText = content;
    [self.view addSubview:description];
    [description setTranslatesAutoresizingMaskIntoConstraints:false];
    [description autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.yesBtn withOffset:16];
    [description autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    // 画横线
    UIView *line6 = [[UIView alloc] init];
    line6.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line6];
    [line6 setTranslatesAutoresizingMaskIntoConstraints:false];
    [line6 autoSetDimension:ALDimensionHeight toSize:1];
    [line6 autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:60];
    [line6 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [line6 autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    // 登录按钮
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.loginBtn setTitle:@"已有账号登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.loginBtn];
    [self.loginBtn setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line6];
    [self.loginBtn autoPinEdgesToSuperviewMarginsExcludingEdge:ALEdgeTop];
}

#pragma mark - 事件

/**
 *  返回注册页面
 */
- (void)backHandler {
    [self dismissViewControllerAnimated:true completion:^{
        
    }];
}

@end