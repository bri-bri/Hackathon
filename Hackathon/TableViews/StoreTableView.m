//
//  StoreTableView.m
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import "StoreTableView.h"
#import "CustomCell.h"
#import "CBStore.h"

@interface StoreTableView (){

@private

UITableView *myTableView;

NSNumber *coinBankRoll;

BOOL isLoading;
BOOL isLabelRow;

//coinPouchViews

UIImageView *coinPouchAnimatedIV;
UIImageView *coinPouchEndIV;
UIImageView *coinPouchMiddleIV;

NSString *storeViewID;

UIAlertView *purchaseAlert;
NSDictionary *purchaseItem;

int storeViewTag;

}

@property NSArray *items;
@property UITableView *myTableView;
@end

@implementation StoreTableView
@synthesize myTableView;
-(id)init {
    return [self initWithStoreViewID:@"default-store" withTag:0];

}

- (id) initWithStoreViewID:(NSString *)storeID withTag:(int)storeTag {
   
    if ( self = [super init]) {
        //self->storeViewID = storeID;
        //self->storeViewTag = storeTag;
        
    }
    return self;
    
}
- (void)loadView{
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 520)];
    contentView.autoresizesSubviews = YES;
    contentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    contentView.backgroundColor = [UIColor clearColor];
    contentView.tag = self->storeViewTag;
    
    [self setView:contentView];
    /*
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 520)];
    backgroundView.autoresizesSubviews = YES;
    backgroundView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    backgroundView.image = [UIImage imageNamed:@"BG.png"];
    backgroundView.backgroundColor = [UIColor clearColor];
    backgroundView.opaque = NO;
    [self.view addSubview:backgroundView];*/

    //    self->coinPouchAnimatedIV = [[UIImageView alloc] initWithFrame:CGRectMake(40, 37, 90, 28)];
    //    self->coinPouchAnimatedIV.image = [UIImage imageNamed:@"cion_box.png"];
    //    [self.view addSubview:coinPouchAnimatedIV];
    
    //    self->coinPouchEndIV = [[UIImageView alloc] initWithFrame:CGRectMake(282, 48.8, 20, 23.5)];
    //    self->coinPouchEndIV.image = [UIImage imageNamed:@"cion_box.png"];
    //    [self.view addSubview:coinPouchEndIV];
    
    //    self->coinPouchMiddleIV = [[UIImageView alloc] initWithFrame:CGRectMake(278, 48.8, 15, 23.5)];
    //    self->coinPouchMiddleIV.image = [UIImage imageNamed:@"cion_box.png"];
    //    [self.view addSubview:coinPouchMiddleIV];
    
    
    
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(8, 0, 300, 377) style:UITableViewStylePlain];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //[myTableView setAutoresizesSubviews:YES];
    //[myTableView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [myTableView setRowHeight:59.5];
    
    [myTableView setDataSource:self];
    [myTableView setDelegate:self];
    
    //myTableView = [[UITableView alloc] init];
    
    [[self view] addSubview:myTableView];
     
    
}

- (void)viewDidLoad
{
    self->isLoading = YES;
    [self updateStoreItemsAnimated:NO];
    
    [super viewDidLoad];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
   [self updateStoreItemsAnimated:NO];
    
    [super viewWillAppear:animated];
    
}

- (void)updateStoreItemsAnimated:(BOOL)animated{
    
    CBStore *store = [CBStore sharedStore];
    
    NSLog(@"Loading store!");
    __block StoreTableView *weakSelf = self;
    
    [store subscribeToStoreView:@"boosts" whileAlive:self callback:^(CBStoreViewStatus status, NSArray *items, NSError *error) {
        
        NSLog(@"Store view subscription callback triggered for view: %@ with status: %d", @"boosts", status);
        
        
        switch (status) {
                
            case kCBStoreViewStatusLoading: {
                weakSelf->isLoading = YES;
            } break;
                
            case kCBStoreViewStatusLoaded:
            case kCBStoreViewStatusChanged:
            case kCBStoreViewStatusCachedContent: {
                weakSelf->isLoading = NO;
                weakSelf.items = items;
                [weakSelf.myTableView reloadData];
            } break;
                
            case kCBStoreViewStatusFailed: {
                weakSelf->isLoading = NO;
                NSLog(@"failed to load store view:\n%@", error);
                [weakSelf.myTableView reloadData];
            } break;
        }
    }];
    /*
    [store subscribeToBalancesWhileAlive:self callback:^(NSDictionary *balances) {
        NSString *infoString = [NSString stringWithFormat:@"%d CognateCaches",
                                ((NSNumber *)balances[@"CognateCache"]).intValue];
        NSLog(@"In-store info button update: %@", infoString);
        
       // weakSelf.coinBankRoll = (NSNumber *)balances[@"coins"];
    }];
     */
    
   // [self createFlexibleCoinBankWith:coinBankRoll viewAnimated:animated];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.items count] == 0) {
        UITableViewCell *textCell;
        NSString* kCMBoostTableViewCell = @"CMBoostTableViewCell";
        NSString* kCMBoostTableViewMessageCell = @"CMBoostTableViewMessageCell";
        NSString* kCMBoostTableViewEmptyCell = @"CMBoostTableViewEmptyCell";
        
        if (!(textCell = [tableView dequeueReusableCellWithIdentifier:kCMBoostTableViewMessageCell])) {
            textCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCMBoostTableViewMessageCell];
            textCell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        
        if (self->isLoading) {
            textCell.textLabel.text = @"Loading...";
        } else {
            textCell.textLabel.text = @"Empty...";
        }
        
        return textCell;
    }
    
    CustomCell *cCell = [self newCustomCellForIndex:indexPath];
    
    return cCell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (CustomCell *)newCustomCellForIndex:(NSIndexPath *)indexPath {
    
    NSDictionary *item = self.items[indexPath.row];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    CustomCell *bCell = [[CustomCell alloc] init];
    
    /*
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"BoostCells.plist"];
    NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
    
    NSString *assetString = [[NSString alloc] initWithFormat:@"Cell%d", indexPath.row];
    
    NSMutableDictionary *contentDict = [plistData objectForKey:assetString];
    */
    
    //NSLog(@"%@", item[@"type"]);
    if (![item[@"type"] isEqualToString:@"label"]) {
        
        NSLog(@"Item is not label!");
        self->isLabelRow = NO;
        BOOL isPurchased = [self.items[indexPath.row][@"purchased"] boolValue];
        if (isPurchased) {
            bCell.contentView.alpha = 0.5;
            bCell.userInteractionEnabled = NO;
            bCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        UIImage *backgroundImage = [UIImage imageNamed:@"StoreBG.png"];
        UIImageView *backgroundIV = [[UIImageView alloc] initWithImage:backgroundImage];
        backgroundIV.backgroundColor = [UIColor clearColor];
        [bCell setBackgroundView:backgroundIV];
        
        UIImage *selectedImage = [UIImage imageNamed:@"hover_bar.png"];
        UIImageView *selectedIV = [[UIImageView alloc] initWithImage:selectedImage];
        [bCell setSelectedBackgroundView:selectedIV];
        
        if (item[@"meta"][@"icon"]) {
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                    // this code happens in the background
                    // fetch image
                    
                    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:item[@"meta"][@"icon"]]];
                    
                    if (!imageData) return;
                    
                    UIImage *iconImage = [[UIImage alloc] initWithData:imageData];
                    
                    //[self.iconCache setObject:iconImage forKey:item[@"meta"][@"icon"]];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // this is on the main thread again...
                        bCell.cellIcon.image = iconImage;
                        
                    });
                });
            
        } else {
            
            bCell.cellIcon.image = [UIImage imageNamed:@"icon_1.png"];
            
       }
        
        
        
        
        if (item) {
            bCell.topLabel.text = item[@"name"];
            if ([item[@"purchase"] isEqualToString:@"currency"]) {
                
                bCell.cashLabel.frame = CGRectMake(215, 9, 55, 41);
                bCell.cashLabel.text = [formatter stringFromNumber:((NSNumber *)item[@"amount"])];
                bCell.coinIcon.image = [UIImage imageNamed:@"coin.png"];
                
            } else if ([item[@"purchase"] isEqualToString:@"iap"]) {
                
                NSNumber *tierPrice = item[@"iap"][@"tier"];
                bCell.cashLabel.text = [NSString stringWithFormat:@"$%.2f", ([tierPrice floatValue] -0.01)];
                
            }
            
            NSString *detailString = [[NSString alloc] initWithFormat:@"%@",item[@"meta"][@"description"]];
            
            
            if (item[@"meta"][@"description_currency"]){
                
                CBStore *store = [CBStore sharedStore];
                
                [store subscribeToBalancesWhileAlive:bCell callback:^(NSDictionary *balances) {
                    NSString *infoString = [NSString stringWithFormat:@"%d CognateCache",
                                            ((NSNumber *)balances[@"CognateCache"]).intValue];
                    NSLog(@"In-store info button update: %@", infoString);
                    
                    bCell.detailLabel.text = [detailString stringByReplacingOccurrencesOfString:@"%" withString:[NSString stringWithFormat:@"%d",((NSNumber *)item[@"meta"][@"description_currency"]).intValue]];
                }];
                
                
            }else {
                if (![detailString isEqualToString:@"(null)"]) {
                    bCell.detailLabel.text = detailString;
                }else bCell.detailLabel.text = @"";
                
                
            }
            
        }else{
            //Error. Should never hit this.
            NSLog(@"Error. No store items.");
            //bCell.detailLabel.text = [contentDict objectForKey:@"detailLabel"];
            //bCell.cashLabel.text = [contentDict objectForKey:@"cashLabel"];
            
        }
        
        
    } else {
        NSLog(@"Item is label");
        bCell.userInteractionEnabled = NO;
       bCell.titleLabel.adjustsFontSizeToFitWidth = YES;
        bCell.titleLabel.textColor = [UIColor whiteColor];
        bCell.titleLabel.text = [NSString stringWithFormat:@"%@", item[@"text"]];
        NSLog(@"%@",item);
        bCell.selectionStyle = UITableViewCellSelectionStyleNone;
        self->isLabelRow = YES;
        
        
        //NSLog(@"%d", indexPath.row);
    }
    
    return bCell;
}


@end
