//
//  GridView.m
//  lovestep
//
//  Created by Raymond Kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import "CellView.h"

@interface CellView () <UIGestureRecognizerDelegate> {
    UIView *_highlightView;
}
@end

@implementation CellView

- (id)initWithFrame:(CGRect)frame row:(NSInteger)row col:(NSInteger)col
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.row = row;
        self.col = col;
        
        // Setup the highlight view
        _highlightView = [[UIView alloc] initWithFrame:self.bounds];
        [_highlightView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5f]];
        [self addSubview:_highlightView];
        [_highlightView setHidden:YES];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_cellTapped:)];
        [tapRecognizer setNumberOfTouchesRequired:1];
        [tapRecognizer setDelegate:self];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tapRecognizer];
    
    }
    return self;
}

- (void)_cellTapped:(id)sender {
    if (self.isOn) {
        [self turnOff];
    } else {
        [self turnOn];
    }
    
    if ([self.delegate respondsToSelector:@selector(cellTapped:)]) {
        [self.delegate cellTapped:self];
    }
}

- (void)turnOff {
    [self setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2]];
    [self.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.layer setBorderWidth:2.f];
    [self.layer setCornerRadius:4.f];
    self.isOn = NO;
}

- (void)turnOn {
    [self setBackgroundColor:[UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1]];
    self.isOn = YES;
}

- (void)highlight {
    [_highlightView setHidden:NO];
}

- (void)unhighlight {
    [_highlightView setHidden:YES];
}

@end
