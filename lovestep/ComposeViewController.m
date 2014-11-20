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
}

- (void)viewDidAppear:(BOOL)animated
{
    [(RotationAwareNavigationController *)self.navigationController orientLeft];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [(RotationAwareNavigationController *)self.navigationController orientPortrait];
}


@end
