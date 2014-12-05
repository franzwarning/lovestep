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
    NSMutableArray *_loopViews;
    UIView *_cursor;
}

@end

@implementation LoopVisualizerView

#pragma mark Init

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        // Set background color
        [self setBackgroundColor:[UIColor whiteColor]];
        
        // Add self to bbDelegate
        [[BeatBrain sharedBrain] setBbDelegate:self];
        
        // Init the loopviews array
        _loopViews = [[NSMutableArray alloc] init];
        [self _resizeLoopViews];
        
        // Add the cursor
        [self _setupCursor];
    }
    return self;
}

#pragma mark Private Methods

- (void)_resizeLoopViews {
    
    for (int i = 0; i < 1; i++) {
        
        CGFloat outerRadius = 50 + 20*i;
        CGFloat innerRadius = outerRadius - 20;
        UIView *newRing = [self createRingWithOuterRadius:outerRadius innerRadius:innerRadius];
        [newRing setCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
        [self addSubview:newRing];
    }
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

- (UIView *)createRingWithOuterRadius:(CGFloat)outerRadius innerRadius:(CGFloat)innerRadius {
    
    return [[RingView alloc] initWithFrame:CGRectMake(0, 0, outerRadius*2, outerRadius*2) outerRadius:outerRadius innerRadius:innerRadius];
    
}

#pragma mark BeatBrainDelegate Methods

- (void)didChangeBeat:(NSInteger)beat {
    
    NSLog(@"Beat: %d", beat);
    
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
//    [self _organizeLoopViews];
}

@end
