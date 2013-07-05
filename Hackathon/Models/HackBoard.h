//
//  HackBoard.h
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GameLayer;

@interface HackBoard : NSObject {
    NSMutableArray* tiles;
}

@property NSArray* tiles;

- (id)init;

- (void)setupBoard:(GameLayer*) gLayer;

- (NSArray*)getPath:(NSArray*)board sRow:(int)sR sCol:(int)sC eRow:(int)eR eCol:(int)eC;

@end
