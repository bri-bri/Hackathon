//
//  HackProjectile.h
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import "cocos2d.h"

#import <Foundation/Foundation.h>
#import "HackLetter.h"
#import "HackEnemy.h"

@interface HackProjectile : NSObject {
    NSNumber* damage;
    NSNumber* speed;
    NSNumber* range; // distance projectile can go
    NSNumber* type;
    CGPoint start;
    CGPoint finish;
    CCSprite* mySprite;
    HackEnemy* target;
    
}
@property NSNumber* damage;
@property NSNumber* speed;
@property NSNumber* range;
@property NSNumber* type;
@property CGPoint start,finish;
@property CCSprite* mySprite;
@property HackEnemy* target;

-(id)initWithLetter:(HackLetter*)letter andTarget:(HackEnemy*)enemy;

-(BOOL)atFinish;

-(BOOL)removeAndCheckDamage;

@end
