//
//  ViewController.m
//  Test
//
//  Created by 张大亮 on 15/12/28.
//  Copyright © 2015年 张大亮. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()
{
    UITapGestureRecognizer *tap;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 80, 20)];
    label.text=@"zhang";
    label.tag=1;
    label.backgroundColor=[UIColor grayColor];
    label.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:label];
    tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGeust:)];
    [self.view addGestureRecognizer:tap];
//    画一个圆
    UIGraphicsBeginImageContext(CGSizeMake(320,460));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextAddArc(ctx, self.view.frame.size.width/2-20 ,200, 100, 0, 2*M_PI, 1);
    CGContextDrawPath(ctx, kCGPathStroke);
    UIImage *curve = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    imageView.image = curve;
    [self.view addSubview:imageView];
//    设置运转动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration =30;
    pathAnimation.repeatCount =99999;
    //设置运转动画的路径
    CGMutablePathRef curvedPath = CGPathCreateMutable();
        CGPathAddArc(curvedPath, NULL, self.view.frame.size.width/2-20, 200, 100, M_PI / 6, M_PI / 6 + 2 * M_PI, 0);
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    [label.layer addAnimation:pathAnimation forKey:@"moveTheCircleOne"];
}
-(void)tapGeust:(UITapGestureRecognizer *)tapGuest
{
    UILabel *label=(UILabel *)[self.view viewWithTag:1];
//    找到当前view上面的tap被覆盖的区域触发
    CGPoint tapPoint=[tapGuest locationInView:self.view];
    if ([label.layer.presentationLayer hitTest:tapPoint]) {
        NSLog(@"hello");
    }
}
@end
