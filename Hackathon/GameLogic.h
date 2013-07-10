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

@class GameLayer;

@interface GameLogic : NSObject {
    NSInteger* gameState;
    HackBoard* gameBoard;
    NSMutableArray* gameEnemies;
    NSMutableArray* enemyPath;
    NSMutableArray* gameBullets;
    NSMutableArray* gameLetters;
    
    GameLayer*  myLayer;
    NSArray*    boardPath;
    int enemiesToSpawn;
    float spawnInterval;
    float spawnTimer;
}

typedef enum gameStateType : NSInteger {
    PREPARATION,
    PLAYING,
    PAUSED
} GAME_STATE;

@property NSInteger* gameState;
@property HackBoard* gameBoard;
@property NSMutableArray* gameEnemies;
@property NSMutableArray* enemyPath;
@property NSMutableArray* gameBullets;
@property NSMutableArray* gameLetters;
@property GameLayer* myLayer;
@property NSArray* boardPath;

@property int enemiesToSpawn;
@property float spawnInterval;
@property float spawnTimer;

-(id)init;
-(void)startGame;
-(void)pauseGame;
-(void)exitGame;
-(void)finishGame;

-(bool)shouldAttemptTransition;
-(bool)doTransition;

-(BOOL)verifyWord:(NSString*)word;

-(void)gameLoop:(ccTime)dT;

-(void)spawnEnemy;

-(bool)isPlayingState;

@end
