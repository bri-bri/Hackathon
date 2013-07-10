//
//  HackLetter.h
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import "cocos2d.h"

#import <Foundation/Foundation.h>

@interface HackLetter : NSObject {
    NSString* letter;
    NSString* type; //type of attack
    NSNumber* damage;
    NSNumber* speed; // fire rate
    NSNumber* range; // distance that can be fired
    NSMutableDictionary* boosts; //a list of all boosts that have been applied to this letter
    
    CCSprite* mySprite;
    ccTime shotTimer;
}

@property NSString* letter;
@property NSString* type;
@property NSNumber* damage;
@property NSNumber* speed;
@property NSNumber* range;
@property  NSMutableDictionary* boosts;
@property  CCSprite* mySprite;
@property ccTime shotTimer;

-(void)randomizeLetter;

-(id)initWithLetter:(NSString*)ltr;

-(NSNumber*)calculateDamage;

@end
