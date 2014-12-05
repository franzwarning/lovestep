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

#define DEGREES_RADIANS(angle) ((angle) / 180.0 * M_PI)

static const NSInteger kNumBeats = 16;

@interface LoopVisualizerView () {
    NSMutableArray *_ringViews;
    UIView *_cursor;
    CGFloat _currentOuterRadius;
    BOOL _cursorNeedsUpdate;
}

@end

@implementation LoopVisualizerView

#pragma mark Init

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        // Set background color
        [self setBackgroundColor:[UIColor whiteColor]];
        
        _currentOuterRadius = 30;
        
        // Add self to bbDelegate
        [[BeatBrain sharedBrain] setBbDelegate:self];
        
        // Init the loopviews array
        _ringViews = [[NSMutableArray alloc] init];
        
        // Add the cursor
        [self _setupCursor];
    }
    return self;
}

#pragma mark Public Methods

- (void)refreshLoops {
    
    _cursorNeedsUpdate = YES;
    
    // Go through each loop
    for (Loop *loop in [[BeatBrain sharedBrain] loops]) {
        
        BOOL hasRing = NO;
        
        // Check to see if we have a ring for that loop
        for (RingView *ringView in _ringViews) {
            if ([ringView.loop isEqual:loop]) {
                hasRing = YES;
            }
        }
        
        if (!hasRing) {
            [self _addRingViewForLoop:loop];
        }
    }
}

#pragma mark Private Methods

- (void)_addRingViewForLoop:(Loop *)loop {
    
    // Check to make sure the loops doesn't already exist
    CGFloat outerRadius = _currentOuterRadius + 20;
    CGFloat innerRadius = outerRadius - 20;
    RingView *newRing = [self createRingWithOuterRadius:outerRadius innerRadius:innerRadius loop:loop];
    [newRing setCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
    [self insertSubview:newRing belowSubview:_cursor];
    
    // Increase the cursor height
    if ([[[BeatBrain sharedBrain] loops] count] > 1) {
        
        _cursor.transform = CGAffineTransformIdentity;
        [_cursor.layer setAnchorPoint:CGPointMake(0.5, 1.0)];
        _cursor.frame = CGRectMake(_cursor.frame.origin.x, _cursor.frame.origin.y, _cursor.frame.size.width, _cursor.frame.size.height + 20);
        [_cursor setCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
    }


    [_ringViews addObject:newRing];
    _currentOuterRadius += 20;
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
    
    _cursorNeedsUpdate = NO;
}

- (RingView *)createRingWithOuterRadius:(CGFloat)outerRadius innerRadius:(CGFloat)innerRadius loop:(Loop *)loop {
    
    return [[RingView alloc] initWithFrame:CGRectMake(0, 0, outerRadius*2, outerRadius*2) outerRadius:outerRadius innerRadius:innerRadius loop:loop];
    
}

#pragma mark BeatBrainDelegate Methods

- (void)didChangeBeat:(NSInteger)beat {
        
    if (_cursorNeedsUpdate) {
        
        if ([_cursor.layer animationForKey:@"rotationAnimation"]) {
            [_cursor.layer removeAnimationForKey:@"rotationAnimation"];
        }
        
        CGFloat degs = (beat/(CGFloat)kNumBeats) * 360;
        CGFloat rads = DEGREES_RADIANS(degs);
        CGFloat toRads = (M_PI * 2) + rads;
        
        CGFloat duration  = 60 / ([[BeatBrain sharedBrain] bpm] / (CGFloat)kNumBeats);
        
        _cursor.transform = CGAffineTransformRotate(_cursor.transform, rads);
        
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = @(toRads);
        rotationAnimation.fromValue = @(rads);
        rotationAnimation.duration = duration;
        rotationAnimation.autoreverses = NO;
        rotationAnimation.repeatCount = HUGE_VALF;
        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [_cursor.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        
    }

    _cursorNeedsUpdate = NO;

}

- (void)didAddLoop:(Loop *)loop {
    [self _addRingViewForLoop:loop];
}

@end
