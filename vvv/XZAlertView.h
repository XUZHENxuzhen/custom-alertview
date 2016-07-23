//
//  XZAlertView.h
//  vvv
//
//  Created by angelwin on 16/7/18.
//  Copyright © 2016年 com@angelwin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XZAlertClickIndexBlock)(NSInteger clickIndex);

@interface XZAlertView : UIView


@property (nonatomic,copy)XZAlertClickIndexBlock clickBlock;

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle clickIndexBlock:(XZAlertClickIndexBlock)block;

/**
 *  showXZAlertView
 */
-(void)showXZAlertView;

/**
 *  不隐藏，默认为NO。设置为YES时点击按钮alertView不会消失（适合在强制升级时使用）
 */
@property (nonatomic,assign)BOOL dontDissmiss;
@end



@interface UIImage (colorful)
//a image using a color
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
