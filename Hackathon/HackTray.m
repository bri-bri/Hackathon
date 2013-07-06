//
//  HackTray.m
//  Hackathon
//
//  Created by Carmine Red on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import "cocos2d.h"

#import "HackTray.h"

#import "HackTile.h"
#import "HackLetter.h"

#import "GameLayer.h"

@implementation HackTray

-(id)init
{
    self = [super init];
    if(self)
    {
        handLetters = [[NSMutableArray alloc] initWithCapacity:7];
    }
    return self;
}

- (void)setupTray:(GameLayer*) gLayer
{
    anchorX = 30;
    anchorY = 120;
    myGLayer = gLayer;
    /*
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
     */
}

- (void)emptyHandLetters
{
    [handLetters removeAllObjects];
}

- (void)emptyHandPowerUps
{
    [handPowerUps removeAllObjects];
}

- (void)fillHandLetters
{
    anchorX = 30;
    anchorY = 120;
    
    while([handLetters count] < __MAX_HANDSIZE)
    {
        //get a random letter
        
        HackTile* toAdd = [[HackTile alloc] init];
        
        //add it
        
        [handLetters addObject:toAdd];
        
        int i = [handLetters count];
        
        NSLog(@"%d", i);
    }
    
    for(int i = 0; i < [handLetters count]; i++)
    {
        HackTile* tempTile = ((HackTile*)[handLetters objectAtIndex:i]);
        HackLetter* tempLetter = tempTile.myHackLetter;
        CCSprite* tempSprite = tempLetter.mySprite;
        
        int xLoc = anchorX + tempSprite.contentSize.width/2;
        int yLoc = anchorY - tempSprite.contentSize.height/2;
        
        xLoc += i * 40;
        
        tempSprite.position = ccp(xLoc, yLoc);
        tempSprite.visible = YES;
        
        [myGLayer addChild:tempSprite];
    }
}

@end
