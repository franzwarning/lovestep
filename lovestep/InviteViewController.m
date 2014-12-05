//
//  InviteViewController.m
//  lovestep
//
//  Created by Raymond Kennedy on 12/4/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import "InviteViewController.h"

@interface InviteViewController () <UITableViewDataSource, UITableViewDelegate>{
    UISearchBar *_searchBar;
    UITableView *_tableView;
    
}

@end

@implementation InviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Find User";
    
    // Setup search bar
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 44)];
    [self.view addSubview:searchBar];
    
    // Add the tableview
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 44, self.view.bounds.size.width, self.view.bounds.size.height - 64 + 44)];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [self.view addSubview:_tableView];
}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *constant = @"tableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:constant];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:constant];
    }
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"invited_user"] && [[[NSUserDefaults standardUserDefaults] valueForKey:@"invited_user"] boolValue]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [cell.textLabel setText:@"Raymond Kennedy"];
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"invited_user"] && [[[NSUserDefaults standardUserDefaults] valueForKey:@"invited_user"] boolValue]) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:NO] forKey:@"invited_user"];
    } else {
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:YES] forKey:@"invited_user"];

    }
    
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
