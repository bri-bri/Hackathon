//
//  ViewController.m
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import "ViewController.h"
#import "StoreViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
- (IBAction)showStore:(id)sender {
    StoreViewController *vc = [[StoreViewController alloc] initWithNibName:@"StoreViewController" bundle:[NSBundle mainBundle]];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)startGame:(id)sender {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"ChangeView"
     object:nil
     ];
}

@end
