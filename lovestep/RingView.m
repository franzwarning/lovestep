//
//  RingView.m
//  lovestep
//
//  Created by Raymond Kennedy on 12/4/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import "RingView.h"

@interface RingView () {
    CGFloat _outerRadius;
    CGFloat _innerRadius;
}

@end

@implementation RingView

- (id)initWithFrame:(CGRect)frame outerRadius:(CGFloat)outerRadius innerRadius:(CGFloat)innerRadius {
    self = [super initWithFrame:frame];
    if (self) {
        _outerRadius = outerRadius;
        _innerRadius = innerRadius;
        [self.layer setCornerRadius:outerRadius];
        [self.layer setMasksToBounds:YES];
        [self setOpaque:NO];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat green=(arc4random()%100) *.01;
    CGFloat blue=(arc4random()%100) * .01;
    CGFloat red=(arc4random()%100) *.01;
    UIColor *randColor=[UIColor colorWithRed:red green:green blue:blue alpha:1];

    CGRect innerRect = CGRectMake(_outerRadius - _innerRadius, _outerRadius - _innerRadius, _innerRadius*2, _innerRadius*2);
    UIBezierPath *bigPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:_outerRadius];
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:CGRectInfinite];
    UIBezierPath *smallPath = [UIBezierPath bezierPathWithRoundedRect:innerRect cornerRadius:_innerRadius];
    [clipPath appendPath:smallPath];
    [clipPath setUsesEvenOddFillRule:YES];
    
    CGContextSaveGState(UIGraphicsGetCurrentContext()); {
        [clipPath addClip];
        [randColor setFill];
        [bigPath fill];
    } CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

@end
