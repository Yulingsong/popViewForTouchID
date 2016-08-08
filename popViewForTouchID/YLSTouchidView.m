//
//  YLSTouchidView.m
//  popViewForTouchID
//
//  Created by yulingsong on 16/8/5.
//  Copyright © 2016年 yulingsong. All rights reserved.
//

#import "YLSTouchidView.h"


@interface YLSTouchidView()<WJTouchIDDelegate>

/** 指纹解锁的button */
@property (nonatomic,strong) UIButton *touchIdBtn;
/** 头像 */
@property (nonatomic,strong) UIImageView *iconView;
/** 用户名 */
@property (nonatomic,strong) UILabel *nameLabel;
/** 提示信息 */
@property (nonatomic,strong) UILabel *noticeLabel;
/** 手机号 */
@property (nonatomic,strong) NSString *phoneNumber;
/** 退出按钮 */
@property (nonatomic,strong) UIButton *quitBtn;

@property (nonatomic, strong) WJTouchID *touchID;

@end

@implementation YLSTouchidView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:YLSScreenBounds];
    
    if (self)
    {
        self.backgroundColor = [UIColor orangeColor];
        
    }
    //调用指纹解锁
    WJTouchID *touchid = [[WJTouchID alloc]init];
    [touchid startWJTouchIDWithMessage:WJNotice(@"自定义信息", @"The Custom Message") fallbackTitle:WJNotice(@"", @"Fallback Title") delegate:self];
    self.touchID = touchid;
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.iconView = [[UIImageView alloc]init];
    [self.iconView setFrame:ZLRect(128/320, 54/568, 65/320, 65/568)];
    [self.iconView setImage:[UIImage imageNamed:@"icon_myinformation"]];
    [self addSubview:self.iconView];
    
    self.nameLabel = [[UILabel alloc]init];
    [self.nameLabel setFrame:ZLRect(0, 125/568, 1, 28/568)];
    [self.nameLabel setText:@"151****1234"];
    [self.nameLabel setFont:[UIFont systemFontOfSize:ZCFont(15/375)]];
    [self.nameLabel setTextColor:[UIColor whiteColor]];
    [self.nameLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:self.nameLabel];
    
    self.touchIdBtn = [[UIButton alloc]init];
    [self.touchIdBtn setFrame:ZLRect(120/320, 250/568, 80/320, 80/568)];
    [self.touchIdBtn setImage:[UIImage imageNamed:@"touchImg"] forState:UIControlStateNormal];
    [self.touchIdBtn addTarget:self action:@selector(clickToCheckTouchID) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.touchIdBtn];
    
    self.noticeLabel = [[UILabel alloc]init];
    [self.noticeLabel setFrame:ZLRect(0, 339/568, 1, 22/568)];
    [self.noticeLabel setText:@"点击进行指纹解锁"];
    [self.noticeLabel setTextColor:[UIColor whiteColor]];
    [self.noticeLabel setTextAlignment:NSTextAlignmentCenter];
    [self.noticeLabel setFont:[UIFont systemFontOfSize:ZCFont(16/375)]];
    [self addSubview:self.noticeLabel];
    
    self.quitBtn = [[UIButton alloc]init];
    [self.quitBtn setFrame:ZLRect(0, 520/568, 1, 30/568)];
    [self.quitBtn setTitle:@"退出" forState:UIControlStateNormal];
    [self.quitBtn addTarget:self action:@selector(quitContent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.quitBtn];
    
}

/**
 *  快速创建
 */
+ (instancetype)touchIDView
{
    return [[self alloc]init];
}

/** 弹出 */
- (void)show
{
    [self showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)showInView:(UIView *)view
{
    // 浮现
    [view addSubview:self];
}


-(void)clickToCheckTouchID
{
    NSLog(@"点击了指纹解锁");
    [self.touchID startWJTouchIDWithMessage:WJNotice(@"自定义信息", @"The Custom Message") fallbackTitle:WJNotice(@"", @"Fallback Title") delegate:self];
}

-(void)quitContent
{
    NSLog(@"点击了quit");
    [UIView animateWithDuration:3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    

}

/**
 *  TouchID验证成功
 */
- (void) WJTouchIDAuthorizeSuccess {
    [MBProgressHUD showText:@"解锁成功" view:self];
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self removeFromSuperview];
}

/**
 *  TouchID验证失败
 */
- (void) WJTouchIDAuthorizeFailure {
    [MBProgressHUD showText:@"解锁失败" view:self];
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
}
/**
 *  取消TouchID验证 (用户点击了取消)
 */
- (void) WJTouchIDAuthorizeErrorUserCancel {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
}


/**
 *  在验证的TouchID的过程中被系统取消 例如突然来电话、按了Home键、锁屏...
 */
- (void) WJTouchIDAuthorizeErrorSystemCancel {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
}

/**
 *  无法启用TouchID,设备没有设置密码
 */
- (void) WJTouchIDAuthorizeErrorPasscodeNotSet {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
}

/**
 *  设备没有录入TouchID,无法启用TouchID
 */
- (void) WJTouchIDAuthorizeErrorTouchIDNotEnrolled {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
}

/**
 *  该设备的TouchID无效
 */
- (void) WJTouchIDAuthorizeErrorTouchIDNotAvailable {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
}

/**
 *  多次连续使用Touch ID失败，Touch ID被锁，需要用户输入密码解锁
 */
- (void) WJTouchIDAuthorizeLAErrorTouchIDLockout {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
}

/**
 *  当前软件被挂起取消了授权(如突然来了电话,应用进入前台)
 */
- (void) WJTouchIDAuthorizeLAErrorAppCancel {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
}

/**
 *  当前软件被挂起取消了授权 (授权过程中,LAContext对象被释)
 */
- (void) WJTouchIDAuthorizeLAErrorInvalidContext {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
}
/**
 *  当前设备不支持指纹识别
 */
-(void)WJTouchIDIsNotSupport {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
}







@end
