//
//  ViewController.m
//  lovestep
//
//  Created by Raymond kennedy on 11/19/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import "LandingViewController.h"
#import "BeatBrain.h"

@interface LandingViewController () {
    UIScrollView *_scrollView;
}

@end

static const CGFloat kButtonOriginY = 40.f;
static const CGFloat kButtonPaddingY = 20.f;
static const CGFloat kButtonWidth = 300.f;
static const CGFloat kButtonHeight = 100.f;


@implementation LandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup the scrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [_scrollView setAlwaysBounceVertical:YES];
    [self.view addSubview:_scrollView];
        
    [self _createButtons];
}

- (void)_createButtons {
    
    CGFloat currentY = 0;
    currentY += kButtonOriginY;
    
    UIButton *newSessionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [newSessionButton setFrame:CGRectMake(self.view.frame.size.width/2 - kButtonWidth/2, currentY, kButtonWidth, kButtonHeight)];
    [newSessionButton.layer setBorderColor:[UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1].CGColor];
    [newSessionButton.layer setBorderWidth:3.f];
    [newSessionButton.layer setCornerRadius:6.f];
    [newSessionButton setTitle:@"New Session" forState:UIControlStateNormal];
    [newSessionButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30.f]];
    [newSessionButton setTitleColor:[UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1] forState:UIControlStateNormal];
    [newSessionButton setTitleColor:[UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:.6f] forState:UIControlStateHighlighted];
    [newSessionButton addTarget:self action:@selector(_createNewSession:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:newSessionButton];
    
}

- (void)_createNewSession:(id)sender {
    [[BeatBrain sharedBrain] begin];

    [self performSegueWithIdentifier:@"mainViewController" sender:self];
}

@end
