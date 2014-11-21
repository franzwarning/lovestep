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

@interface ComposeViewController () <StepSequencerDelegate, BeatBrainDelegate> {
    SoundGen *_soundGen;
    StepSequencerView *_ssv;
    Loop *_activeLoop;
}

@end

@implementation ComposeViewController

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

- (void)didChangeBeat:(NSInteger)beat
{
    [_ssv beatDidChange:beat];
}

- (void)_addLoop:(id)sender
{
    // Add loop logic here

}

- (void)_cancelComposition:(id)sender
{
    [(RotationAwareNavigationController *)self.navigationController orientPortrait];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
