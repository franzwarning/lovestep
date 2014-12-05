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
#import "Instrument.h"
#import "LuvColorScheme.h"

//static const NSInteger kMidiNoteVelocity = 90;
static const NSInteger kBaseMidiNote = 48;
static const int kPentatonicIntervals[] = { 0,  3,  5,  7, 10, 12, 15, 17, 19, 22, 24, 27, 29, 31, 34};
static const int kDiatonicIntervals[] = { 0,  2,  4,  5,  7,  9, 11, 12, 14, 16, 17, 19, 21, 23 };

@interface BeatBrain ()  {
    NSTimer *_timer;
    NSTimer *_multiplayerCheck;
    NSTimer *_multiplayerTimer;
    
    NSMutableArray *_lastNotes;
    NSDate *_startTime;
    NSInteger _counter;
    SoundGen *_bassSoundGen;
    SoundGen *_pianoSoundGen;
    SoundGen *_guitarSoundGen;
    SoundGen *_drumSoundGen;
    NSMutableArray *_soundGens;
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
    self.loops = [[NSMutableArray alloc] init];
    self.bpm = 180;
    self.scale = kScaleTypePentatonic;
    _counter = 0;
    
    //
    _soundGens = [[NSMutableArray alloc] init];
    _delegates = [[NSMutableArray alloc] init];
    
    self.colorScheme = [LuvColorScheme randomColorScheme];
    
    // Setup SoundGen stuff
    NSURL *guitarURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"soundfonts" ofType:@"sf2"]];
    _guitarSoundGen = [[SoundGen alloc] initWithSoundFontURL:guitarURL patchNumber:26 bankNumber:0];
    
    NSURL *bassURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"soundfonts" ofType:@"sf2"]];
    _bassSoundGen = [[SoundGen alloc] initWithSoundFontURL:bassURL patchNumber:32 bankNumber:0];
    
    NSURL *drumURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"soundfonts" ofType:@"sf2"]];
    _drumSoundGen = [[SoundGen alloc] initWithSoundFontURL:drumURL patchNumber:25 bankNumber:120];
    
    NSURL *pianoURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"soundfonts" ofType:@"sf2"]];
    _pianoSoundGen = [[SoundGen alloc] initWithSoundFontURL:pianoURL patchNumber:2 bankNumber:0];
    
    [_soundGens addObject:_guitarSoundGen];
    [_soundGens addObject:_bassSoundGen];
    [_soundGens addObject:_drumSoundGen];
    [_soundGens addObject:_pianoSoundGen];
    
}

- (void)begin {
    _startTime = [NSDate date];
    _timer = [NSTimer scheduledTimerWithTimeInterval:60./self.bpm target:self selector:@selector(_timerCalled:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    // Add the timer that see's if there is a multiplayer user
    _multiplayerCheck = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(_checkForMultiplayer:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_multiplayerCheck forMode:NSRunLoopCommonModes];

}

- (void)_checkForMultiplayer:(id)sender {
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"invited_user"] && [[[NSUserDefaults standardUserDefaults] valueForKey:@"invited_user"] boolValue] && ![_multiplayerTimer isValid]) {
        _multiplayerTimer = [NSTimer scheduledTimerWithTimeInterval:20.f target:self selector:@selector(_addRandomLoop:) userInfo:nil repeats:YES];
        [_multiplayerTimer fire];
        [[NSRunLoop mainRunLoop] addTimer:_multiplayerTimer forMode:NSRunLoopCommonModes];

    } else {
        [_multiplayerTimer invalidate];
    }
}

- (void)_addRandomLoop:(id)sender {
    [self addLoop:[Loop randomLoop]];
}



- (void)bpmUpdated {
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:60./self.bpm target:self selector:@selector(_timerCalled:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)_timerCalled:(id)sender {
    [self _playBeat:_counter];
    _counter = (_counter + 1) % 16;
}

- (void)_playBeat:(NSInteger)beat {

    for (id <BeatBrainDelegate>delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(didChangeBeat:)]) {
            [delegate didChangeBeat:beat];
        }
    }
    
    for (SoundGen *soundGen in _soundGens) {
        if (![soundGen isEqual:_drumSoundGen]) {
            [soundGen stopPlayingAllNotes];
        }
    }
    
    for (Loop *loop in self.loops) {
        [self _playColumn:beat forLoop:loop];
    }
    
    [self _playColumn:beat forLoop:_activeLoop];
}

- (void)_playColumn:(NSInteger)column forLoop:(Loop *)loop {
    for (int j = 0; j < kHeight; j++) {
        if ([loop.grid[column][j] boolValue]) {
            
            //Select midi
            int step = kHeight - 1 - j;
            int midi = kBaseMidiNote;
            if (loop.instrument.type == kInstrumentTypeDrums) {
                //drum stuff
                midi = 47 - j;
                
            } else {
                if (self.scale == kScaleTypePentatonic) {
                    midi = kBaseMidiNote + kPentatonicIntervals[step];
                } else if (self.scale == kScaleTypeDiatonic) {
                    midi = kBaseMidiNote + kDiatonicIntervals[step];
                }
            }
            
            //Select velocity (mix instruments)
            int velocity = 90;
            switch (loop.instrument.type) {
                case kInstrumentTypeDrums:  velocity = 90; break;
                case kInstrumentTypeGuitar: velocity = 90; break;
                case kInstrumentTypeBass:   velocity = 90; break;
                case kInstrumentTypePiano:  velocity = 70; break;
            }
            
            [self _playNote:midi withInstrumentType:loop.instrument.type velocity:velocity];
            
        }
    }
}

- (void)_playNote:(NSInteger)midiNote withInstrumentType:(InstrumentType)instrumentType velocity:(NSInteger)velocity {
    
    if (instrumentType == kInstrumentTypePiano) {
        [_pianoSoundGen playMidiNote:midiNote velocity:velocity];
    } else if (instrumentType == kInstrumentTypeGuitar) {
        [_guitarSoundGen playMidiNote:midiNote velocity:velocity];
    } else if (instrumentType == kInstrumentTypeBass) {
        midiNote -= 12;
        [_bassSoundGen playMidiNote:midiNote velocity:velocity];
    } else if (instrumentType == kInstrumentTypeDrums) {
        [_drumSoundGen playMidiNote:midiNote velocity:velocity];
    }
    
}

- (void)addLoop:(Loop *)newLoop {
    
    if ([[self loops] count] >= kMaxLoops) {
        return;
    }
    
    [self.loops addObject:newLoop];
    
    for (id <BeatBrainDelegate>delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(didAddLoop:)]) {
            [delegate didAddLoop:newLoop];
        }
    }
}

- (void)removeLoop:(Loop *)loop {
    
    [self.loops removeObject:loop];
    
    if ([[[BeatBrain sharedBrain] loops] count] == 0) {
        self.colorScheme = [LuvColorScheme randomColorScheme];
    }
    
    for (id <BeatBrainDelegate>delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(didRemoveLoop)]) {
            [delegate didRemoveLoop];
        }
    }
}

- (void)setScaleType:(ScaleType)type {
    self.scale = type;
}


@end
