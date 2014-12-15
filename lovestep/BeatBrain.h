//
//  BeatBrain.h
//  lovestep
//
//  Created by Raymond Kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int kMaxLoops = 10;

@class Loop;
@class LuvColorScheme;
@class Instrument;

@protocol BeatBrainDelegate <NSObject>


@optional

- (void)didChangeBeat:(NSInteger)beat;
- (void)didAddLoop:(Loop *)loop;
- (void)didRemoveLoop;

@end


@interface BeatBrain : NSObject

typedef enum {
   kScaleTypePentatonic,
   kScaleTypeDiatonic
} ScaleType;

@property (nonatomic) NSInteger bpm;
@property (nonatomic, strong) Loop *activeLoop;
@property (nonatomic, strong) NSMutableArray *loops;
@property (nonatomic, strong) NSMutableArray *delegates;
@property (nonatomic) ScaleType scale;
@property (nonatomic, strong) LuvColorScheme *colorScheme;

+ (id)sharedBrain;

- (void)addLoop:(Loop *)newLoop;
- (void)removeLoop:(Loop *)loop;
- (void)begin;
- (void)setScaleType:(ScaleType)type;
- (void)bpmUpdated;
- (void)playSingleNote:(NSInteger)note withInstrument:(Instrument *)instrument;

@end
