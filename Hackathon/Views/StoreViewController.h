//
//  StoreViewController.h
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreTableView.h"

@interface StoreViewController : UIViewController
- (IBAction)back:(id)sender;

@property (nonatomic, retain) IBOutlet UIView *tableContainer;

@property (nonatomic, retain) StoreTableView *tabOne;
@property (nonatomic, retain) StoreTableView *tabTwo;
@property (nonatomic, retain) StoreTableView *tabThree;

@end
