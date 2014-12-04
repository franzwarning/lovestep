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
