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

@synthesize tiles;

- (id)init
{
    self = [super init];
    if(self)
    {
    }
    
    return self;
}

- (void)setupBoard:(GameLayer*) gLayer
{
    //CGSize winSize = [CCDirector sharedDirector].winSize;
    
    CCSprite *spriteToAdd = [CCSprite spriteWithFile:@"tilebg.png"];
    
    int xLoc = 10 + spriteToAdd.contentSize.width/2;
    int yLoc = 460 - spriteToAdd.contentSize.height/2;
    
    spriteToAdd.position = ccp(xLoc, yLoc);
    [gLayer addChild:spriteToAdd];
    
    tiles = [[NSMutableArray alloc] initWithCapacity:10];
    
    for(int i = 0; i < 10; i++)
    {
        [tiles addObject: [[NSMutableArray alloc] initWithCapacity:10]];
        for(int j = 0; j < 10; j++)
        {
            HackTileCoord* toAdd = [[HackTileCoord alloc] init];
            toAdd.row = i;
            toAdd.col = j;
            toAdd.value = 0;
            toAdd.status = 0;
            [[tiles objectAtIndex:i] addObject:toAdd];
        }
    }
    
    /*
    ((HackTileCoord*)[[tiles objectAtIndex:4] objectAtIndex:0]).status = 1;
    ((HackTileCoord*)[[tiles objectAtIndex:4] objectAtIndex:1]).status = 1;
    ((HackTileCoord*)[[tiles objectAtIndex:4] objectAtIndex:2]).status = 1;
    ((HackTileCoord*)[[tiles objectAtIndex:4] objectAtIndex:3]).status = 1;
    ((HackTileCoord*)[[tiles objectAtIndex:4] objectAtIndex:4]).status = 1;
    ((HackTileCoord*)[[tiles objectAtIndex:4] objectAtIndex:5]).status = 1;
    ((HackTileCoord*)[[tiles objectAtIndex:4] objectAtIndex:6]).status = 1;
    ((HackTileCoord*)[[tiles objectAtIndex:4] objectAtIndex:7]).status = 1;
    ((HackTileCoord*)[[tiles objectAtIndex:4] objectAtIndex:8]).status = 1;
    
    ((HackTileCoord*)[[tiles objectAtIndex:6] objectAtIndex:1]).status = 1;
    ((HackTileCoord*)[[tiles objectAtIndex:6] objectAtIndex:2]).status = 1;
    ((HackTileCoord*)[[tiles objectAtIndex:6] objectAtIndex:3]).status = 1;
    ((HackTileCoord*)[[tiles objectAtIndex:6] objectAtIndex:4]).status = 1;
    ((HackTileCoord*)[[tiles objectAtIndex:6] objectAtIndex:5]).status = 1;
    ((HackTileCoord*)[[tiles objectAtIndex:6] objectAtIndex:6]).status = 1;
    ((HackTileCoord*)[[tiles objectAtIndex:6] objectAtIndex:7]).status = 1;
    ((HackTileCoord*)[[tiles objectAtIndex:6] objectAtIndex:8]).status = 1;
    ((HackTileCoord*)[[tiles objectAtIndex:6] objectAtIndex:9]).status = 1;
    */
}

- (void)testPath
{
    NSArray* myPath = [self getPath:tiles sRow:0 sCol:0 eRow:9 eCol:9];
    if(myPath == nil)
    {
        NSLog(@"No Path!");
    }
    else
    {
        for(int i = 0; i < [myPath count]; i++)
        {
            NSLog(@"r%dc%dv%d", ((HackTileCoord*)[myPath objectAtIndex:i]).row,
                  ((HackTileCoord*)[myPath objectAtIndex:i]).col,
                  ((HackTileCoord*)[myPath objectAtIndex:i]).value);
        }
    }
}

// takes in a two dimensional NSArray of HackTileCoords size 10x10, a starting tile, and an ending tile
// returns a one-dimentional array 
- (NSArray*)getPath:(NSArray*)board sRow:(int)sR sCol:(int)sC eRow:(int)eR eCol:(int)eC
{
    int boardRows = 10;
    int boardCols = 10;
    
    int currVal = 1;
    ((HackTileCoord*)[[board objectAtIndex:eR]objectAtIndex:eC]).value = currVal;
    
    int max = boardRows * boardCols;
    int step = 0;
    bool madeProgress = false;
    
    while(step < max)
    {
        step++;
        
        NSLog(@"step %d", step);
        
        bool found = false;
        madeProgress = false;
        
        for(int i = 0; i < boardRows; i++)
        {
            for(int j = 0; j < boardCols; j++)
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
                            madeProgress = true;
                        }
                        else
                        {
                            if(((HackTileCoord*)[[board objectAtIndex:i-1]objectAtIndex:j]).value == 0
                               && ((HackTileCoord*)[[board objectAtIndex:i-1]objectAtIndex:j]).status == 0)
                            {
                                ((HackTileCoord*)[[board objectAtIndex:i-1]objectAtIndex:j]).value = currVal+1;
                                madeProgress = true;
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
                            madeProgress = true;
                        }
                        else
                        {
                            if(((HackTileCoord*)[[board objectAtIndex:i+1]objectAtIndex:j]).value == 0
                               && ((HackTileCoord*)[[board objectAtIndex:i+1]objectAtIndex:j]).status == 0)
                            {
                                ((HackTileCoord*)[[board objectAtIndex:i+1]objectAtIndex:j]).value = currVal+1;
                                madeProgress = true;
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
                            madeProgress = true;
                        }
                        else
                        {
                            if(((HackTileCoord*)[[board objectAtIndex:i]objectAtIndex:j-1]).value == 0
                               && ((HackTileCoord*)[[board objectAtIndex:i]objectAtIndex:j-1]).status == 0)
                            {
                                ((HackTileCoord*)[[board objectAtIndex:i]objectAtIndex:j-1]).value = currVal+1;
                                madeProgress = true;
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
                            madeProgress = true;
                        }
                        else
                        {
                            if(((HackTileCoord*)[[board objectAtIndex:i]objectAtIndex:j+1]).value == 0
                               && ((HackTileCoord*)[[board objectAtIndex:i]objectAtIndex:j+1]).status == 0)
                            {
                                ((HackTileCoord*)[[board objectAtIndex:i]objectAtIndex:j+1]).value = currVal+1;
                                madeProgress = true;
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
        else if(madeProgress == false)
        {
            step = max;
        }
        
        currVal++;
    }
    
    if(madeProgress == false)
    {
        return nil;
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
    
    //cleanup board
    for(int i = 0; i < boardRows; i++)
    {
        for(int j = 0; j < boardCols; j++)
        {
            ((HackTileCoord*)[[board objectAtIndex:i]objectAtIndex:j]).value = 0;
        }
    }
    return toReturn;
}

-(float)getXLocFromGridX:(int)gridX gridWidth:(float)width
{
    float xLoc = 10;
    //int yLoc = 430 + spriteToAdd.contentSize.height/2;
    
    xLoc += (gridX * width);
    //yLoc -= (j * spriteToAdd.contentSize.height);
    
    return xLoc;
}

-(float)getYLocFromGridY:(int)gridY gridHeight:(float)height
{
    float yLoc = 430;
    //int yLoc = 430 + spriteToAdd.contentSize.height/2;
    
    yLoc -= (gridY * height);
    //yLoc -= (j * spriteToAdd.contentSize.height);
    
    return yLoc;
}

-(int)getGridXFromXLoc:(int)xLoc gridWidth:(float)width
{
    int gridX;
    
    gridX = (xLoc - 10) / (int)width;
    
    return gridX;
}

-(int)getGridYFromYLoc:(int)yLoc gridHeight:(float)height
{
    int gridY;
    
    gridY = (yLoc - 160) / (int)height;
    
    return gridY;
}

@end
