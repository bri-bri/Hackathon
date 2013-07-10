//
//  HackSettings.m
//  Hackathon
//
//  Created by Brian Hansen on 7/10/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import "HackSettings.h"

@implementation HackSettings

@synthesize letters,dictionary;

static HackSettings *sharedSettings =nil;

+(HackSettings*) sharedSettings
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSettings = [[HackSettings alloc] init];
    });
    return sharedSettings;
}

-(id)init
{
    self = [super init];
    if(self){
        NSString* path = [[NSBundle mainBundle] pathForResource:@"sowpods"
                                                         ofType:@"txt"];
        NSString* rawDict = [NSString stringWithContentsOfFile:path
                                                      encoding:NSUTF8StringEncoding
                                                         error:NULL];
        dictionary = [rawDict componentsSeparatedByString:@"\n"];
        
        NSString* lettersPath = [[NSBundle mainBundle] pathForResource:@"letters" ofType:@"plist"];
        letters = [NSDictionary dictionaryWithContentsOfFile:lettersPath];
    }
    return self;
}

@end
