//
//  BeatBrain.h
//  lovestep
//
//  Created by Raymond Kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Loop;

@interface BeatBrain : NSObject

@property (nonatomic) NSInteger bpm;

+ (id)sharedBrain;

- (void)addLoop:(Loop *)newLoop;
- (void)begin;

@end
