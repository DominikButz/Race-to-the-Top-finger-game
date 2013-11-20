//
//  RTMountainPath.h
//  Race to the Top
//
//  Created by Dominik Butz on 18.11.13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTMountainPath : NSObject

+ (NSArray *)mountainPathsForRect:(CGRect)rect;

+(UIBezierPath*)tapTargetForPath: (UIBezierPath*)path;


@end
