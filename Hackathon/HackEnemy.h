//
//  HackEnemy.h
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HackEnemy : NSObject {
    NSString* type;
    NSInteger* hp;
    NSNumber* speed;
}

@property NSString* type;
@property NSInteger* hp;
@property NSNumber* speed;

@end
