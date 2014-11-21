//
//  GridView.h
//  lovestep
//
//  Created by Raymond Kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CellView;

@protocol CellViewDelegate <NSObject>

- (void)cellTapped:(CellView *)cell;

@end

@interface CellView : UIView

- (id)initWithFrame:(CGRect)frame row:(NSInteger)row col:(NSInteger)col;
- (void)turnOn;
- (void)turnOff;
- (void)highlight;
- (void)unhighlight;

@property (nonatomic) NSInteger row;
@property (nonatomic) NSInteger col;
@property (nonatomic) BOOL isOn;
@property (nonatomic, strong) id <CellViewDelegate>delegate;

@end
