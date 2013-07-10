//
//  HackSettings.h
//  Hackathon
//
//  Created by Brian Hansen on 7/10/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HackSettings : NSObject {
    NSDictionary* letters;
    NSArray* dictionary;
}

@property NSDictionary* letters;
@property NSArray* dictionary;

+(HackSettings*)sharedSettings;

@end
