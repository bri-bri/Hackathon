//
//  HackProjectile.m
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import "HackProjectile.h"
#import "HackLetter.h"
#import "HackEnemy.h"

@implementation HackProjectile

@synthesize damage,speed,range,type,start,finish,target;

-(id)initWithLetter:(HackLetter*)letter andTarget:(HackEnemy*)enemy {
    self = [super init];
    if(self){
    start = CGPointMake(letter.mySprite.position.x,letter.mySprite.position.y);
    finish = CGPointMake(enemy.mySprite.position.x,enemy.mySprite.position.y);
    
    mySprite =  [CCSprite spriteWithFile:@"sprite_bullet.png"];
    mySprite.position = ccp(start.x,start.y);
    
    damage = [letter calculateDamage];
    speed =  @1;
    range = letter.range;
    
    target = enemy;
    }
    return self;
}

-(BOOL)atFinish
{
    float distToTarget = sqrtf(pow(mySprite.position.x - start.x, 2) + pow(mySprite.position.y - start.y, 2)); //to be used if we ever check range
    
    if(abs(mySprite.position.x-start.x)  > abs(finish.x-start.x) || abs(mySprite.position.y-start.y) > abs(finish.y - start.y)){
        return true;
    }
    
    return false;
}

-(BOOL)removeAndCheckDamage
{
    [mySprite.parent removeChild:self.mySprite];
    [target takeDamage:damage];
    
    return true;
}

@end
