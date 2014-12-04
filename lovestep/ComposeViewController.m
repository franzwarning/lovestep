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

@interface ComposeViewController () <StepSequencerDelegate, BeatBrainDelegate> {
    SoundGen *_soundGen;
    StepSequencerView *_ssv;
    Loop *_activeLoop;
}

@end

@implementation ComposeViewController

#pragma mark ViewController Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Frame: (%f, %f, %f, %f)", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    
    // Setup navigation stuff
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(_cancelComposition:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(_addLoop:)];
    self.title = @"Compose A Loop";
    
    // Setup the step sequencer view
    [self _setupStepSequencerView];
    
    // Setup the step sequencer controls
    [self _setupControls];
    
    // Setup the beat brain
    _activeLoop = [[Loop alloc] initWithLength:16
                                          name:@"Test Loop"
                                    instrument:[[Instrument alloc] initWithName:@"Piano" soundFont:@"Piano" ]
                                          user:1];
    [[BeatBrain sharedBrain] setBbDelegate:self];
    [[BeatBrain sharedBrain] setActiveLoop:_activeLoop];
}

- (void)viewDidAppear:(BOOL)animated
{
    [(RotationAwareNavigationController *)self.navigationController orientLeft];
    
    // Create test loop
    Loop *newLoop = [[Loop alloc] init];
    newLoop.name = @"test loop";
    newLoop.instrument = [[Instrument alloc] initWithName:@"piano" soundFont:@"Piano"];
    
    [[BeatBrain sharedBrain] addLoop:newLoop];
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
    [addLoopButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [addLoopButton setFrame:CGRectMake(kControlXPadding, yOrigin, 80, 50)];
    [addLoopButton.layer setBorderColor:[UIColor greenColor].CGColor];
    [addLoopButton.layer setBorderWidth:3.0f];
    [addLoopButton.layer setCornerRadius:6.f];
    [addLoopButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [addLoopButton addTarget:self action:@selector(_addLoop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addLoopButton];
    
    yOrigin += addLoopButton.frame.size.height + 20;
    
    // Clear grid button
    UIButton *clearGridButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearGridButton setTitle:@"Clear" forState:UIControlStateNormal];
    [clearGridButton.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
    [clearGridButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [clearGridButton setFrame:CGRectMake(kControlXPadding, yOrigin, 80, 50)];
    [clearGridButton.layer setBorderColor:[UIColor greenColor].CGColor];
    [clearGridButton.layer setBorderWidth:3.0f];
    [clearGridButton.layer setCornerRadius:6.f];
    [clearGridButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
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
