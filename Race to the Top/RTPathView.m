//
//  RTPathView.m
//  Race to the Top
//
//  Created by Dominik Butz on 18.11.13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import "RTPathView.h"
#import "RTMountainPath.h"

@implementation RTPathView

//initialization of the view (self) if the view is created in code. The setup method which we created ourselves sets the background colour of this view to clear, so it is transparent and the MountFuji-Image will be visible.
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

//initialization of the RTPathView (self) from the storyboard (needs a decoder)
- (id)initWithCoder:(NSCoder *)aDecoder

{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        // Initialization code
        
        [self setup];
        
    }
    
    return self;
    
}

- (void)setup

{
    
    self.backgroundColor = [UIColor clearColor];
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    for (UIBezierPath *path in [RTMountainPath mountainPathsForRect:self.bounds ]) {
        [[UIColor blackColor]setStroke];
        
        [path stroke];
        
    }
}


@end
