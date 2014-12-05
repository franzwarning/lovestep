//
//  BeatBrain.h
//  lovestep
//
//  Created by Raymond Kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Loop;

@protocol BeatBrainDelegate <NSObject>

- (void)didChangeBeat:(NSInteger)beat;

@optional

- (void)didAddLoop:(Loop *)loop;

@end


@interface BeatBrain : NSObject

typedef enum {
   kScaleTypePentatonic,
   kScaleTypeDiatonic
} ScaleType;

@property (nonatomic) NSInteger bpm;
@property (nonatomic, strong) Loop *activeLoop;
@property (nonatomic, strong) NSMutableArray *loops;

@property (nonatomic, strong) id <BeatBrainDelegate>bbDelegate;
@property (nonatomic) ScaleType scale;

+ (id)sharedBrain;

- (void)addLoop:(Loop *)newLoop;
- (void)removeLoop:(Loop *)loop;
- (void)begin;
- (void)setScaleType:(ScaleType)type;
- (void)bpmUpdated;

@end
