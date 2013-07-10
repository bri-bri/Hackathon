//
//  HackEnemy.m
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import "HackEnemy.h"

@implementation HackEnemy

@synthesize mySprite;
@synthesize pathInt;
@synthesize hp;

-(void)takeDamage:(NSNumber *)damage
{
    float temp = hp.floatValue - damage.floatValue;
    hp = [NSNumber numberWithFloat:temp];
}
@end
