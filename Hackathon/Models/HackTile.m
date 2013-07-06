//
//  HackTile.m
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import "HackTile.h"
#import "HackLetter.h"

@implementation HackTile

@synthesize myHackLetter;

-(id)init
{
    self = [super init];
    if(self)
    {
        scoreMultiplier = [NSNumber numberWithFloat:0.0f];
        myGridCoord = nil;
        myHackLetter = [[HackLetter alloc] init];
    }
    
    return self;
}

@end
