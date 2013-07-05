//
//  HackProjectile.h
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HackProjectile : NSObject {
    NSInteger* damage;
    NSNumber* speed;
    NSNumber* range; // distance projectile can go
    NSString* type;
}
@property NSInteger* damage;
@property NSNumber* speed;
@property NSNumber* range;
@property NSString* type;

@end
