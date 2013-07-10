//
//  ViewController.m
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import "ViewController.h"
#import "StoreViewController.h"
#import "CBStore.h"

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
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    backgroundView.autoresizesSubviews = YES;
    backgroundView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    backgroundView.image = [UIImage imageNamed:@"SplashScreen.png"];
    backgroundView.backgroundColor = [UIColor clearColor];
    backgroundView.opaque = NO;
    
    __block ViewController *weakSelf = self;
    
    [[CBStore sharedStore] subscribeToBalancesWhileAlive:self callback:^(NSDictionary *balances) {
        weakSelf.balance.text = [NSString stringWithFormat:@"%@",(NSNumber *)balances[@"Cognate Cash"]];
    }];
    
    [self.view addSubview:backgroundView];
    [[self view] sendSubviewToBack:backgroundView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBalance:nil];

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

- (IBAction)earnCurrency:(id)sender {
    [[CBStore sharedStore] earn:10 forCurrency:@"Cognate Cash"];
}

- (IBAction)spendCurrency:(id)sender {
    [[CBStore sharedStore] spend:10 forCurrency:@"Cognate Cash"];
}

@end
