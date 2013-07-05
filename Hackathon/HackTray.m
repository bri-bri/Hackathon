//
//  HackTray.m
//  Hackathon
//
//  Created by Carmine Red on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import "cocos2d.h"

#import "HackTray.h"

#import "GameLayer.h"

@implementation HackTray

-(id)init
{
    self = [super init];
    if(self)
    {
    }
    return self;
}

- (void)setupTray:(GameLayer*) gLayer
{
    anchorX = 30;
    anchorY = 120;
    
    for(int i = 0; i < __MAX_HANDSIZE; i++)
    {
        CCSprite *spriteToAdd = [CCSprite spriteWithFile:@"tile.png"];
        
        int xLoc = anchorX + spriteToAdd.contentSize.width/2;
        int yLoc = anchorY - spriteToAdd.contentSize.height/2;
        
        xLoc += i * 40;
        
        spriteToAdd.position = ccp(xLoc, yLoc);
        [gLayer addChild:spriteToAdd];
    }
    
    CCSprite *spriteToAdd = [CCSprite spriteWithFile:@"tile.png"];
    
    int xLoc = anchorX + spriteToAdd.contentSize.width/2;
    int yLoc = anchorY - spriteToAdd.contentSize.height/2;
    
    spriteToAdd.position = ccp(xLoc, yLoc);
    [gLayer addChild:spriteToAdd];
}

@end
