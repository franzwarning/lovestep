//
//  Loop.m
//  lovestep
//
//  Created by Raymond Kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import "Loop.h"
#import "Instrument.h"
#import "BeatBrain.h"
#import "Colours.h"
#import "LuvColorScheme.h"

const NSUInteger NUMBER_OF_CHARS = 40 ;

@implementation Loop

- (id)initWithLength:(NSInteger)length name:(NSString *)name instrument:(Instrument *)instrument user:(NSInteger)user {
    self = [super init];
    if (self) {
        self.length = length;
        self.name = name;
        self.instrument = instrument;
        self.user = user;
        self.number = [[[BeatBrain sharedBrain] loops] count] + 1;
        self.enabled = YES;
        self.color = [[[BeatBrain sharedBrain] colorScheme] colorForIndex:self.number - 1];
        
        _uniqueId = [self generateUniqueId];
        
        // Clear the grid
        self.grid = [[NSMutableArray alloc] init];
        [self _emptyGrid];
    }
    
    return self;
}

+ (instancetype)randomLoop {
    Loop *newLoop = [[Loop alloc] initWithLength:16
                                            name:@""
                                      instrument:[Instrument randomInstrument]
                                            user:1];
    [newLoop setName:[NSString stringWithFormat:@"Randomay %d", (int)newLoop.number]];
    [newLoop procedurallyGenerateGrid];
    return newLoop;
}

- (void)procedurallyGenerateGrid {
   [self _emptyGrid];
   int denominator = 10;
   for (int i = 0; i < self.length; i++) {
      int numerator = 4;
      if (i % 4 == 0) numerator += 4;
      if (arc4random_uniform(denominator) < numerator) {
         int row = arc4random_uniform(kHeight);
         self.grid[i][row] = [NSNumber numberWithBool:YES];
      }
   }
}

- (void)_emptyGrid {
    for (int i = 0; i < self.length; i++) {
        NSMutableArray *column = [[NSMutableArray alloc] init];
        for (int j = 0; j < kHeight; j++) {
            column[j] = [NSNumber numberWithBool:NO];
        }
        
        self.grid[i] = column;
    }
}

- (NSString *)generateUniqueId {
    static char const possibleChars[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    unichar characters[NUMBER_OF_CHARS];
    for( int index=0; index < NUMBER_OF_CHARS; ++index )
    {
        characters[ index ] = possibleChars[arc4random_uniform(sizeof(possibleChars)-1)];
    }
    
    return [ NSString stringWithCharacters:characters length:NUMBER_OF_CHARS ] ;
}
@end
