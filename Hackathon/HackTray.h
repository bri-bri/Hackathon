//
//  HackTray.h
//  Hackathon
//
//  Created by Carmine Red on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import <Foundation/Foundation.h>

#define __MAX_HANDSIZE  7

#import "GameLogic.h"

@interface HackTray : NSObject
{
    float               anchorX;
    float               anchorY;
    NSMutableArray*     handLetters;
    NSMutableArray*     handPowerUps;
    
    NSMutableArray*     handLetterSprites;
    NSMutableArray*     handPowerUpSprites;
    
    GameLayer*          myGLayer;
}

@property float anchorX;
@property float anchorY;
@property NSMutableArray* handLetters;
@property NSMutableArray* handPowerUps;
@property NSMutableArray* handLetterSprites;
@property NSMutableArray* handPowerUpSprites;

- (void)setupTray:(GameLayer*) gLayer;

- (void)emptyHandLetters;
- (void)emptyHandPowerUps;


- (void)showHandPowerUps;
- (void)showHandLetters;

- (void)fillHandLetters;
- (void)fillHandPowerUps;

@end
