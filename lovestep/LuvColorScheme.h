//
//  ColorScheme.h
//  lovestep
//
//  Created by Raymond Kennedy on 12/5/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LuvColorScheme : NSObject

+ (instancetype)randomColorScheme;
- (UIColor *)colorForIndex:(NSInteger)index;

@end
