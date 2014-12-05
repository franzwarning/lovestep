//
//  ColorScheme.m
//  lovestep
//
//  Created by Raymond Kennedy on 12/5/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import "LuvColorScheme.h"
#import "Colours.h"
#import "NSMutableArray+Utils.h"

static NSArray *starterColors = nil;

static NSInteger kNumColors = 14;

@interface LuvColorScheme () {
    NSMutableArray *_colorsInScheme;
}

@end

@implementation LuvColorScheme

- (id)init {
    self = [super init];
    if (self) {
        starterColors = @[
                          [UIColor colorWithRed:0.1 green:0.74 blue:0.61 alpha:1],
                          [UIColor colorWithRed:0.09 green:0.63 blue:0.52 alpha:1],
                          [UIColor colorWithRed:0.18 green:0.8 blue:0.44 alpha:1],
                          [UIColor colorWithRed:0.15 green:0.68 blue:0.38 alpha:1],
                          [UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1],
                          [UIColor colorWithRed:0.16 green:0.5 blue:0.73 alpha:1],
                          [UIColor colorWithRed:0.61 green:0.35 blue:0.71 alpha:1],
                          [UIColor colorWithRed:0.56 green:0.27 blue:0.68 alpha:1],
                          [UIColor colorWithRed:0.95 green:0.77 blue:0.06 alpha:1],
                          [UIColor colorWithRed:0.95 green:0.61 blue:0.07 alpha:1],
                          [UIColor colorWithRed:0.9 green:0.49 blue:0.13 alpha:1],
                          [UIColor colorWithRed:0.83 green:0.33 blue:0 alpha:1],
                          [UIColor colorWithRed:0.91 green:0.3 blue:0.24 alpha:1],
                          [UIColor colorWithRed:0.75 green:0.22 blue:0.17 alpha:1]
                          ];
        
        [self _fillColors];
    }
    return self;
}

+ (instancetype)randomColorScheme {
    LuvColorScheme *cs = [[LuvColorScheme alloc] init];
    return cs;
}

- (UIColor *)colorForIndex:(NSInteger)index {
    index = index % [_colorsInScheme count];
    return [_colorsInScheme objectAtIndex:index];
}

- (void)_fillColors {
    
    int rand = arc4random() % (kNumColors - 1);
    if (rand == (kNumColors - 1)) rand = (int)(kNumColors - 2);
    if (rand % 2 != 0) rand--;
    
    // Get the two random starter colors
    UIColor *firstColor = [starterColors objectAtIndex:rand];
    UIColor *secondColor = [starterColors objectAtIndex:rand + 1];
    
    NSArray *scheme1 = [firstColor colorSchemeOfType:ColorSchemeAnalagous];
    NSArray *scheme2 = [secondColor colorSchemeOfType:ColorSchemeAnalagous];
    
    _colorsInScheme = [[NSMutableArray alloc] initWithArray:scheme1];
    [_colorsInScheme addObjectsFromArray:scheme2];
    
    [_colorsInScheme shuffle];
    
}
@end
