//
//  LoopVisualizerView.m
//  lovestep
//
//  Created by Raymond Kennedy on 12/4/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import "LoopVisualizerView.h"
#import "BeatBrain.h"
#import "Loop.h"

@interface LoopVisualizerView () <BeatBrainDelegate> {
    NSMutableArray *_loopViews;
}

@end

@implementation LoopVisualizerView

#pragma mark Init

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        // Set background color
        [self setBackgroundColor:[UIColor lightGrayColor]];
        
        // Add self to bbDelegate
        [[BeatBrain sharedBrain] setBbDelegate:self];
        
        // Init the loopviews array
        _loopViews = [[NSMutableArray alloc] init];
        [self _setupLoopViews];
    }
    return self;
}

#pragma mark Private Methods

- (void)_setupLoopViews {
    
    for (Loop *loop in [[BeatBrain sharedBrain] loops]) {
        
    }
    
}

#pragma mark BeatBrainDelegate Methods

- (void)didChangeBeat:(NSInteger)beat {
//    NSLog(@"Beat: %d", (int)beat);
}

@end
