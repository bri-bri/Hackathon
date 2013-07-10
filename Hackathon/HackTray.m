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
#import "HackPowerUp.h"

#import "GameLayer.h"

@implementation HackTray

@synthesize handLetters;
@synthesize handLetterSprites;

-(id)init
{
    self = [super init];
    if(self)
    {
        handLetters = [[NSMutableArray alloc] initWithCapacity:7];
        handLetterSprites = [[NSMutableArray alloc] initWithCapacity:7];
        handPowerUps = [[NSMutableArray alloc] initWithCapacity:7];
        handPowerUpSprites = [[NSMutableArray alloc] initWithCapacity:7];
    }
    return self;
}

- (void)setupTray:(GameLayer*) gLayer
{
    anchorX = 30;
    anchorY = 120;
    myGLayer = gLayer;
    
    [self fillHandLetters];
    [self fillHandPowerUps];
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
    for(int i = [handLetterSprites count] - 1; i >= 0; i--){
        CCSprite *tempSprite = [handLetterSprites objectAtIndex:i];
        [tempSprite.parent removeChild:tempSprite];
        [handLetterSprites removeObjectAtIndex:i];
    }
}

- (void)emptyHandPowerUps
{
    [handPowerUps removeAllObjects];
}

- (void)showHandLetters
{

    for(int i =0; i < [handPowerUpSprites count]; i++){
        CCSprite *tempSprite = [handPowerUpSprites objectAtIndex:i];
        tempSprite.visible = NO;
        [myGLayer removeChild:tempSprite];
    }
    for(int i =0; i < [handLetterSprites count]; i++){
        CCSprite *tempSprite = [handLetterSprites objectAtIndex:i];
        tempSprite.visible = YES;
        if(tempSprite.parent == nil){
            [myGLayer addChild:tempSprite];
        }
    }
    
}

- (void)showHandPowerUps
{
    
    for(int i =0; i < [handLetterSprites count]; i++){
        CCSprite *tempSprite = [handLetterSprites objectAtIndex:i];
        tempSprite.visible = NO;
        [myGLayer removeChild:tempSprite];
    }
    for(int i =0; i < [handPowerUpSprites count]; i++){
        CCSprite *tempSprite = [handPowerUpSprites objectAtIndex:i];
        tempSprite.visible = YES;
        if(tempSprite.parent == nil){
            [myGLayer addChild:tempSprite];
        }
    }
}

- (void)fillHandLetters
{
    anchorX = 30;
    anchorY = 120;
    
    while([handLetters count] < __MAX_HANDSIZE)
    {
        //get a random letter
        
        HackLetter* toAdd = [[HackLetter alloc] init];
        
        //add it
        
        [handLetters addObject:toAdd];
        
        int i = [handLetters count];
        
        NSLog(@"%d", i);
    }
    
    for(int i = 0; i < [handLetters count]; i++)
    {
        HackLetter* tempLetter = [handLetters objectAtIndex:i];
        CCSprite* tempSprite = tempLetter.mySprite;
        
        int xLoc = anchorX + tempSprite.contentSize.width/2;
        int yLoc = anchorY - tempSprite.contentSize.height/2;
        
        xLoc += i * 40;
        
        [handLetterSprites addObject:tempSprite];
        
        tempSprite.position = ccp(xLoc, yLoc);
        /*
        tempSprite.visible = YES;
        if(tempSprite.parent == nil){
            [myGLayer addChild:tempSprite];
        }
         */
    }
}

- (void)fillHandPowerUps
{
    anchorX = 30;
    anchorY = 120;
    
    NSMutableDictionary* items = [[NSUserDefaults standardUserDefaults] objectForKey:@"items"];
    
    int i = 0;
    for(id key in items){
        if(i > __MAX_HANDSIZE){
            break;
        }
        NSDictionary *theItem = [items objectForKey:key];
        if(theItem[@"amount"]>0){
            HackPowerUp* toAdd = [[HackPowerUp alloc] initWithItem:theItem[@"item"]];
            
            [handPowerUps addObject:toAdd];
            
            i++;
        }
    }
    
    i = [handPowerUps count];
    
    for(int i = 0; i < [handPowerUps count]; i++)
    {
        HackPowerUp* tempPowerUp = [handPowerUps objectAtIndex:i];
        CCSprite* tempSprite = tempPowerUp.mySprite;
        
        int xLoc = anchorX + tempSprite.contentSize.width/2;
        int yLoc = anchorY - tempSprite.contentSize.height/2;
        
        xLoc += i * 40;
        NSLog(@"url is: %@",tempPowerUp.url);
        [handPowerUpSprites addObject:tempSprite];
        
        tempSprite.position = ccp(xLoc, yLoc);
        /*
        tempSprite.visible = YES;
        
        if(tempSprite.parent == nil){
            [myGLayer addChild:tempSprite];
        }
         */
    }
}

@end
