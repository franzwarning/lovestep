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


- (id)initWithLength:(NSInteger)length name:(NSString *)name instrument:(Instrument *)instrument user:(NSInteger)user {
    self = [super init];
    if (self) {
        self.length = length;
        self.name = name;
        self.instrument = instrument;
        self.user = user;
        
        // Clear the grid
        self.grid = [[NSMutableArray alloc] init];
        [self _emptyGrid];
    }
    
    return self;
}

- (void)_emptyGrid {
    for (int i = 0; i < self.length; i++) {
        NSMutableArray *column = [[NSMutableArray alloc] init];
        for (int j = 0; j < kOctave; j++) {
            column[j] = [NSNumber numberWithBool:NO];
        }
        
        self.grid[i] = column;
    }
}

@end
