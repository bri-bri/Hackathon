//
//  GameLogic.m
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import "cocos2d.h"

#import "GameLogic.h"
#import "HackBoard.h"
#import "HackEnemy.h"
#import "HackTile.h"
#import "HackTileCoord.h"
#import "HackLetter.h"
#import "HackProjectile.h"
#import "HackSettings.h"

#import "GameLayer.h"

@implementation GameLogic

@synthesize myLayer;
@synthesize boardPath;
@synthesize gameBullets;
@synthesize gameLetters;

-(id)init {
    if( (self=[super init]) ) {
        
        gameBoard = nil;
        gameState = PREPARATION;
        gameEnemies = [[NSMutableArray alloc] initWithCapacity:10];
        gameBullets = [[NSMutableArray alloc] init];
        gameLetters = [[NSMutableArray alloc] init];
        HackLetter *testLetter = [[HackLetter alloc] init];
        testLetter.mySprite.visible = YES;
        
        int xLoc = [_gameBoard getXLocFromGridX:0 gridWidth:30];
        int yLoc = [_gameBoard getYLocFromGridY:0 gridHeight:30];
        
        testLetter.mySprite.position = ccp(xLoc,yLoc);
        [gameLetters addObject:testLetter];
        
        [myLayer addChild:testLetter.mySprite];
        enemiesToSpawn = 0;
        spawnInterval = 1.5f;
        spawnTimer = 0.0f;
    }
    return self;
}

-(void)startGame {
    
}
-(void)pauseGame {
    
}
-(void)exitGame {
    
}
-(void)finishGame {
    
}

-(bool)attemptTransition
{
    if(gameState == PLAYING)
    {
        return false;
    }
    //test if there's a valid path
    
    boardPath = [_gameBoard getPath:_gameBoard.tiles sRow:0 sCol:0 eRow:9 eCol:9];
    
    //test if the word placed was valid
    
    //if so, transition
    
    //update the strength of the towers
    
    //prepare a spawn of enemies
    
    enemiesToSpawn = 5;
    
    gameState = PLAYING;
    
    return true;
}

-(BOOL)verifyWord:(NSString*)word
{
    if([[HackSettings sharedSettings].dictionary containsObject:word]){
        return true;
    }
        return false;
}

-(void)gameLoop:(ccTime)dT
{
    //NSLog(@"%f", dT);
    
    //NSLog(@"%d", j);
    
    for(int i = [gameEnemies count] - 1; i >= 0; i--)
    {
        HackEnemy* nme = [gameEnemies objectAtIndex:i];
        float distToTarget = 0.0f;
        float speed = 24.0f;
        float currentX = nme.mySprite.position.x;
        float currentY = nme.mySprite.position.y;
        HackTileCoord* destTile = (HackTileCoord*)[boardPath objectAtIndex:nme.pathInt];
        float targetX = [_gameBoard getXLocFromGridX:destTile.col gridWidth:30];
        float targetY = [_gameBoard getYLocFromGridY:destTile.row gridHeight:30];
        
        targetX += 15;
        targetY += 15;
        
        distToTarget = sqrtf(pow(targetX - currentX, 2) + pow(targetY - currentY, 2));
        
        if(distToTarget < speed * dT)
        {
            //move to target, increment pathInt
            nme.mySprite.position = ccp(targetX, targetY);
            nme.pathInt += 1;
            if(nme.pathInt >= [boardPath count])
            {
                HackEnemy* toRemove = nme;
                [gameEnemies removeObjectAtIndex:i];
                [myLayer removeChild:toRemove.mySprite cleanup:true];
            }
        }
        else
        {
            //move closer to target
            float moveX = ((targetX - currentX)/distToTarget) * speed * dT;
            float moveY = ((targetY - currentY)/distToTarget) * speed * dT;
            float newX = nme.mySprite.position.x + moveX;
            float newY = nme.mySprite.position.y + moveY;
            nme.mySprite.position = ccp(newX, newY);
        }
        
    }
    
    //move bullets
    
    for(int i = [gameBullets count]-1; i >= 0; i--)
    {
        HackProjectile* blt = [gameBullets objectAtIndex:i];
        float distToTarget = 0.0f;
        float speed = blt.speed.floatValue * 10.0f;
        float currentX = blt.mySprite.position.x;
        float currentY = blt.mySprite.position.y;
        float targetX = blt.finish.x;
        float targetY = blt.finish.y;
        if(currentX < targetX){
            targetX = currentX + speed * dT;
        } else {
            targetX = currentX - speed * dT;
        }
        if(currentY < targetY){
            targetY = currentY + speed * dT;
        } else {
            targetY = currentY - speed * dT;
        }
        
        blt.mySprite.position = ccp(targetX,targetY);
        
        
        if([blt atFinish]){
            [blt removeAndCheckDamage];
            [gameBullets removeObjectAtIndex:i];
        }
    }
    
    //create bullets
    
    /*
    for(int i = [gameLetters count]; i >= 0; i--){
       HackLetter *temp = [gameLetters objectAtIndex:i];
    
        if(tempLetter.shotTimer > 1000){
            HackProjectile *newblt = [[HackProjectile alloc] initWithLetter:tempLetter andTarget:(HackEnemy*)[gameEnemies objectAtIndex:0]];
            [gameBullets addObject:newblt];
            [myLayer addChild:newblt.mySprite];
           tempLetter.shotTimer = 0;
       } else {
           tempLetter.shotTimer += dT;
       }
    }
     */
    
    
    //detect for enemy deaths
    
    //spawn a new enemy?
    
    if(enemiesToSpawn > 0)
    {
        if(spawnTimer <= 0.0f)
        {
            spawnTimer = spawnInterval;
            enemiesToSpawn--;
            [self spawnEnemy];
        }
        else
        {
            spawnTimer -= dT;
        }
    }
    
    //detect if there's zero enemies left, change state
    
    if([gameEnemies count] == 0 && enemiesToSpawn == 0)
    {
        gameState = PREPARATION;
        spawnTimer = 0.0f;
    }
}

-(void)spawnEnemy
{
    //spawn enemy
    HackEnemy* toAdd = [HackEnemy alloc];
    
    //position enemy sprite at start
    toAdd.mySprite = [CCSprite spriteWithFile:@"Sprites.png"];
    
    int xLoc = [_gameBoard getXLocFromGridX:0 gridWidth:30];
    int yLoc = [_gameBoard getYLocFromGridY:0 gridHeight:30];
    
    xLoc += toAdd.mySprite.contentSize.width/2;
    yLoc += toAdd.mySprite.contentSize.height/2;
    
    toAdd.mySprite.position = ccp(xLoc, yLoc);
    
    [myLayer addChild:toAdd.mySprite];
    
    //give enemy first step in pathInt (index into path to which they're walking)
    toAdd.pathInt = 1;
    
    [gameEnemies addObject:toAdd];
}

@end
