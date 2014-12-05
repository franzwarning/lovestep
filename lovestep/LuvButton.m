//
//  LuvButton.m
//  lovestep
//
//  Created by Raymond Kennedy on 12/5/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import "LuvButton.h"

@implementation LuvButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(_buttonHighlight:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(_buttonHighlight:) forControlEvents:UIControlEventTouchDragEnter];

        [self addTarget:self action:@selector(_buttonNormal:) forControlEvents:UIControlEventTouchDragExit];
        [self addTarget:self action:@selector(_buttonNormal:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(_buttonNormal:) forControlEvents:UIControlEventTouchUpOutside];


    }
    return self;
}

- (void)_buttonHighlight:(id)sender {
    [self setBackgroundColor:[UIColor colorWithCGColor:self.layer.borderColor]];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

}

- (void)_buttonNormal:(id)sender {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self setTitleColor:[UIColor colorWithCGColor:self.layer.borderColor] forState:UIControlStateNormal];
}

@end
