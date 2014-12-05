//
//  RingView.m
//  lovestep
//
//  Created by Raymond Kennedy on 12/4/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import "RingView.h"
#import "Loop.h"

@interface RingView () {
    CGFloat _outerRadius;
    CGFloat _innerRadius;
}

@end

@implementation RingView

- (id)initWithFrame:(CGRect)frame outerRadius:(CGFloat)outerRadius innerRadius:(CGFloat)innerRadius loop:(Loop *)loop {
    self = [super initWithFrame:frame];
    if (self) {
        
        _outerRadius = outerRadius;
        _innerRadius = innerRadius;
        self.loop = loop;
                
        [self.layer setCornerRadius:outerRadius];
        [self.layer setMasksToBounds:YES];
        [self setOpaque:NO];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGRect innerRect = CGRectMake(_outerRadius - _innerRadius, _outerRadius - _innerRadius, _innerRadius*2, _innerRadius*2);
    UIBezierPath *bigPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:_outerRadius];
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:CGRectInfinite];
    UIBezierPath *smallPath = [UIBezierPath bezierPathWithRoundedRect:innerRect cornerRadius:_innerRadius];
    [clipPath appendPath:smallPath];
    [clipPath setUsesEvenOddFillRule:YES];
    
    CGContextSaveGState(UIGraphicsGetCurrentContext()); {
        [clipPath addClip];
        [self.loop.color setFill];
        [bigPath fill];
    } CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

@end
