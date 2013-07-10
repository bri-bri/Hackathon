//
//  GameLayer.h
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright Chartboost 2013. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"


#import "HackBoard.h"
#import "HackBoardView.h"

#import "HackTray.h"

#import "GameLogic.h"

// HelloWorldLayer
@interface GameLayer : CCLayer
{
    HackBoard* myBoard;
    HackTray* myTray;
    GameLogic* myLogic;
    
    CCSprite* selSprite;
    int         selSpriteIndex;
    float       oldX;
    float       oldY;
    
    NSMutableArray* possibleWord;
    NSMutableArray* takenIndexes;
    NSMutableArray* takenGridCoords;
    NSMutableArray* gameLetters;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

-(void)transitionToPreparationState;

-(void)transitionToPlayingState;

@end
