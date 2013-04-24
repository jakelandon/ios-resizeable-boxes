//
//  ResizableBox.m
//  Resizeable Box
//
//  Created by Jake Landon Schwartz on 7/13/12.
//  Copyright (c) 2012 Jake Landon. All rights reserved.
//

#import "ResizableBox.h"

@implementation ResizableBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.multipleTouchEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:.5 green:.5 blue:.5 alpha:.5];
        
        self.layer.borderWidth = 3.0;
        self.layer.borderColor = [UIColor darkGrayColor].CGColor;
    }
    return self;
}

#define kEdgeBuffer 25.0f
#define kMinBoxWidth 60.0f
#define kMinBoxHeight 60.0f

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    _startTL = [touch locationInView:self];
    _startParentTL = [touch locationInView:self.superview];
    _startFrame = self.frame;
    _startCenter= self.center;
    
    float boxWidth = self.frame.size.width;
    float boxHeight = self.frame.size.height;
    
    // top
    if(_startTL.x > kEdgeBuffer && 
       _startTL.x < boxWidth - kEdgeBuffer &&
       _startTL.y < kEdgeBuffer) {
        _tl = TouchLocationTop;
    }
    // top left
    else if(_startTL.x < kEdgeBuffer && 
            _startTL.y < kEdgeBuffer) {
        _tl = TouchLocationTopLeft;
    }
    // left
    else if(_startTL.x < kEdgeBuffer && 
            _startTL.y > kEdgeBuffer &&
            _startTL.y < boxHeight - kEdgeBuffer) {
        _tl = TouchLocationLeft;
    }
    // bottom left
    else if(_startTL.x < kEdgeBuffer && 
            _startTL.y > boxHeight - kEdgeBuffer) {
        _tl = TouchLocationBottomLeft;
    }
    // bottom 
    else if(_startTL.x > kEdgeBuffer && 
            _startTL.x < boxWidth - kEdgeBuffer &&
            _startTL.y > boxHeight - kEdgeBuffer) {
        _tl = TouchLocationBottom;
    }
    // bottom right
    else if(_startTL.x > boxWidth - kEdgeBuffer &&
            _startTL.y > boxHeight - kEdgeBuffer) {
        _tl = TouchLocationBottomRight;
    }
    // right 
    else if(_startTL.x > boxWidth - kEdgeBuffer &&
            _startTL.y > kEdgeBuffer &&
            _startTL.y < boxHeight - kEdgeBuffer) {
        _tl = TouchLocationRight;
    }
    // top right 
    else if(_startTL.x > boxWidth - kEdgeBuffer &&
            _startTL.y < kEdgeBuffer) {
        _tl = TouchLocationTopRight;
    }
    // center
    else {
        _tl = TouchLocationCenter;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    // set current touch location
    _currentTL = [touch locationInView:self];
    _currentParentTL = [touch locationInView:self.superview];

    
    float boxWidth = self.frame.size.width;
    float boxHeight = self.frame.size.height;
    float boxCenterX = boxWidth / 2;
    float boxCenterY = boxHeight / 2;
    float boxParentX = self.superview.frame.origin.x;
    float boxParentY = self.superview.frame.origin.y;
    float boxParentWidth = self.superview.frame.size.width;
    float boxParentHeight = self.superview.frame.size.height;
    
    CGRect boxFrame = self.frame;
    CGPoint boxCenter = self.center;
    
    float newBoxX = self.frame.origin.x;
    float newBoxY = self.frame.origin.y;
    
    
    // center
    
    if(_tl == TouchLocationCenter) {
        
        newBoxX = _currentParentTL.x - _startTL.x;
        newBoxY = _currentParentTL.y - _startTL.y;
        boxCenter.x = _currentParentTL.x + (boxCenterX - _startTL.x);
        boxCenter.y = _currentParentTL.y + (boxCenterY - _startTL.y);
        
        if(newBoxX < 0) {
            newBoxX = 0;
        }
        if(newBoxX > boxParentWidth - boxWidth) {
            newBoxX = boxParentWidth - boxWidth;
        }
        if(newBoxY < 0) {
            newBoxY = 0;
        }
        if(newBoxY > boxParentHeight - boxHeight) {
            newBoxY = boxParentHeight - boxHeight;
        }
        
        boxFrame.origin.x = newBoxX;
        boxFrame.origin.y = newBoxY;
    } 
    
    else {
        
        float distX = _startParentTL.x - _currentParentTL.x;
        float distY = _startParentTL.y - _currentParentTL.y;
        
        float newBoxWidth = boxWidth; 
        float newBoxHeight = boxHeight;

        
        // top
        if(_tl == TouchLocationTop) {
            newBoxHeight = _startFrame.size.height + distY;
            newBoxY = _startFrame.origin.y - distY;
        }
        // top left
        else if(_tl == TouchLocationTopLeft) {
            newBoxWidth = _startFrame.size.width + distX;
            newBoxHeight = _startFrame.size.height + distY;
            newBoxX = _startFrame.origin.x - distX;
            newBoxY = _startFrame.origin.y - distY;
        }
        // left
        else if(_tl == TouchLocationLeft) {
            newBoxWidth = _startFrame.size.width + distX;
            newBoxX = _startFrame.origin.x - distX;
        }
        // bottom left
        else if(_tl == TouchLocationBottomLeft) {
            newBoxWidth = _startFrame.size.width + distX;
            newBoxHeight = _startFrame.size.height - distY;
            newBoxX = _startFrame.origin.x - distX;
        }
        // bottom
        else if(_tl == TouchLocationBottom) {
            newBoxHeight = _startFrame.size.height - distY;
        }
        // bottom right
        else if(_tl == TouchLocationBottomRight) {
            newBoxWidth = _startFrame.size.width - distX;
            newBoxHeight = _startFrame.size.height - distY;
        }
        // right 
        else if(_tl == TouchLocationRight) {
            newBoxWidth = _startFrame.size.width - distX;
        }
        // top right 
        else if(_tl == TouchLocationTopRight) {
            newBoxWidth = _startFrame.size.width - distX;
            newBoxHeight = _startFrame.size.height + distY;
            newBoxY = _startFrame.origin.y - distY;
        }
        
        if(newBoxWidth < kMinBoxWidth) {
            newBoxWidth = kMinBoxWidth;
            if(_currentTL.x < _startTL.x) {
                newBoxX = _startFrame.origin.x;
            } else {
                newBoxX = _startFrame.origin.x + _startFrame.size.width - kMinBoxWidth;
            }
        }
        
        if(newBoxHeight < kMinBoxHeight) {
            newBoxHeight = kMinBoxHeight; 
            if(_currentTL.y < _startTL.y) {
                newBoxY = _startFrame.origin.y;
            } else {
                newBoxY = _startFrame.origin.y + _startFrame.size.height - kMinBoxHeight;
            }
        }
        
        if(newBoxX < 0) {
            newBoxX = 0;
            newBoxWidth = _startFrame.origin.x + _startFrame.size.width;
        }
        if(newBoxY < 0) {
            newBoxY = 0;
            newBoxHeight = _startFrame.origin.y + _startFrame.size.height;
        }
        
        if(newBoxWidth + newBoxX > boxParentWidth) {
            newBoxWidth = boxParentWidth - newBoxX;
        }
        if(newBoxHeight + newBoxY > boxParentHeight) {
            newBoxHeight = boxParentHeight - newBoxY;
        }
        
        if(newBoxWidth >= boxParentWidth) {
            newBoxWidth = boxParentWidth;
            newBoxX = 0;
        }
        
        if(newBoxHeight >= boxParentHeight) {
            newBoxHeight = boxParentHeight;
            newBoxY = 0;
        }
        
        
        boxFrame.origin.x = newBoxX;
        boxFrame.origin.y = newBoxY;
        boxFrame.size.width = newBoxWidth;
        boxFrame.size.height = newBoxHeight;
    }
    
    
    self.frame = boxFrame;
    //self.center = boxCenter;
}


- (void) show {
    self.hidden = NO;
    [UIView beginAnimations:@"showBox" context:nil];
    [UIView setAnimationDuration:0.3];
    self.alpha = 1;
    [UIView commitAnimations];
}
- (void) hide {
    [UIView beginAnimations:@"hideBox" context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(hideComplete)];
    self.alpha = 0;
    [UIView commitAnimations];
}
- (void) hideComplete {
    self.hidden = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
