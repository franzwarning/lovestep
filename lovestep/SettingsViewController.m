//
//  SettingsViewController.m
//  lovestep
//
//  Created by Raymond kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import "SettingsViewController.h"
#import "BeatBrain.h"
#import "LuvButton.h"

@interface SettingsViewController () {
    UILabel *bpmLabel;
}

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(_exitSettings:)];
    
    int width = self.view.bounds.size.width;
    int leftBound = 10;
    int rightBound = width - leftBound;
    int changeBPMDim = 80;
    
    int row1Y = 100;
    int row2Y = 200;
    int row3Y = 300;
    int row4y = 550;
    int buttonHeight = changeBPMDim;
    
    float fontSizeBPMLabel = 45.0;
    float fontSizeChangeBPM = 40.0;
    float fontSizeChangeScale = 30.0;
    
    NSInteger bpm = [[BeatBrain sharedBrain] bpm];
    
    //BPM Label
    bpmLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftBound, row1Y, rightBound - leftBound, changeBPMDim)];
    bpmLabel.text = [NSString stringWithFormat:@"%d bpm", (int)bpm];
    bpmLabel.textAlignment = NSTextAlignmentCenter;
    bpmLabel.font = [UIFont systemFontOfSize:fontSizeBPMLabel];
    [self.view addSubview:bpmLabel];
    
    //Increase BPM button
    LuvButton *increaseBPMButton = [LuvButton buttonWithType:UIButtonTypeCustom];
    [increaseBPMButton setTitle:@"+" forState:UIControlStateNormal];
    [increaseBPMButton.titleLabel setFont:[UIFont systemFontOfSize:fontSizeChangeBPM]];
    [increaseBPMButton setFrame:CGRectMake(rightBound - changeBPMDim, row1Y, changeBPMDim, changeBPMDim)];
    [increaseBPMButton.layer setBorderColor:[UIColor colorWithHue:0.57 saturation:0.76 brightness:0.86 alpha:1].CGColor];
    [increaseBPMButton.layer setBorderWidth:3.0f];
    [increaseBPMButton.layer setCornerRadius:6.f];
    [increaseBPMButton setTitleColor:[UIColor colorWithHue:0.57 saturation:0.76 brightness:0.86 alpha:1] forState:UIControlStateNormal];
    [increaseBPMButton addTarget:self action:@selector(_increaseBpm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:increaseBPMButton];
    
    //Decrease BPM button
    LuvButton *decreaseBPMButton = [LuvButton buttonWithType:UIButtonTypeCustom];
    [decreaseBPMButton setTitle:@"-" forState:UIControlStateNormal];
    [decreaseBPMButton.titleLabel setFont:[UIFont systemFontOfSize:fontSizeChangeBPM]];
    [decreaseBPMButton setFrame:CGRectMake(leftBound, row1Y, changeBPMDim, changeBPMDim)];
    [decreaseBPMButton.layer setBorderColor:[UIColor colorWithHue:0.57 saturation:0.76 brightness:0.86 alpha:1].CGColor];
    [decreaseBPMButton.layer setBorderWidth:3.0f];
    [decreaseBPMButton.layer setCornerRadius:6.f];
    [decreaseBPMButton setTitleColor:[UIColor colorWithHue:0.57 saturation:0.76 brightness:0.86 alpha:1] forState:UIControlStateNormal];
    [decreaseBPMButton addTarget:self action:@selector(_decreaseBpm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:decreaseBPMButton];
    
    //5 Note scale button
    LuvButton *pentatonicButton = [LuvButton buttonWithType:UIButtonTypeCustom];
    [pentatonicButton setTitle:@"5 Note Scale" forState:UIControlStateNormal];
    [pentatonicButton.titleLabel setFont:[UIFont systemFontOfSize:fontSizeChangeScale]];
    [pentatonicButton setFrame:CGRectMake(leftBound, row2Y, rightBound - leftBound, buttonHeight)];
    [pentatonicButton.layer setBorderColor:[UIColor colorWithHue:0.57 saturation:0.76 brightness:0.86 alpha:1].CGColor];
    [pentatonicButton.layer setBorderWidth:3.0f];
    [pentatonicButton.layer setCornerRadius:6.f];
    [pentatonicButton setTitleColor:[UIColor colorWithHue:0.57 saturation:0.76 brightness:0.86 alpha:1] forState:UIControlStateNormal];
    [pentatonicButton addTarget:self action:@selector(_setPentatonicScale) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pentatonicButton];
    
    //7 Note scale button
    LuvButton *diatonicButton = [LuvButton buttonWithType:UIButtonTypeCustom];
    [diatonicButton setTitle:@"7 Note Scale" forState:UIControlStateNormal];
    [diatonicButton.titleLabel setFont:[UIFont systemFontOfSize:fontSizeChangeScale]];
    [diatonicButton setFrame:CGRectMake(leftBound, row3Y, rightBound - leftBound, buttonHeight)];
    [diatonicButton.layer setBorderColor:[UIColor colorWithHue:0.57 saturation:0.76 brightness:0.86 alpha:1].CGColor];
    [diatonicButton.layer setBorderWidth:3.0f];
    [diatonicButton.layer setCornerRadius:6.f];
    [diatonicButton setTitleColor:[UIColor colorWithHue:0.57 saturation:0.76 brightness:0.86 alpha:1] forState:UIControlStateNormal];
    [diatonicButton addTarget:self action:@selector(_setDiatonicScale) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:diatonicButton];
    
    // Invite Page Button
    LuvButton *inviteButton = [LuvButton buttonWithType:UIButtonTypeCustom];
    [inviteButton setTitle:@"Invite User" forState:UIControlStateNormal];
    [inviteButton.titleLabel setFont:[UIFont systemFontOfSize:fontSizeChangeScale]];
    [inviteButton setFrame:CGRectMake(leftBound, row4y, rightBound - leftBound, buttonHeight)];
    [inviteButton.layer setBorderColor:[UIColor colorWithHue:0.57 saturation:0.76 brightness:0.86 alpha:1].CGColor];
    [inviteButton.layer setBorderWidth:3.0f];
    [inviteButton.layer setCornerRadius:6.f];
    [inviteButton setTitleColor:[UIColor colorWithHue:0.57 saturation:0.76 brightness:0.86 alpha:1] forState:UIControlStateNormal];
    [inviteButton addTarget:self action:@selector(_inviteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:inviteButton];
    
    
}

- (void)_inviteButtonClicked:(id)sender {
    [self performSegueWithIdentifier:@"InviteViewController" sender:self];
}

- (void)_increaseBpm {
    NSInteger bpm = [[BeatBrain sharedBrain] bpm];
    bpm += 10;
    [[BeatBrain sharedBrain] setBpm:bpm];
    [[BeatBrain sharedBrain] bpmUpdated];
    bpmLabel.text = [NSString stringWithFormat:@"%d bpm", (int)bpm];
}

- (void)_decreaseBpm {
    NSInteger bpm = [[BeatBrain sharedBrain] bpm];
    bpm -= 10;
    [[BeatBrain sharedBrain] setBpm:bpm];
    [[BeatBrain sharedBrain] bpmUpdated];
    bpmLabel.text = [NSString stringWithFormat:@"%d bpm", (int)bpm];
}

- (void)_setPentatonicScale {
    [[BeatBrain sharedBrain] setScaleType:kScaleTypePentatonic];
}

- (void)_setDiatonicScale {
    [[BeatBrain sharedBrain] setScaleType:kScaleTypeDiatonic];
}

- (void)_exitSettings:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
