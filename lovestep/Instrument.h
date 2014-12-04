//
//  Instrument.h
//  lovestep
//
//  Created by Raymond Kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Instrument : NSObject

typedef enum {
   kInstrumentTypePiano,
   kInstrumentTypeDrums,
   kInstrumentTypeGuitar,
   kInstrumentTypeBass
} InstrumentType;

- (id)initWithType:(InstrumentType)type soundFont:(NSString *)soundFont;
- (NSString *) getTypeName;

@property (nonatomic) InstrumentType type;
@property (nonatomic, strong) NSString *soundFont;

@end
