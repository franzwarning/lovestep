//
//  RingView.h
//  lovestep
//
//  Created by Raymond Kennedy on 12/4/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Loop;

@interface RingView : UIView

@property (nonatomic, strong) Loop *loop;

- (id)initWithFrame:(CGRect)frame outerRadius:(CGFloat)outerRadius innerRadius:(CGFloat)innerRadius loop:(Loop *)loop;

@end
