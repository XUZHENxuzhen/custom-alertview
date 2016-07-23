//
//  ViewController.m
//  vvv
//
//  Created by angelwin on 16/6/22.
//  Copyright © 2016年 com@angelwin. All rights reserved.
//

#import "ViewController.h"
#import "XZAlertView.h"
@interface ViewController ()


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
   
  
  }

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    XZAlertView *alert=[[XZAlertView alloc] initWithTitle:@"提示" message:@"自定义alertview,可以自动适应文字内容。" cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
        NSLog(@"点击index====%ld",clickIndex);
    }];
    //alert.dontDissmiss=YES;
    //设置动画类型(默认是缩放)
    //_alert.animationStyle=XZASAnimationTopShake;
    [alert showXZAlertView];
}







- (void)test{
    CGPoint startPoint = CGPointMake(50, 300);
    CGPoint endPonit = CGPointMake(300, 300);
    CGPoint controlPonit = CGPointMake(170, 200);
    //    CALayer *layer1 =  [[CALayer alloc]init];
    //    layer1.frame = CGRectMake(startPoint.x, startPoint.y, 5, 5);
    //    layer1.backgroundColor = [UIColor redColor].CGColor;
    //
    //    CALayer *layer2 =  [[CALayer alloc]init];
    //    layer2.frame = CGRectMake(endPonit.x, endPonit.y, 5, 5);
    //    layer2.backgroundColor = [UIColor redColor].CGColor;
    //
    //    CALayer *layer3 =  [[CALayer alloc]init];
    //    layer3.frame = CGRectMake(controlPonit.x, controlPonit.y, 5, 5);
    //    layer3.backgroundColor = [UIColor redColor].CGColor;
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    [path moveToPoint:startPoint];
    [path addQuadCurveToPoint:endPonit controlPoint:controlPonit];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor blackColor].CGColor;
    [self.view.layer addSublayer:layer];
    //     [self.view.layer addSublayer:layer1];
    //     [self.view.layer addSublayer:layer2];
    //     [self.view.layer addSublayer:layer3];

}
@end
