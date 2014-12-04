//
//  BeatBrain.h
//  lovestep
//
//  Created by Raymond Kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BeatBrainDelegate <NSObject>

- (void)didChangeBeat:(NSInteger)beat;

@end

@class Loop;

@interface BeatBrain : NSObject

@property (nonatomic) NSInteger bpm;
@property (nonatomic, strong) Loop *activeLoop;
@property (nonatomic, strong) id <BeatBrainDelegate>bbDelegate;

+ (id)sharedBrain;

- (void)addLoop:(Loop *)newLoop;
- (void)removeLoop:(Loop *)loop;
- (void)begin;

@end
