//
//  ComposeViewController.m
//  lovestep
//
//  Created by Raymond Kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import "ComposeViewController.h"
#import "RotationAwareNavigationController.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Frame: (%f, %f, %f, %f)", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    
    // Setup navigation stuff
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelComposition:)];
    
    // Set the title for the step sequencer
    self.title = @"Compose A Loop";
}

- (void)viewDidAppear:(BOOL)animated
{
    [(RotationAwareNavigationController *)self.navigationController orientLeft];
}

- (void)cancelComposition:(id)sender
{
    [(RotationAwareNavigationController *)self.navigationController orientPortrait];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
