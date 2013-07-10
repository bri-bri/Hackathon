//
//  StoreViewController.m
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import "StoreViewController.h"
#import "CBStore.h"

@interface StoreViewController ()

@end

@implementation StoreViewController

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
    
    StoreTableView *storeView = [[StoreTableView alloc] init];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 520)];
    backgroundView.autoresizesSubviews = YES;
    backgroundView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    backgroundView.image = [UIImage imageNamed:@"BG.png"];
    backgroundView.backgroundColor = [UIColor clearColor];
    backgroundView.opaque = NO;
    
    __block StoreViewController *weakSelf = self;
    
    [[CBStore sharedStore] subscribeToBalancesWhileAlive:self callback:^(NSDictionary *balances) {
        weakSelf.balance.text = [NSString stringWithFormat:@"%@",(NSNumber *)balances[@"Cognate Cash"]];
    }];
    
    self.tableContainer.backgroundColor = [UIColor clearColor];
    [self.tableContainer addSubview:storeView.view];
    [self.view insertSubview:backgroundView belowSubview:self.tableContainer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidUnload {
    [self setTableContainer:nil];
    [self setBalance:nil];
    [super viewDidUnload];
}
@end
