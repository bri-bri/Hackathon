//
//  GameLogic.m
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import "GameLogic.h"
#import "HackBoard.h"
#import "HackEnemy.h"
#import "HackTile.h"
#import "HackLetter.h"
#import "HackProjectile.h"

@implementation GameLogic

-(id)init {
    if( (self=[super init]) ) {
        
        gameBoard = [[HackBoard alloc] init];
        gameState = PREPARATION;
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

@end
