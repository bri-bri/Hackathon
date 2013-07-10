//
//  HackPowerUp.h
//  Hackathon
//
//  Created by Brian Hansen on 7/9/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import "cocos2d.h"

#import <Foundation/Foundation.h>

@interface HackPowerUp : NSObject {
    
    CCSprite* mySprite;
    NSString* url;
    NSDictionary* powerUp;
}

@property  CCSprite* mySprite;
@property  NSString* url;
@property NSDictionary* powerUp;

-(id) initWithItem:(NSDictionary*)item;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
