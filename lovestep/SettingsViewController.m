//
//  SettingsViewController.m
//  lovestep
//
//  Created by Raymond kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(_exitSettings:)];

}

- (void)_exitSettings:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
