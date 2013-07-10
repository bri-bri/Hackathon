//
//  ViewController.h
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *balance;
- (IBAction)showStore:(id)sender;
- (IBAction)startGame:(id)sender;
- (IBAction)earnCurrency:(id)sender;
- (IBAction)spendCurrency:(id)sender;

@end
