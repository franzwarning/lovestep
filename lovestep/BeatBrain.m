//
//  BeatBrain.m
//  lovestep
//
//  Created by Raymond Kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import "BeatBrain.h"
#import "SoundGen.h"
#import "Loop.h"


static const NSInteger kBaseMidiNote = 48;
static const int kMinorPentatonicIntervals[] = { 0,  3,  5,  7, 10, 12, 15, 17, 19, 22, 24, 27, 29, 31, 34};
static const int kMajorDiatonicIntervals[] = { 0,  2,  4,  5,  7,  9, 11, 12, 14, 16, 17, 19, 21, 23 };


@interface BeatBrain ()  {
    NSTimer *_timer;
    NSMutableArray *_loops;
    NSMutableArray *_lastNotes;
    NSDate *_startTime;
    NSInteger _counter;
    SoundGen *_soundGen;
}

@end

@implementation BeatBrain

static BeatBrain *sharedBrain = nil;

+ (BeatBrain *)sharedBrain {
    if (nil != sharedBrain) {
        return sharedBrain;
    }
    
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedBrain = [[BeatBrain alloc] init];
        [sharedBrain _setupBrain];
        
    });
    
    return sharedBrain;
}

- (void)_setupBrain {
    _loops = [[NSMutableArray alloc] init];
    self.bpm = 180;
    self.scale = kScaleTypePentatonic;
    _counter = 0;
    
    // Setup SoundGen stuff
    NSURL *presetURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"guitar" ofType:@"sf2"]];
    _soundGen = [[SoundGen alloc] initWithSoundFontURL:presetURL patchNumber:1];
}

- (void)begin {
    _startTime = [NSDate date];
    _timer = [NSTimer scheduledTimerWithTimeInterval:60./self.bpm target:self selector:@selector(_timerCalled:) userInfo:nil repeats:YES];
}

- (void)_timerCalled:(id)sender {
    [self _playBeat:_counter];
    _counter = (_counter + 1) % 16;
}

- (void)_playBeat:(NSInteger)beat {
    
    if ([self.bbDelegate respondsToSelector:@selector(didChangeBeat:)]) {
        [self.bbDelegate didChangeBeat:beat];
    }
    
    [_soundGen stopPlayingAllNotes];
    
    for (Loop *loop in _loops) {
        [self _playColumn:beat forLoop:loop];
    }
    
    [self _playColumn:beat forLoop:_activeLoop];
}

- (void)_playColumn:(NSInteger)column forLoop:(Loop *)loop {
    for (int j = 0; j < kOctave; j++) {
        if ([loop.grid[column][j] boolValue]) {
           int step = kOctave - j - 1;
           //int midi = kBaseMidiNote + kMinorPentatonicIntervals[step];
           int midi = kBaseMidiNote + kMajorDiatonicIntervals[step];
           [_soundGen playMidiNote:(midi) velocity:90];
        }
    }
}

- (void)addLoop:(Loop *)newLoop {
    [_loops addObject:newLoop];
}

- (void)removeLoop:(Loop *)loop {
    [_loops removeObject:loop];
}


@end
