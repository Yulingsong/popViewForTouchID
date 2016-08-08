//
//  ViewController.m
//  TouchidTest
//
//  Created by yulingsong on 16/8/4.
//  Copyright © 2016年 yulingsong. All rights reserved.
//



#import "ViewController.h"

@interface ViewController ()<WJTouchIDDelegate>
/** NoticeLabel */
@property (nonatomic,strong) UILabel *label;
/** UISwitch */
@property (nonatomic,strong) UISwitch *touchIDSwitch;

@property (nonatomic, strong) WJTouchID *touchID;

@end

@implementation ViewController

-(UISwitch *)touchIDSwitch
{
    if (!_touchIDSwitch)
    {
        self.touchIDSwitch = [[UISwitch alloc]init];
    }
    return _touchIDSwitch;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubViews];
}

-(void)setSubViews
{
    self.label = [[UILabel alloc]init];
    [self.view addSubview:self.label];
    [self.label setFrame:ZLRect(0, 100/667, 1, 20/667)];
    [self.label setText:@"指纹解锁"];
    [self.label setTextAlignment:NSTextAlignmentCenter];
    [self.label setFont:[UIFont systemFontOfSize:ZCFont(18/375)]];
    
    self.touchIDSwitch = [[UISwitch alloc]init];
    [self.touchIDSwitch setFrame:ZLRect(160/375, 200/667, 50/375, 28/667)];
    [self.view addSubview:self.touchIDSwitch];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"TouchID"] isEqualToString:@"1"])
    {
        self.touchIDSwitch.on = YES;
    }else
    {
        self.touchIDSwitch.on = NO;
    }
    [self.touchIDSwitch addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)changeSwitch:(id)sender
{
    NSLog(@"------changeSwitch-------");

    WJTouchID *touchid = [[WJTouchID alloc]init];
    [touchid startWJTouchIDWithMessage:WJNotice(@"自定义信息", @"The Custom Message") fallbackTitle:WJNotice(@"", @"Fallback Title") delegate:self];
    self.touchID = touchid;
}
//TouchID验证成功
- (void) WJTouchIDAuthorizeSuccess {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
    if (self.touchIDSwitch.on == YES)
    {
        [MBProgressHUD showText:@"成功开启指纹解锁" view:self.view];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"TouchID"];
    }else{
        [MBProgressHUD showText:@"指纹解锁关闭成功" view:self.view];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"TouchID"];
    }
}

//TouchID验证失败
- (void) WJTouchIDAuthorizeFailure {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
    if (self.touchIDSwitch.on == YES){
        self.touchIDSwitch.on = NO;
        [MBProgressHUD showText:@"指纹解锁开启失败" view:self.view];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"TouchID"];
    }else
    {
        self.touchIDSwitch.on = YES;
        [MBProgressHUD showText:@"指纹解锁关闭失败" view:self.view];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"TouchID"];
    }
}

//取消TouchID验证 (用户点击了取消)
- (void) WJTouchIDAuthorizeErrorUserCancel {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
    if (self.touchIDSwitch.on == YES){
        self.touchIDSwitch.on = NO;
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"TouchID"];
    }else
    {
        self.touchIDSwitch.on = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"TouchID"];
    }
}

//在验证的TouchID的过程中被系统取消 例如突然来电话、按了Home键、锁屏
- (void) WJTouchIDAuthorizeErrorSystemCancel {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
    if (self.touchIDSwitch.on == YES){
        self.touchIDSwitch.on = NO;
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"TouchID"];
    }else
    {
        self.touchIDSwitch.on = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"TouchID"];
    }
}

//多次连续使用Touch ID失败，Touch ID被锁，需要用户输入密码解锁
- (void) WJTouchIDAuthorizeLAErrorTouchIDLockout {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
    [MBProgressHUD showText:@"验证失败" view:self.view];
}

//当前软件被挂起取消了授权(如突然来了电话,应用进入前台)
- (void) WJTouchIDAuthorizeLAErrorAppCancel {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
    if (self.touchIDSwitch.on == YES){
        self.touchIDSwitch.on = NO;
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"TouchID"];
    }else
    {
        self.touchIDSwitch.on = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"TouchID"];
    }
}

//当前软件被挂起取消了授权 (授权过程中,LAContext对象被释)
- (void) WJTouchIDAuthorizeLAErrorInvalidContext {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
    if (self.touchIDSwitch.on == YES){
        self.touchIDSwitch.on = NO;
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"TouchID"];
    }else
    {
        self.touchIDSwitch.on = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"TouchID"];
    }
}



@end
