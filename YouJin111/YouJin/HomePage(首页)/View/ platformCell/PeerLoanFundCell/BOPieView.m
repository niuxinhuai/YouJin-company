//
//  BOPieView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/1.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOPieView.h"

@implementation BOPieView

- (void)drawRect:(CGRect)rect {
    //1.获取跟View相关联的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat radius = rect.size.width * 0.5;
    //2.0 描述第一部分路径
    CGFloat startA = - M_PI_2;
    CGFloat endA = startA + 0.35 * M_PI * 2;
    
       //第一部分画弧
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    
    [BOColor(242, 106, 85) set];
    [path addLineToPoint:center];
    CGContextAddPath(ctx, path.CGPath);
    CGContextFillPath(ctx);
    
    // 2.1描述第二条路径
    CGFloat startA2 = endA;
    CGFloat endA2 = startA2 + 0.12 * M_PI * 2;
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA2 endAngle:endA2 clockwise:YES];
    [BOColor(140, 198, 63) set];
    [path2 addLineToPoint:center];
    CGContextAddPath(ctx, path2.CGPath);
    CGContextFillPath(ctx);
    // 2.2 描述第三条路径
    CGFloat startA3 = endA2;
    CGFloat endA3 = startA3 + 0.08 * M_PI * 2;
    UIBezierPath *path3 = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA3 endAngle:endA3 clockwise:YES];
    [BOColor(75, 153, 248) set];
    [path3 addLineToPoint:center];
    CGContextAddPath(ctx, path3.CGPath);
    CGContextFillPath(ctx);
    // 2.3 描述其他的路径
    CGFloat startA4 = endA3;
    CGFloat endA4 = startA4 + 0.45 * M_PI * 2;
    UIBezierPath *path4 = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA4 endAngle:endA4 clockwise:YES];
    [BOColor(251, 176, 59) set];
    [path4 addLineToPoint:center];
    CGContextAddPath(ctx, path4.CGPath);
    CGContextFillPath(ctx);
    // 2.4 绘制中心的那个圆
    CGFloat startA5 = - M_PI_2;
    CGFloat endA5 = startA5 + M_PI * 2;
    CGFloat radius1 = 15 * BOScreenW / BOPictureW;
    UIBezierPath *path5 = [UIBezierPath bezierPathWithArcCenter:center radius:radius1 startAngle:startA5 endAngle:endA5 clockwise:YES];
    [BOColor(252, 252, 252) set];
    [path5 addLineToPoint:center];
    CGContextAddPath(ctx, path5.CGPath);
    //4.把上下文的内容渲染到view的layer
    //CGContextStrokePath(ctx);
    CGContextFillPath(ctx);

}

@end
