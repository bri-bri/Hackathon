//
//  HackTile.h
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HackLetter.h"
#import "HackTileCoord.h"

@interface HackTile : NSObject {
    NSNumber* scoreMultiplier;
    HackLetter* myHackLetter;
    HackTileCoord* myGridCoord;
}

@property NSNumber* scoreMultiplier;
@property HackLetter* myHackLetter;
@property HackTileCoord* myGridCoord;

-(id)init;

@end
