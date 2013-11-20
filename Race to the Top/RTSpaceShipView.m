//
//  RTSpaceShipView.m
//  Race to the Top
//
//  Created by Dominik Butz on 18.11.13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import "RTSpaceShipView.h"

@implementation RTSpaceShipView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    // create path, set width, move to start point and then connect lines to other points.
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    bezierPath.lineWidth = 2.0;
    
    
    [bezierPath moveToPoint:CGPointMake(1/6.0 * self.bounds.size.width, 1/3.0 * self.bounds.size.height)];
    
    [bezierPath addLineToPoint:CGPointMake(1/6.0 * self.bounds.size.width, 2/3.0 * self.bounds.size.height)];
    
    [bezierPath addLineToPoint:CGPointMake(5/6.0 * self.bounds.size.width, 2/3.0 * self.bounds.size.height)];
    
    [bezierPath addLineToPoint:CGPointMake(2/3.0 * self.bounds.size.width, 1/2.0 * self.bounds.size.height)];
    
    [bezierPath addLineToPoint:CGPointMake(1/3.0 * self.bounds.size.width, 1/2.0 * self.bounds.size.height)];
    
    //finally close the path by connecting the last point to the first:
    
    [bezierPath closePath];
    
    // nothing to see on the screen yet... need to call stroke method:
    [bezierPath stroke];
    
    //another bezierPath to draw a cockpit window. initialize with rectangle  this time:
    UIBezierPath *cockpitWindowPath = [UIBezierPath bezierPathWithRect:CGRectMake(2/3.0 * self.bounds.size.width, 1/2.0 * self.bounds.size.height, 1/6.0 * self.bounds.size.width, 1/ 12.0 * self.bounds.size.height)];
    
    //set filling color
    [[UIColor blueColor] setFill];
    // fill the cockpit:
    [cockpitWindowPath fill];
}


@end
