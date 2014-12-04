//
//  MainViewController.m
//  lovestep
//
//  Created by Raymond Kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import "LoopViewController.h"
#import "RotationAwareNavigationController.h"
#import "ComposeViewController.h"
#import "Instrument.h"

@interface LoopViewController () <UIActionSheetDelegate>

@end

@implementation LoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Add the right navbar item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(_addLoop:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(_settingsHit:)];
}

- (void)_settingsHit:(id)sender {
    
}

- (void)_addLoop:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Pick an Instrument" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Piano", @"Bass", @"Guitar", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    Instrument *instrument = nil;
    
    if (buttonIndex == 0) {
        
        instrument = [[Instrument alloc] initWithName:@"Piano" soundFont:@"piano"];
        
        // Piano was hit
        [(RotationAwareNavigationController *)self.navigationController orientLeft];
        ComposeViewController *cvc = [[ComposeViewController alloc] initWithInstrument:instrument];
        [self.navigationController pushViewController:cvc animated:YES];
        
    } else if (buttonIndex == 1) {
        // Bass was hit
    } else if (buttonIndex == 2) {
        // Guitar was hit
    } else if (buttonIndex == 3) {
        // Cancel was hit

    }
}

@end
