//
//  LoopVisualizerView.h
//  lovestep
//
//  Created by Raymond Kennedy on 12/4/14.
//  Copyright (c) 2014 Raymond kennedy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeatBrain.h"

@interface LoopVisualizerView : UIView <BeatBrainDelegate>

- (void)refreshLoops;
- (UIColor *)getColorForLoop:(Loop *)loop;

@end
