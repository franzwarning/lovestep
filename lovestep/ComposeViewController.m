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

static const NSInteger kControlXPadding = 10;
static const NSInteger kControlStartY = 44;
static const NSInteger kControlYPadding = 10;

@interface ComposeViewController () <StepSequencerDelegate, BeatBrainDelegate> {
    StepSequencerView *_ssv;
    Loop *_activeLoop;
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
        
        // Setupt the active loop
        _activeLoop = [[Loop alloc] initWithLength:16
                                              name:@"Test Loop"
                                        instrument:instrument
                                              user:1];
        
    }
    
    return self;
}

#pragma mark ViewController Life Cycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Setup the beat brain
    [[BeatBrain sharedBrain] setBbDelegate:self];
    [[BeatBrain sharedBrain] setActiveLoop:_activeLoop];

}

#pragma mark StepSequencerDelegate Methods

- (void)cellChanged:(CellView *)cell
{
    NSInteger row = cell.row;
    NSInteger col = cell.col;
    BOOL isOn = cell.isOn;
    
    _activeLoop.grid[col][row] = [NSNumber numberWithBool:isOn];
}

- (void)_setupStepSequencerView {
    _ssv = [[StepSequencerView alloc] initWithFrame:CGRectMake(100, 0, 567, 375)];
    [_ssv setBackgroundColor:[UIColor lightGrayColor]];
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
    
    CGFloat yOrigin = kControlStartY;
    
    // Add loop button
    UIButton *addLoopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addLoopButton setTitle:@"Add Loop" forState:UIControlStateNormal];
    [addLoopButton.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
    [addLoopButton setFrame:CGRectMake(kControlXPadding, yOrigin, 80, 40)];
    [addLoopButton.layer setBorderColor:[UIColor colorWithHue:0.47 saturation:0.86 brightness:0.74 alpha:1].CGColor];
    [addLoopButton.layer setBorderWidth:3.0f];
    [addLoopButton.layer setCornerRadius:6.f];
    [addLoopButton setTitleColor:[UIColor colorWithHue:0.47 saturation:0.86 brightness:0.74 alpha:1] forState:UIControlStateNormal];
    [addLoopButton setTitleColor:[UIColor colorWithHue:0.47 saturation:0.86 brightness:0.74 alpha:.3] forState:UIControlStateHighlighted];
    
    [addLoopButton addTarget:self action:@selector(_addLoop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addLoopButton];
    
    yOrigin += addLoopButton.frame.size.height + kControlYPadding;
    
    // Clear grid button
    UIButton *clearGridButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearGridButton setTitle:@"Clear" forState:UIControlStateNormal];
    [clearGridButton.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
    [clearGridButton setFrame:CGRectMake(kControlXPadding, yOrigin, 80, 40)];
    [clearGridButton.layer setBorderColor:[UIColor colorWithHue:0.57 saturation:0.76 brightness:0.86 alpha:1].CGColor];
    [clearGridButton.layer setBorderWidth:3.0f];
    [clearGridButton.layer setCornerRadius:6.f];
    [clearGridButton setTitleColor:[UIColor colorWithHue:0.57 saturation:0.76 brightness:0.86 alpha:1] forState:UIControlStateNormal];
    [clearGridButton setTitleColor:[UIColor colorWithHue:0.57 saturation:0.76 brightness:0.86 alpha:.3] forState:UIControlStateHighlighted];
    
    [clearGridButton addTarget:self action:@selector(_clearLoop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearGridButton];
}

- (void)_clearLoop:(id)sender
{
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
