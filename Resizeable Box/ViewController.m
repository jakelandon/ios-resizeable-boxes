//
//  ViewController.m
//  Resizeable Box
//
//  Created by Jake Landon Schwartz on 7/13/12.
//  Copyright (c) 2012 Jake Landon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end


@implementation ViewController

@synthesize editing = _editing;

- (void)viewDidLoad
{
    [super viewDidLoad];

    boxes = [[NSMutableArray alloc] init];
    
    [self addBox];
        
    self.editing = NO;
}

- (void)dealloc {
    [boxes release]; boxes = nil;
    
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (IBAction)btnPressed:(UIButton *)btn {
    if([btn isEqual:addBoxBtn]) {
        [self addBox];
    }
    if([btn isEqual:editBtn]) {
        self.editing = !_editing;
    }
}

- (void) setEditing:(BOOL)editing {
    _editing = editing;
    if(_editing) {
        [editBtn setTitle:@"Done" forState:UIControlStateNormal];
        addBoxBtn.hidden = NO;
        [self showBoxes];
    } else {
        [editBtn setTitle:@"Edit" forState:UIControlStateNormal];
        addBoxBtn.hidden = YES;
        [self hideBoxes];
        [self getBoxPositions];
    }
}

- (void) showBoxes {
    for(ResizableBox *box in boxes) {
        [box show];
    }    
}

- (void) hideBoxes {
    for(ResizableBox *box in boxes) {
        [box hide];
    }
}

- (void) getBoxPositions {
    for(ResizableBox *box in boxes) {
        CGPoint topLeft = CGPointMake(box.frame.origin.x, box.frame.origin.y);
        CGPoint bottomRight = CGPointMake(topLeft.x + box.frame.size.width, topLeft.y + box.frame.size.height);
        NSLog(@"box: %.2f, %.2f >> %.2f, %.2f", topLeft.x, topLeft.y, bottomRight.x, bottomRight.y);
    }
}

- (void) addBox {
    
    ResizableBox *box = [[ResizableBox alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    box.center = boxView.center;
    [boxView addSubview:box];
    
    [boxes addObject:box];

    [box release];
}
- (void) removeBox:(ResizableBox *)box {
    [boxes removeObjectIdenticalTo:box];
}

@end
