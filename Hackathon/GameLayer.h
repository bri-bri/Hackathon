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


// HelloWorldLayer
@interface GameLayer : CCLayer
{
    HackBoard* myBoard;
    HackTray* myTray;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
