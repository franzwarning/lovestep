//
//  Loop.m
//  lovestep
//
//  Created by Raymond Kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import "Loop.h"

@interface Loop () {

}

@end

@implementation Loop

- (id)init
{
    self = [super init];
    if (self) {
        self.length = 16;
        self.name = @"default_name";
        self.grid = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < self.length; i++) {
            NSMutableArray *column = [[NSMutableArray alloc] init];
            
            for (int j = 0; j < kOctave; j++) {
                
                if (j == 0) {
                   column[j] = [NSNumber numberWithBool:YES];
                } else {
                    column[j] = [NSNumber numberWithBool:NO];
                }
                
            }
            
            self.grid[i] = column;
        }
    }
    return self;
}

@end
