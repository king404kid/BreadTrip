//
//  TestResponderChainController.m
//  Breadtrip
//
//  Created by Feng on 15/11/18.
//  Copyright (c) 2015年 Feng. All rights reserved.
//

#import "TestResponderChainController.h"
#import <PureLayout.h>

@interface TestResponderChainController ()

@property (nonatomic, strong) UIView *greenView;
@property (nonatomic, strong) UIView *blueView;
@property (nonatomic, strong) UIButton *testBtn;

@end

@implementation TestResponderChainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _greenView = [[UIView alloc] init];
    [_greenView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:_greenView];
    [_greenView autoPinEdgesToSuperviewEdges];
    
    _blueView = [[UIView alloc] init];
    [_blueView setBackgroundColor:[UIColor blueColor]];
    [_greenView addSubview:_blueView];
    [_blueView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_blueView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_blueView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_greenView];
    [_blueView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_greenView withMultiplier:1/2.0];
    
    _testBtn = [[UIButton alloc] init];
    [_blueView addSubview:_testBtn];
    [_testBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_testBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_testBtn setTitle:@"test" forState:UIControlStateNormal];
//    [_testBtn setUserInteractionEnabled:false];   // 注意这里如果btn不会把事件往上传递，除非手动把Interaction改为false
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler:)];
    [_blueView addGestureRecognizer:tap];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];    // 调用super方法，可以让事件冒泡往上传递，否则就别调用
    
    NSLog(@"touchesBegan: controller");
}

- (void)tapGestureHandler:(UITapGestureRecognizer*)sender {
    NSLog(@"tap trigger");
}

@end