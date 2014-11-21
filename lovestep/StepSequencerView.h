//
//  StepSequencerView.h
//  lovestep
//
//  Created by Raymond Kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CellView;

@protocol StepSequencerDelegate <NSObject>

- (void)cellChanged:(CellView *)cell;

@end

@interface StepSequencerView : UIView

@property (nonatomic, strong) id <StepSequencerDelegate>delegate;

- (void)beatDidChange:(NSInteger)beat;

@end
