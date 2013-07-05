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
    NSMutableArray*     handLetters;
    NSMutableArray*     handPowerUps;
}

@property NSMutableArray* handLetters;
@property NSMutableArray* handPowerUps;

@end
