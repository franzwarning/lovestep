//
//  Instrument.h
//  lovestep
//
//  Created by Raymond Kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kInstrumentTypePiano,
    kInstrumentTypeGuitar,
    kInstrumentTypeBass,
    kInstrumentTypeDrums
} InstrumentType;

@interface Instrument : NSObject

- (id)initWithName:(NSString *)name soundFont:(NSString *)soundFont;
- (instancetype)initWithType:(InstrumentType)instrumentType;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *soundFont;

@end
