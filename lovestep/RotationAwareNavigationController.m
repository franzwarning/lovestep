//
//  RotationAwareNavigationController.m
//  lovestep
//
//  Created by Raymond kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import "RotationAwareNavigationController.h"
#import "ComposeViewController.h"
#import "LoopViewController.h"

@interface RotationAwareNavigationController () {
    BOOL _isRotating;
}

@end

@implementation RotationAwareNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _isRotating = NO;
}

- (BOOL)shouldAutorotate
{
    if (_isRotating) {
        return YES;
    } else {
        return NO;
    }
}

- (void)orientLeft {
    _isRotating = YES;
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationLandscapeLeft] forKey:@"orientation"];
    [self performSelector:@selector(_rotationDone) withObject:nil afterDelay:1.0f];
}

- (void)_rotationDone {
    _isRotating = NO;
}

- (void)orientPortrait {
    _isRotating = YES;
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationPortrait] forKey:@"orientation"];
    [self performSelector:@selector(_rotationDone) withObject:nil afterDelay:1.0f];
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft;
}

@end
