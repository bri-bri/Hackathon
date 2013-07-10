//
//  HackPowerUp.m
//  Hackathon
//
//  Created by Brian Hansen on 7/9/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import "cocos2d.h"

#import "HackPowerUp.h"

@implementation HackPowerUp
@synthesize mySprite,url,powerUp;

-(id) initWithItem:(NSDictionary *)item
{
    self = [super init];
    if(self){
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:item[@"meta"][@"icon"]]];
        url = item[@"meta"][@"icon"];
        powerUp = item;
        
        UIImage *iconImage = [[UIImage alloc] initWithData:imageData];
        
        UIImage *smallIcon = [HackPowerUp imageWithImage:iconImage scaledToSize:CGSizeMake(30,30)];
        
        mySprite = [CCSprite spriteWithCGImage:smallIcon.CGImage key:item[@"name"]];
         
        mySprite.visible = NO;
    }
    return self;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
