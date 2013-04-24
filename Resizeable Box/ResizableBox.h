//
//  ResizableBox.h
//  Resizeable Box
//
//  Created by Jake Landon Schwartz on 7/13/12.
//  Copyright (c) 2012 Jake Landon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    TouchLocationTopLeft,
    TouchLocationLeft,
    TouchLocationBottomLeft,
    TouchLocationBottom,
    TouchLocationBottomRight,
    TouchLocationRight,
    TouchLocationTopRight,
    TouchLocationTop,
    TouchLocationCenter
} TouchLocation;

@interface ResizableBox : UIView {
    CGPoint             _startTL;
    CGPoint             _currentTL;
    CGPoint             _startParentTL;
    CGPoint             _currentParentTL;
    CGRect              _startFrame;
    CGPoint             _startCenter;
    TouchLocation       _tl;
}


- (void) show;
- (void) hide;

@end
