//
//  ComposeViewController.m
//  lovestep
//
//  Created by Raymond Kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import "ComposeViewController.h"
#import "RotationAwareNavigationController.h"
#import "SoundGen.h"
#import "Loop.h"
#import "Instrument.h"
#import "BeatBrain.h"
#import "StepSequencerView.h"
#import "CellView.h"
#import "LuvButton.h"

static const NSInteger kControlXPadding = 10;
static const NSInteger kControlYPadding = 10;

@interface ComposeViewController () <StepSequencerDelegate, BeatBrainDelegate> {
    StepSequencerView *_ssv;
    Loop *_activeLoop;
    NSInteger _onCount;
    LuvButton *_addLoopButton;
}

@end

@implementation ComposeViewController

#pragma mark Init Methods

- (instancetype)initWithInstrument:(Instrument *)instrument {
    self = [super init];
    if (self) {
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        // Setup navigation stuff
        [self.navigationItem setHidesBackButton:YES];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(_cancelComposition:)];
        self.title = @"Compose A Loop";
        
        // Setup the step sequencer view
        [self _setupStepSequencerView];
        
        // Setup the step sequencer controls
        [self _setupControls];

        // Set the on count to 0
        _onCount = 0;
        [_addLoopButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [_addLoopButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_addLoopButton setEnabled:NO];

        // Setupt the active loop
        _activeLoop = [[Loop alloc] initWithLength:16
                                              name:@""
                                        instrument:instrument
                                              user:0];
        [_activeLoop setName:[NSString stringWithFormat:@"Loop %d", (int)_activeLoop.number]];
    }
    
    return self;
}

#pragma mark ViewController Life Cycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Setup the beat brain
    if (![[[BeatBrain sharedBrain] delegates] containsObject:self]) {
        [[[BeatBrain sharedBrain] delegates] addObject:self];
    }
    [[BeatBrain sharedBrain] setActiveLoop:_activeLoop];

}

#pragma mark StepSequencerDelegate Methods

- (void)cellChanged:(CellView *)cell
{
    NSInteger row = cell.row;
    NSInteger col = cell.col;
    BOOL isOn = cell.isOn;
    
    if (isOn) _onCount++;
    else _onCount--;
    
    if (_onCount <= 0) {
        [_addLoopButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [_addLoopButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_addLoopButton setEnabled:NO];
    } else {
        [_addLoopButton.layer setBorderColor:[UIColor colorWithHue:0.47 saturation:0.86 brightness:0.74 alpha:1].CGColor];
        [_addLoopButton setTitleColor:[UIColor colorWithHue:0.47 saturation:0.86 brightness:0.74 alpha:1] forState:UIControlStateNormal];
        [_addLoopButton setEnabled:YES];
    }
    
    _activeLoop.grid[col][row] = [NSNumber numberWithBool:isOn];
}

- (void)_setupStepSequencerView {
    _ssv = [[StepSequencerView alloc] initWithFrame:CGRectMake(100, 0, 567, 375)];
    [_ssv setDelegate:self];
    [self.view addSubview:_ssv];
}

#pragma mark BeatBrainDelegate Methods

- (void)didChangeBeat:(NSInteger)beat
{
    [_ssv beatDidChange:beat];
}

#pragma mark Prive Methods

- (void)_setupControls {
    
    CGFloat clearLoopY = kControlYPadding + 36;
    CGFloat addLoopY = ((self.view.bounds.size.height/2) + (kControlYPadding/2) + 36/2);
    CGFloat controlAreaY = self.view.bounds.size.height - 36;
    CGFloat controlHeight = (controlAreaY/2) - (kControlYPadding * 2);
    
    // Add loop button
    _addLoopButton = [LuvButton buttonWithType:UIButtonTypeCustom];
    [_addLoopButton setTitle:@"Add" forState:UIControlStateNormal];
    [_addLoopButton.titleLabel setFont:[UIFont systemFontOfSize:20.f]];
    [_addLoopButton setFrame:CGRectMake(kControlXPadding, addLoopY, 80, controlHeight)];
    [_addLoopButton.layer setBorderColor:[UIColor colorWithHue:0.47 saturation:0.86 brightness:0.74 alpha:1].CGColor];
    [_addLoopButton.layer setBorderWidth:2.0f];
    [_addLoopButton.layer setCornerRadius:6.f];
    [_addLoopButton setTitleColor:[UIColor colorWithHue:0.47 saturation:0.86 brightness:0.74 alpha:1] forState:UIControlStateNormal];
    
    [_addLoopButton addTarget:self action:@selector(_addLoop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addLoopButton];
    
    // Clear grid button
    LuvButton *clearGridButton = [LuvButton buttonWithType:UIButtonTypeCustom];
    [clearGridButton setTitle:@"Clear" forState:UIControlStateNormal];
    [clearGridButton.titleLabel setFont:[UIFont systemFontOfSize:20.f]];
    [clearGridButton setFrame:CGRectMake(kControlXPadding, clearLoopY, 80, controlHeight)];
    [clearGridButton.layer setBorderColor:[UIColor colorWithHue:0.57 saturation:0.76 brightness:0.86 alpha:1].CGColor];
    [clearGridButton.layer setBorderWidth:2.0f];
    [clearGridButton.layer setCornerRadius:6.f];
    [clearGridButton setTitleColor:[UIColor colorWithHue:0.57 saturation:0.76 brightness:0.86 alpha:1] forState:UIControlStateNormal];
    
    [clearGridButton addTarget:self action:@selector(_clearLoop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearGridButton];
}

- (void)_clearLoop:(id)sender
{
    _onCount = 0;
    [_addLoopButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_addLoopButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_addLoopButton setEnabled:NO];
    [_ssv clearGrid];
    
    for (int i = 0; i < kNumCols; i++) {
        for (int j = 0; j < kNumRows; j++) {
            _activeLoop.grid[i][j] = [NSNumber numberWithBool:NO];
        }
    }
}

- (void)_addLoop:(id)sender
{
    // Add loop logic here
    [[BeatBrain sharedBrain] addLoop:_activeLoop];
    [[BeatBrain sharedBrain] setActiveLoop:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
    [(RotationAwareNavigationController *)self.navigationController orientPortrait];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)_cancelComposition:(id)sender
{
    // Get rid of the current loop
    [[BeatBrain sharedBrain] setActiveLoop:nil];
    
    [(RotationAwareNavigationController *)self.navigationController orientPortrait];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
