//
//  YLSTouchidView.h
//  popViewForTouchID
//
//  Created by yulingsong on 16/8/5.
//  Copyright © 2016年 yulingsong. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface YLSTouchidView : UIView

/**
 *  快速创建
 */
+(instancetype)touchIDView;

/**
 *  弹出
 */
-(void)show;
-(void)showInView:(UIView *)view;

@end
