//
//  HackEnemy.h
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"

@interface HackEnemy : NSObject {
    NSString* type;
    NSNumber* hp;
    NSNumber* speed;
    
    CCSprite* mySprite;
    int pathInt;
}

@property NSString* type;
@property NSNumber* hp;
@property NSNumber* speed;
@property  CCSprite* mySprite;
@property int pathInt;

-(void)takeDamage:(NSNumber*)damage;

@end
