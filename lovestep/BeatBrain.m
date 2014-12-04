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

static const NSInteger kBaseMidiNote = 60;

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
            [_soundGen playMidiNote:(kBaseMidiNote - j) velocity:90];
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
