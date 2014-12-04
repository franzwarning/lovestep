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
#import "BeatBrain.h"
#import "Loop.h"
#import "LoopVisualizerView.h"
#import "SettingsViewController.h"

@interface LoopViewController () <UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;
    BOOL _tableViewIsEmpty;
    LoopVisualizerView *_lvv;
}

@end

@implementation LoopViewController

#pragma mark ViewController Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Add the right navbar item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(_addLoop:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(_settingsHit:)];
    
    // Setup the table view
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2 + 32, self.view.bounds.size.width, self.view.bounds.size.height/2 - 32)];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView.layer setBorderColor:[UIColor colorWithRed:0.89 green:0.89 blue:0.9 alpha:1].CGColor];
    [_tableView.layer setBorderWidth:1.f];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // If there are no loops tell them to add some
    if ([[[BeatBrain sharedBrain] loops] count] == 0) {
        _tableViewIsEmpty = YES;
    } else {
        _tableViewIsEmpty = NO;
    }
    
    // Setup the loop visualizer view
    _lvv = [[LoopVisualizerView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height/2 - 32)];
    
    // Add the views as subvies
    [self.view addSubview:_lvv];
    [self.view addSubview:_tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([[[BeatBrain sharedBrain] loops] count] == 0) {
        _tableViewIsEmpty = YES;
    } else {
        _tableViewIsEmpty = NO;
    }
    
    [_tableView reloadData];
}

#pragma mark UITableViewDataSource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *constant = @"tableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:constant];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:constant];
    }
    
    if (_tableViewIsEmpty) {
        cell.textLabel.text = @"Tap + to add a loop!";
    } else {
        Loop *currentLoop = [[[BeatBrain sharedBrain] loops] objectAtIndex:indexPath.row];
        [cell.textLabel setText:[NSString stringWithFormat:@"%@: %@", [currentLoop.instrument getTypeName], currentLoop.name]];
    }
  
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_tableViewIsEmpty) return 1;
    return [[[BeatBrain sharedBrain] loops] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Private Methods

- (void)_settingsHit:(id)sender {
    SettingsViewController *svc = [[SettingsViewController alloc] init];
    [self presentViewController:svc animated:YES completion:nil];
}

- (void)_addLoop:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Pick an Instrument" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Piano", @"Bass", @"Guitar", @"Drums", nil];
    [actionSheet showInView:self.view];
}

#pragma mark UIActionSheetDelegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    // The instrument we are trying to select
    Instrument *instrument = nil;
    
    if (buttonIndex == 0) {
        instrument = [[Instrument alloc] initWithType:kInstrumentTypePiano];
    } else if (buttonIndex == 1) {
        instrument = [[Instrument alloc] initWithType:kInstrumentTypeBass];
    } else if (buttonIndex == 2) {
        instrument = [[Instrument alloc] initWithType:kInstrumentTypeGuitar];
    } else if (buttonIndex == 3) {
        instrument = [[Instrument alloc] initWithType:kInstrumentTypeDrums];
    } else if (buttonIndex == 4) {
        // Cancel was hit
        return;
    }
    
    // Piano was hit
    [(RotationAwareNavigationController *)self.navigationController orientLeft];
    ComposeViewController *cvc = [[ComposeViewController alloc] initWithInstrument:instrument];
    [self.navigationController pushViewController:cvc animated:YES];
}

@end
