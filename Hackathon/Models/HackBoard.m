//
//  HackBoard.m
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import "cocos2d.h"

#import "HackBoard.h"
#import "HackTile.h"

#import "HackTileCoord.h"

#import "GameLayer.h"



@implementation HackBoard

- (id)init
{
    self = [super init];
    if(self)
    {
        //[self setupBoard];
    }
    
    return self;
}

- (void)setupBoard:(GameLayer*) gLayer
{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    int boardXLoc = 15;
    int boardYLoc = 400;
    
    CCSprite *spriteToAdd = [CCSprite spriteWithFile:@"tilebg.png"];
    
    int xLoc = 10 + spriteToAdd.contentSize.width/2;
    int yLoc = 460 - spriteToAdd.contentSize.height/2;
    
    spriteToAdd.position = ccp(xLoc, yLoc);
    [gLayer addChild:spriteToAdd];
    
    tiles = [[NSMutableArray alloc] initWithCapacity:10];
    
    for(int i = 0; i < 10; i++)
    {
        [tiles addObject: [[NSMutableArray alloc] initWithCapacity:10]];
        for(int j = 0; j < 8; j++)
        {
            //HackTile* tileToAdd = [[HackTile alloc] init];
            HackTileCoord* toAdd = [[HackTileCoord alloc] init];
            toAdd.row = i;
            toAdd.col = j;
            toAdd.value = 0;
            //tileToAdd.myGridCoord = toAdd;
            [[tiles objectAtIndex:i] addObject:toAdd];
            /*
            CCSprite *spriteToAdd = [CCSprite spriteWithFile:@"tilebackground.png"];
            
            int xLoc = 15 + spriteToAdd.contentSize.width/2;
            int yLoc = 400 + spriteToAdd.contentSize.height/2;
            
            xLoc += (i * spriteToAdd.contentSize.width);
            yLoc -= (j * spriteToAdd.contentSize.height);
            
            spriteToAdd.position = ccp(xLoc, yLoc);
            [gLayer addChild:spriteToAdd];
             */
        }
    }
}

- (NSArray*)getPath:(NSArray*)board sRow:(int)sR sCol:(int)sC eRow:(int)eR eCol:(int)eC
{
    NSMutableArray* myQueue = [[NSMutableArray alloc] initWithCapacity:12];
    
    int boardRows = 10;
    int boardCols = 10;
    
    int currVal = 1;
    ((HackTileCoord*)[[board objectAtIndex:eR]objectAtIndex:eC]).value = currVal;
    
    int max = 20;
    int step = 0;
    
    while(step < max)
    {
        step++;
        
        bool found = false;
        
        for(int i = 0; i < 8; i++)
        {
            for(int j = 0; j < 8; j++)
            {
                if(((HackTileCoord*)[[board objectAtIndex:i]objectAtIndex:j]).value == currVal)
                {
                    if((i-1)>=0)
                    {
                        if(((HackTileCoord*)[[board objectAtIndex:i-1]objectAtIndex:j]).row == sR
                           && ((HackTileCoord*)[[board objectAtIndex:i-1]objectAtIndex:j]).col == sC)
                        {
                            //found it!
                            found = true;
                            ((HackTileCoord*)[[board objectAtIndex:i-1]objectAtIndex:j]).value = currVal+1;
                            j = boardRows;
                            i = boardCols;
                        }
                        else
                        {
                            if(((HackTileCoord*)[[board objectAtIndex:i-1]objectAtIndex:j]).value == 0
                               && ((HackTileCoord*)[[board objectAtIndex:i-1]objectAtIndex:j]).status == 0)
                            {
                                ((HackTileCoord*)[[board objectAtIndex:i-1]objectAtIndex:j]).value = currVal+1;
                            }
                        }
                    }
                    if(found != true && (i+1)<boardRows)
                    {
                        if(((HackTileCoord*)[[board objectAtIndex:i+1]objectAtIndex:j]).row == sR
                           && ((HackTileCoord*)[[board objectAtIndex:i+1]objectAtIndex:j]).col == sC)
                        {
                            //found it!
                            found = true;
                            ((HackTileCoord*)[[board objectAtIndex:i+1]objectAtIndex:j]).value = currVal+1;
                            j = boardRows;
                            i = boardCols;
                        }
                        else
                        {
                            if(((HackTileCoord*)[[board objectAtIndex:i+1]objectAtIndex:j]).value == 0
                               && ((HackTileCoord*)[[board objectAtIndex:i+1]objectAtIndex:j]).status == 0)
                            {
                                ((HackTileCoord*)[[board objectAtIndex:i+1]objectAtIndex:j]).value = currVal+1;
                            }
                        }
                    }
                    if(found != true && (j-1)>=0)
                    {
                        if(((HackTileCoord*)[[board objectAtIndex:i]objectAtIndex:j-1]).row == sR
                           && ((HackTileCoord*)[[board objectAtIndex:i]objectAtIndex:j-1]).col == sC)
                        {
                            //found it!
                            found = true;
                            ((HackTileCoord*)[[board objectAtIndex:i]objectAtIndex:j-1]).value = currVal+1;
                            j = boardRows;
                            i = boardCols;
                        }
                        else
                        {
                            if(((HackTileCoord*)[[board objectAtIndex:i]objectAtIndex:j-1]).value == 0
                               && ((HackTileCoord*)[[board objectAtIndex:i]objectAtIndex:j-1]).status == 0)
                            {
                                ((HackTileCoord*)[[board objectAtIndex:i]objectAtIndex:j-1]).value = currVal+1;
                            }
                        }
                    }
                    if(found != true && (j+1)<boardCols)
                    {
                        if(((HackTileCoord*)[[board objectAtIndex:i]objectAtIndex:j+1]).row == sR
                           && ((HackTileCoord*)[[board objectAtIndex:i]objectAtIndex:j+1]).col == sC)
                        {
                            //found it!
                            found = true;
                            ((HackTileCoord*)[[board objectAtIndex:i]objectAtIndex:j+1]).value = currVal+1;
                            j = boardRows;
                            i = boardCols;
                        }
                        else
                        {
                            if(((HackTileCoord*)[[board objectAtIndex:i]objectAtIndex:j+1]).value == 0
                               && ((HackTileCoord*)[[board objectAtIndex:i]objectAtIndex:j+1]).status == 0)
                            {
                                ((HackTileCoord*)[[board objectAtIndex:i]objectAtIndex:j+1]).value = currVal+1;
                            }
                        }
                    }
                }
            }
        }
        if(found == true)
        {
            step = max;
        }
        
        currVal++;
    }
    
    NSMutableArray* toReturn = [[NSMutableArray alloc] initWithCapacity:12];
    
    HackTileCoord* toAdd = [HackTileCoord alloc];
    
    toAdd.row = sR;
    toAdd.col = sC;
    toAdd.value = ((HackTileCoord*)[[board objectAtIndex:sR]objectAtIndex:sC]).value;
    
    [toReturn addObject:toAdd];
    
    int i = toAdd.row;
    int j = toAdd.col;
    int v = toAdd.value;
    
    bool ending = false;
    while(ending != true)
    {
        bool found = false;
        if(i == eR && j == eC)
        {
            ending = true;
            break;
        }
        
        if((i-1)>=0)
        {
            if(((HackTileCoord*)[[board objectAtIndex:i-1]objectAtIndex:j]).value == v-1)
            {
                found = true;
                HackTileCoord* toAdd = [HackTileCoord alloc];
                
                toAdd.row = i-1;
                toAdd.col = j;
                
                [toReturn addObject:toAdd];
                
                i = i-1;
                v = v-1;
                continue;
            }
        }
        if(found != true && (i+1)<boardRows)
        {
            if(((HackTileCoord*)[[board objectAtIndex:i+1]objectAtIndex:j]).value == v-1)
            {
                found = true;
                HackTileCoord* toAdd = [HackTileCoord alloc];
                
                toAdd.row = i+1;
                toAdd.col = j;
                
                [toReturn addObject:toAdd];
                
                i = i+1;
                v = v-1;
                continue;
            }
        }
        if(found != true && (j-1)>=0)
        {
            if(((HackTileCoord*)[[board objectAtIndex:i]objectAtIndex:j-1]).value == v-1)
            {
                found = true;
                HackTileCoord* toAdd = [HackTileCoord alloc];
                
                toAdd.row = i;
                toAdd.col = j-1;
                
                [toReturn addObject:toAdd];
                
                j = j-1;
                v = v-1;
                continue;
            }
        }
        if(found != true && (j+1)<boardCols)
        {
            if(((HackTileCoord*)[[board objectAtIndex:i]objectAtIndex:j+1]).value == v-1)
            {
                found = true;
                HackTileCoord* toAdd = [HackTileCoord alloc];
                
                toAdd.row = i;
                toAdd.col = j+1;
                
                [toReturn addObject:toAdd];
                
                j = j+1;
                v = v-1;
                continue;
            }
        }
    }
    return toReturn;
}

@end
