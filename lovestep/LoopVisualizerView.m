//
//  LoopVisualizerView.m
//  lovestep
//
//  Created by Raymond Kennedy on 12/4/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import "LoopVisualizerView.h"
#import "Loop.h"
#import "RingView.h"

static const NSInteger kNumBeats = 16;

@interface LoopVisualizerView () {
    NSMutableArray *_ringViews;
    UIView *_cursor;
    CGFloat _currentOuterRadius;
}

@end

@implementation LoopVisualizerView

#pragma mark Init

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        // Set background color
        [self setBackgroundColor:[UIColor whiteColor]];
        
        _currentOuterRadius = 50;
        
        // Add self to bbDelegate
        [[BeatBrain sharedBrain] setBbDelegate:self];
        
        // Init the loopviews array
        _ringViews = [[NSMutableArray alloc] init];
        
        // Add the cursor
        [self _setupCursor];
    }
    return self;
}

#pragma mark Private Methods

- (void)_addRingViewForLoop:(Loop *)loop {
    
    CGFloat outerRadius = _currentOuterRadius + 20;
    CGFloat innerRadius = outerRadius - 20;
    RingView *newRing = [self createRingWithOuterRadius:outerRadius innerRadius:innerRadius loop:loop];
    [newRing setCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
    [self addSubview:newRing];
    
    [_ringViews addObject:newRing];
    _currentOuterRadius += 40;
}

- (void)_setupCursor {
    _cursor = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 50)];
    [_cursor setBackgroundColor:[UIColor redColor]];
    [_cursor setCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
    [_cursor.layer setAnchorPoint:CGPointMake(0.5, 1.0)];
    [_cursor.layer setBorderColor:[UIColor whiteColor].CGColor];
    [_cursor.layer setBorderWidth:1.f];
    [_cursor.layer setCornerRadius:1.f];
    [self addSubview:_cursor];
}

- (RingView *)createRingWithOuterRadius:(CGFloat)outerRadius innerRadius:(CGFloat)innerRadius loop:(Loop *)loop {
    
    return [[RingView alloc] initWithFrame:CGRectMake(0, 0, outerRadius*2, outerRadius*2) outerRadius:outerRadius innerRadius:innerRadius loop:loop];
    
}

#pragma mark BeatBrainDelegate Methods

- (void)didChangeBeat:(NSInteger)beat {
        
    if (beat == 0) {

        CGFloat duration  = 60 / ([[BeatBrain sharedBrain] bpm] / (CGFloat)kNumBeats);
        
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = @(M_PI * 2);
        rotationAnimation.duration = duration;
        rotationAnimation.autoreverses = NO;
        rotationAnimation.repeatCount = 0;
        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [_cursor.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];

    }
}

- (void)didAddLoop:(Loop *)loop {
    [self _addRingViewForLoop:loop];
}

@end
