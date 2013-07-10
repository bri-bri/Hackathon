//
//  GameLayer.m
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright Chartboost 2013. All rights reserved.
//


// Import the interfaces
#import "GameLayer.h"
#import "HelloWorldLayer.h"
#import "HackTileCoord.h"


#pragma mark - GameLayer

// HelloWorldLayer implementation
@implementation GameLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// 
-(id) init
{
	if( (self=[super init])) {

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		CCSprite *background;
		
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			//background = [CCSprite spriteWithFile:@"Default.png"];
            background = [CCSprite spriteWithFile:@"texture_plaster_blue_color_background_160712_zeusbox_com-2560x1600.jpg"];
			background.rotation = 0;
		} else {
			background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
		}
		background.position = ccp(size.width/2, size.height/2);

		// add the label as a child to this Layer
		[self addChild: background];
        
        selSprite = nil;
        
        myLogic = [[GameLogic alloc] init];
        myLogic.myLayer = self;
        
        myBoard = [[HackBoard alloc] init];
        
        [myBoard setupBoard:self];
        [myBoard testPath];
        
        myLogic.gameBoard = myBoard;
        
        //myLogic.boardPath = [myBoard getPath:myBoard.tiles sRow:0 sCol:0 eRow:9 eCol:9];
        //[myLogic spawnEnemy];
        
        myTray = [[HackTray alloc] init];
        
        [myTray setupTray:self];
        
        [myTray showHandLetters];
        
        //button for change gamestate
        CCMenuItem *stateButton = [CCMenuItemImage
                                    itemFromNormalImage:@"button.png" selectedImage:@"buttonDown.png"
                                    target:self selector:@selector(stateButtonTapped:)];
        stateButton.position = ccp(155, 40);
        CCMenu *stateButtonMenu = [CCMenu menuWithItems:stateButton, nil];
        stateButtonMenu.position = CGPointZero;
        [self addChild:stateButtonMenu];
        
        [self schedule:@selector(gameLoop:) interval: 1/60.0f];
        
        possibleWord = [[NSMutableArray alloc] initWithCapacity:6];
        takenIndexes = [[NSMutableArray alloc] initWithCapacity:6];
        takenGridCoords = [[NSMutableArray alloc] initWithCapacity:6];
        
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	}
	
	return self;
}

-(void) onEnter
{
	[super onEnter];
	//[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[HelloWorldLayer scene] ]];
}

- (void) gameLoop: (ccTime) dT
{
    // Do game logic here
    [myLogic gameLoop:dT];
}

- (void) stateButtonTapped:(id)sender
{
    NSLog(@"Awesome");
    bool didTransition = false;
    
    if([myLogic shouldAttemptTransition])
    {
        if([self testThenCommitNewWord])
        {
            didTransition = [myLogic doTransition];
        }
    }
}

-(void)transitionToPreparationState
{
    [myTray showHandLetters];
}

-(void)transitionToPlayingState
{
    [myTray showHandPowerUps];
}

- (void)selectSpriteForTouch:(CGPoint)touchLocation
{
    //for (CCSprite *sprite in myTray.handLetterSprites)
    for(int i = 0; i < [myTray.handLetterSprites count]; i++)
    {
        CCSprite* sprite = [myTray.handLetterSprites objectAtIndex:i];
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {
            bool taken = false;
            for(NSNumber* num in takenIndexes)
            {
                if([num intValue] == i)
                {
                    taken = true;
                    break;
                }
            }
            if(taken == false)
            {
                selSprite = sprite;
                selSpriteIndex = i;
                oldX = selSprite.position.x;
                oldY = selSprite.position.y;
            }
            break;
        }
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    //NSLog(@"touchBegan:x%fy%f", touchLocation.x, touchLocation.y);
    [self selectSpriteForTouch:touchLocation];
    return TRUE;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    NSLog(@"touchEnded:x%fy%f", touchLocation.x, touchLocation.y);
    if(selSprite != nil)
    {
        bool valid = false;
        //is it in a valid grid spot?
        if([self pointIsValidGridSpot:touchLocation])
        {
            //what spot is it?
            int gridX = [myBoard getGridXFromXLoc:(int)touchLocation.x gridWidth:30];
            int gridY = 9 - [myBoard getGridYFromYLoc:(int)touchLocation.y gridHeight:30];
            
            //is something already in that spot?
            if(((HackTileCoord*)[[myBoard.tiles objectAtIndex:gridY] objectAtIndex:gridX]).status != 1)
            {
                bool taken = false;
                for(HackTileCoord* coord in takenGridCoords)
                {
                    if(coord.col == gridX && coord.row == gridY)
                    {
                        taken = true;
                    }
                }
                //is another temp letter in that spot?
                if(taken == false)
                {
                    //is that spot even in line with the other letters?
                    if(true)
                    {
                        HackTileCoord* newCoord = [[HackTileCoord alloc] init];
                        newCoord.col = gridX;
                        newCoord.row = gridY;
                        [takenGridCoords addObject:newCoord];
                        
                        selSprite.position = ccp(oldX, oldY);
                        [selSprite setFlipY:YES];
                        
                        [takenIndexes addObject:[NSNumber numberWithInt:selSpriteIndex]];
                        
                        //hide from tray, we'll actually remove it if the word is valid
                        valid = true;
                        
                        NSString* ltr = ((HackLetter*)[myTray.handLetters objectAtIndex:selSpriteIndex]).letter;
                        HackLetter* toAdd = [[HackLetter alloc] initWithLetter:ltr];
                        
                        [possibleWord addObject:toAdd];
                        
                        CCSprite* tempSprite = toAdd.mySprite;
                        
                        int xLoc = 15 + [myBoard getXLocFromGridX:gridX gridWidth:30];
                        int yLoc = 15 + [myBoard getYLocFromGridY:gridY gridHeight:30];
                        
                        tempSprite.position = ccp(xLoc, yLoc);
                        
                        tempSprite.visible = YES;
                        
                        [self addChild:tempSprite];
                        
                        selSpriteIndex = -1;
                        selSprite = nil;
                    }
                }
            }
        }
        
        if(valid == false)
        {
            //return to original spot
            selSprite.position = ccp(oldX, oldY);
            selSprite = nil;
            selSpriteIndex = -1;
        }
    }
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
    if (selSprite) {
        CGPoint newPos = ccpAdd(selSprite.position, translation);
        selSprite.position = newPos;
    }
}

- (bool)pointIsValidGridSpot:(CGPoint)touchLocation
{
    //gah, hardcoded magic numbers
    if(touchLocation.x >= 10 && touchLocation.x <= 310
       && touchLocation.y >= 160 && touchLocation.y <= 460)
    {
        return true;
    }
    else
    {
        return false;
    }
}

-(bool)testThenCommitNewWord
{
    bool abort = false;
    
    //is it even a word?
    
    //if not, abort
    if(false)
    {
        abort = true;
    }
    //temporarily build new boardState
    for(HackTileCoord* coord in takenGridCoords)
    {
        ((HackTileCoord*)[[myBoard.tiles objectAtIndex:coord.row] objectAtIndex:coord.col]).status = 1;
    }
    //test new boardstate's path-worthiness
    
    NSArray* test = [myBoard getPath:myBoard.tiles sRow:0 sCol:0 eRow:9 eCol:9];
    
    //if not path-worthy, revert boardstate and abort
    if(test == nil)
    {
        abort = true;
        //revert boardstate
        for(HackTileCoord* coord in takenGridCoords)
        {
            ((HackTileCoord*)[[myBoard.tiles objectAtIndex:coord.row] objectAtIndex:coord.col]).status = 0;
        }
    }
    
    //cleanup whether or not we abort
    
    [takenGridCoords removeAllObjects];
    
    //if we have to abort, need to rollback all tile visuals
    if(abort == true)
    {
        //reset all hand letters to normal
        for(CCSprite* toReset in myTray.handLetterSprites)
        {
            toReset.flipY = NO;
        }
        
        [takenIndexes removeAllObjects];
        for(HackLetter* hackLet in possibleWord)
        {
            [self removeChild:hackLet.mySprite cleanup:YES];
        }
        [possibleWord removeAllObjects];
        
        return NO;
    }
    else
    {
        //if we haven't aborted yet, guess it's good
        
        //remove towers from hand
        for(int i = [myTray.handLetters count]; i >= 0; i--)
        {
            bool remove = false;
            for(NSNumber* num in takenIndexes)
            {
                if([num intValue] == i)
                {
                    remove = true;
                    break;
                }
            }
            if(remove)
            {
                [myTray.handLetters removeObjectAtIndex:i];
                [self removeChild:[myTray.handLetterSprites objectAtIndex:i] cleanup:YES];
                [myTray.handLetterSprites removeObjectAtIndex:i];
            }
        }
        
        //add towers to board
        for(HackLetter* newTower in possibleWord)
        {
            //[self removeChild:newTower.mySprite];
            //[gameLetters addObject:newTower];
            //[self addChild:newTower.mySprite];
            NSString* ltr = newTower.letter;
            HackLetter* toAdd = [[HackLetter alloc] initWithLetter:ltr];
            CCSprite* tempSprite = toAdd.mySprite;
            
            tempSprite.position = ccp(newTower.mySprite.position.x, newTower.mySprite.position.y);
            
            tempSprite.visible = YES;
            
            [self addChild:tempSprite];
        }
        
        [takenIndexes removeAllObjects];
        for(HackLetter* hackLet in possibleWord)
        {
            [self removeChild:hackLet.mySprite cleanup:YES];
        }
        [possibleWord removeAllObjects];
        
        return YES;
    }
}
@end
