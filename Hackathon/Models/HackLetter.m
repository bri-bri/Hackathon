//
//  HackLetter.m
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import "HackLetter.h"
#import "HackSettings.h"

#include <stdlib.h>

@implementation HackLetter

@synthesize mySprite;
@synthesize letter;
@synthesize shotTimer;
@synthesize speed,range,damage,type;

-(id)init
{
    self = [super init];
    if(self)
    {
        [self randomizeLetter];
        [self setPropertiesBasedOnLetter];
        boosts = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(id)initWithLetter:(NSString*)ltr
{
    self = [super init];
    if(self)
    {
        letter = ltr;
        [self setPropertiesBasedOnLetter];
        boosts = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)randomizeLetter
{
    int r = arc4random() % 26;
    
    NSString* letters = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    letter = [NSString stringWithString:([[letters substringFromIndex:r] substringToIndex:1])];
    
    //NSLog(@"%@", letter);
}

-(void)setPropertiesBasedOnLetter
{
    NSDictionary *letters = [HackSettings sharedSettings].letters;
    
    type = @"";
    int damageInt = (int)1 + arc4random() % 2;
    damage = [NSNumber numberWithInt:damageInt];
    int speedInt = (int)1 + arc4random() % 3;
    speed = [NSNumber numberWithFloat:speedInt];
    range = [NSNumber numberWithInt:1];
    
    NSString* tempStr = [NSString stringWithFormat:@"%@.png", letter];

    mySprite = [CCSprite spriteWithFile:tempStr];
    
    mySprite.visible = NO;
    
    return;
}

-(NSNumber*)calculateDamage
{
    return damage;
}

@end
