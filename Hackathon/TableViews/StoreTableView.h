//
//  StoreTableView.h
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"

@interface StoreTableView : UIViewController <UITableViewDataSource,UITableViewDelegate>

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

@end
