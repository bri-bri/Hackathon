//
//  GameLogic.h
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HackBoard.h"
#import "HackEnemy.h"
#import "HackTile.h"
#import "HackLetter.h"
#import "HackProjectile.h"

@interface GameLogic : NSObject {
    NSInteger* gameState;
    HackBoard* gameBoard;
}

typedef enum gameStateType : NSInteger {
    PREPARATION,
    PLAYING,
    PAUSED
} GAME_STATE;

@property NSInteger* gameState;
@property HackBoard* gameBoard;

-(id)init;
-(void)startGame;
-(void)pauseGame;
-(void)exitGame;
-(void)finishGame;

@end
