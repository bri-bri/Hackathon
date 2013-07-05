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
    
}

@property float anchorX;
@property float anchorY;
@property NSMutableArray* handLetters;
@property NSMutableArray* handPowerUps;

- (void)setupTray:(GameLayer*) gLayer;

@end
