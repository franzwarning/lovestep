//
//  StepSequencerView.m
//  lovestep
//
//  Created by Raymond Kennedy on 11/20/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import "StepSequencerView.h"
#import "CellView.h"

static const CGFloat kNumRows = 12;
static const CGFloat kNumCols = 16;
static const CGFloat kCellMargin = 5;

@interface StepSequencerView () <CellViewDelegate> {
    NSMutableArray *_cells;
}

@end

@implementation StepSequencerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _cells = [[NSMutableArray alloc] init];
        [self _setupGrid];
    }
    return self;
}

- (void)_setupGrid {
    
    CGFloat cellWidth = (self.frame.size.width - ((kNumCols + 1) * kCellMargin)) / kNumCols;
    CGFloat cellHeight = (self.frame.size.height - ((kNumRows + 1) * kCellMargin)) / kNumRows;
    
    CGFloat currentY = kCellMargin;
    CGFloat currentX = kCellMargin;
    
    for (int i = 0; i < kNumCols; i++) {
        
        currentY = kCellMargin;
        
        NSMutableArray *colCells = [[NSMutableArray alloc] init];
        for (int j = 0; j < kNumRows; j++) {
            CellView *cellView = [[CellView alloc] initWithFrame:CGRectMake(currentX, currentY, cellWidth, cellHeight) row:j col:i];
            [cellView turnOff];
            [cellView setDelegate:self];
            [self addSubview:cellView];
            colCells[j] = cellView;
            currentY += (cellHeight + kCellMargin);
        }
        _cells[i] = colCells;
        currentX += (cellWidth + kCellMargin);
        
    }
}

- (void)cellTapped:(CellView *)cell {
    if ([self.delegate respondsToSelector:@selector(cellChanged:)]) {
        [self.delegate cellChanged:cell];
    }
}

- (void)beatDidChange:(NSInteger)beat {
    
    for (int i = 0; i < kNumCols; i++) {
        if (beat == i) {
            for (int j = 0; j < kNumRows; j++) {
                [(CellView *)_cells[i][j] highlight];
            }
        } else {
            for (int j = 0; j < kNumRows; j++) {
                [(CellView *)_cells[i][j] unhighlight];
            }
        }
    }
}



@end
