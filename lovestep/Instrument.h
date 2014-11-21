//
//  Instrument.h
//  lovestep
//
//  Created by Raymond Kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Instrument : NSObject

- (id)initWithName:(NSString *)name soundFont:(NSString *)soundFont;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *soundFont;

@end
