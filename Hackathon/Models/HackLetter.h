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
    NSInteger* damage;
    NSNumber* speed; // fire rate
    NSNumber* range; // distance that can be fired
    NSMutableDictionary* boosts; //a list of all boosts that have been applied to this letter
    
    CCSprite* mySprite;
}

@property NSString* letter;
@property NSString* type;
@property NSInteger* damage;
@property NSNumber* speed;
@property NSNumber* range;
@property  NSMutableDictionary* boosts;
@property  CCSprite* mySprite;

-(void)randomizeLetter;

@end
