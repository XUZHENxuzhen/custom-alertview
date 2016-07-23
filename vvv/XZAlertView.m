


//
//  XZAlertView.m
//  vvv
//
//  Created by angelwin on 16/7/18.
//  Copyright © 2016年 com@angelwin. All rights reserved.
//
#define MainScreenRect [UIScreen mainScreen].bounds
#define AlertView_W     200.0f
#define MessageMin_H    60.0f       //messagelab的最小高度
#define MessageMAX_H    120.0f      //messagelab的最大高度，当超过时，文本会以...结尾
#define XZATitle_H      20.0f
#define XZABtn_H        30.0f

#define SFQBlueColor        [UIColor colorWithRed:9/255.0 green:170/255.0 blue:238/255.0 alpha:1]
#define SFQRedColor         [UIColor colorWithRed:221/255.0 green:64/255.0 blue:19/255.0 alpha:1]
#define SFQLightGrayColor   [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1]

#define XZADTitleFont       [UIFont boldSystemFontOfSize:17];
#define XZADMessageFont     [UIFont systemFontOfSize:14];
#define XZADBtnTitleFont    [UIFont systemFontOfSize:15];



#import "XZAlertView.h"

@interface XZAlertView ()

@property (nonatomic,strong)UIWindow *alertWindow;
@property (nonatomic,strong)UIView *alertView;

@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UILabel *messageLab;
@property (nonatomic,strong)UIButton *cancelBtn;
@property (nonatomic,strong)UIButton *otherBtn;

@end

@implementation XZAlertView

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle clickIndexBlock:(XZAlertClickIndexBlock)block{
    if(self=[super init]){
        self.frame=MainScreenRect;
        self.backgroundColor=[UIColor colorWithWhite:.3 alpha:0.7];
        
        _alertView=[[UIView alloc] init];
        _alertView.backgroundColor=[UIColor whiteColor];
        _alertView.layer.cornerRadius=6.0;
        _alertView.layer.masksToBounds=YES;
        _alertView.userInteractionEnabled=YES;
        
        
        if (title) {
            _titleLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, AlertView_W, XZATitle_H)];
            _titleLab.text=title;
            _titleLab.textAlignment=NSTextAlignmentCenter;
            _titleLab.textColor=[UIColor blackColor];
            _titleLab.font=XZADTitleFont;
            
        }
        
        CGFloat messageLabSpace = 10;
        _messageLab=[[UILabel alloc] init];
        _messageLab.backgroundColor=[UIColor whiteColor];
        _messageLab.text=message;
        _messageLab.textColor=[UIColor lightGrayColor];
        _messageLab.font=XZADMessageFont;
        _messageLab.numberOfLines=0;
        _messageLab.textAlignment=NSTextAlignmentCenter;
        _messageLab.lineBreakMode=NSLineBreakByTruncatingTail;
      
        _messageLab.frame=CGRectMake(10, _titleLab.frame.size.height+_titleLab.frame.origin.y+10, AlertView_W-messageLabSpace*2, 50);
        
        
        //计算_alertView的高度
        _alertView.frame=CGRectMake(0, 0, AlertView_W, _messageLab.frame.size.height+XZATitle_H+XZABtn_H+40);
        _alertView.center=self.center;
        [self addSubview:_alertView];
        [_alertView addSubview:_titleLab];
        [_alertView addSubview:_messageLab];
        
        if (cancelTitle) {
            _cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [_cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
            [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_cancelBtn setBackgroundImage:[UIImage imageWithColor:SFQLightGrayColor] forState:UIControlStateNormal];
            _cancelBtn.titleLabel.font=XZADBtnTitleFont;
            _cancelBtn.layer.cornerRadius=3;
            _cancelBtn.layer.masksToBounds=YES;
            [_cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_alertView addSubview:_cancelBtn];
        }
        
        if (otherBtnTitle) {
            _otherBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [_otherBtn setTitle:otherBtnTitle forState:UIControlStateNormal];
            [_otherBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _otherBtn.titleLabel.font=XZADBtnTitleFont;
            _otherBtn.layer.cornerRadius=3;
            _otherBtn.layer.masksToBounds=YES;
            [_otherBtn setBackgroundImage:[UIImage imageWithColor:SFQRedColor] forState:UIControlStateNormal];
            [_otherBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_alertView addSubview:_otherBtn];
        }
        
        CGFloat btnLeftSpace = 10;//btn到左边距
        CGFloat btn_y = _alertView.frame.size.height-40;
        if (cancelTitle && !otherBtnTitle) {
            _cancelBtn.tag=0;
            _cancelBtn.frame=CGRectMake(btnLeftSpace, btn_y, AlertView_W-btnLeftSpace*2, XZABtn_H);
        }else if (!cancelTitle && otherBtnTitle){
            _otherBtn.tag=0;
            _otherBtn.frame=CGRectMake(btnLeftSpace, btn_y, AlertView_W-btnLeftSpace*2, XZABtn_H);
        }else if (cancelTitle && otherBtnTitle){
            _cancelBtn.tag=0;
            _otherBtn.tag=1;
            CGFloat btnSpace = 10;//两个btn之间的间距
            CGFloat btn_w =(AlertView_W-btnLeftSpace*2-btnSpace)/2;
            _cancelBtn.frame=CGRectMake(btnLeftSpace, btn_y, btn_w, XZABtn_H);
            _otherBtn.frame=CGRectMake(_alertView.frame.size.width-btn_w-btnLeftSpace, btn_y, btn_w, XZABtn_H);
        }
        
        self.clickBlock=block;
        
    }
    return self;
}


-(void)btnClick:(UIButton *)btn{
    
    if (self.clickBlock) {
        self.clickBlock(btn.tag);
    }
    
    if (!_dontDissmiss) {
        [self dismissAlertView];
    }
    
}

-(void)setDontDissmiss:(BOOL)dontDissmiss{
    _dontDissmiss=dontDissmiss;
}

-(void)showXZAlertView{
    _alertWindow=[[UIWindow alloc] initWithFrame:MainScreenRect];
    _alertWindow.windowLevel=UIWindowLevelAlert;
    [_alertWindow becomeKeyWindow];
    [_alertWindow makeKeyAndVisible];
    
    [_alertWindow addSubview:self];
    
    [self setShowAnimation];
    
}
- (void)setShowAnimation{
    
    CGPoint startPoint = CGPointMake(-AlertView_W, self.center.y);
    _alertView.layer.position=startPoint;
    
    //damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
    //velocity:弹性复位的速度
    [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        _alertView.layer.position=self.center;
        
    } completion:^(BOOL finished) {
        
    }];
}





-(void)dismissAlertView{
    [self removeFromSuperview];
    [_alertWindow resignKeyWindow];
}
@end

@implementation UIImage (Colorful)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end


