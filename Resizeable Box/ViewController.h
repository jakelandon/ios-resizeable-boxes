//
//  ViewController.h
//  Resizeable Box
//
//  Created by Jake Landon Schwartz on 7/13/12.
//  Copyright (c) 2012 Jake Landon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResizableBox.h"

@interface ViewController : UIViewController {
    IBOutlet UIButton           *addBoxBtn;
    IBOutlet UIButton           *editBtn;
    IBOutlet UIView             *boxView;
    
    NSMutableArray              *boxes;
    
    BOOL                        _editing;
}

@property (nonatomic, assign) BOOL editing;

- (IBAction)btnPressed:(UIButton *)btn;

@end
