//
//  MainViewController.m
//  lovestep
//
//  Created by Raymond Kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import "MainViewController.h"
#import "RotationAwareNavigationController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Add the right navbar item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(_addLoop:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(_settingsHit:)];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)_settingsHit:(id)sender {
    
}

- (void)_addLoop:(id)sender {
    [(RotationAwareNavigationController *)self.navigationController orientLeft];
    [self performSegueWithIdentifier:@"composeViewController" sender:self];
}

@end
