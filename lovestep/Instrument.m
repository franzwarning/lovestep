//
//  Instrument.m
//  lovestep
//
//  Created by Raymond Kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import "Instrument.h"

@implementation Instrument

- (id) initWithType:(InstrumentType)type {
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

+ (instancetype)randomInstrument {
    
    InstrumentType it = 0;
    
    switch (arc4random() % 3){
        case 0:
            it = kInstrumentTypePiano;
            break;
        case 1:
            it = kInstrumentTypeGuitar;
            break;
        case 2:
            it = kInstrumentTypeDrums;
            break;
        case 3:
            it = kInstrumentTypeBass;
            break;
    }
    
    return [[Instrument alloc] initWithType:it];
}

- (NSString *)soundFontForInstrumentType:(InstrumentType)instrumentType {
    switch (self.type) {
        case kInstrumentTypePiano:  return @"piano";
        case kInstrumentTypeDrums:  return @"drum";
        case kInstrumentTypeGuitar: return @"guitar";
        case kInstrumentTypeBass:   return @"bass";
    }
}

- (NSString *)getTypeName {
    switch (self.type) {
        case kInstrumentTypePiano:  return @"Piano";
        case kInstrumentTypeDrums:  return @"Drums";
        case kInstrumentTypeGuitar: return @"Guitar";
        case kInstrumentTypeBass:   return @"Bass";
    }
    return @"Instrument";
}

@end
