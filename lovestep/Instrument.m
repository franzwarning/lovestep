//
//  Instrument.m
//  lovestep
//
//  Created by Raymond Kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import "Instrument.h"

@implementation Instrument

- (id)initWithName:(NSString *)name soundFont:(NSString *)soundFont {
    self = [super init];
    if (self)  {
        self.name = name;
        self.soundFont = soundFont;
    }
    return self;
}

@end
