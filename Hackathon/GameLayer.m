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
    
    didTransition = [myLogic attemptTransition];
}
@end
