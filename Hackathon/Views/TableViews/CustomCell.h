//
//  CustomCell.h
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property UIImageView *cellIcon;
@property UIImageView *coinIcon;

@property UILabel *titleLabel;
@property UILabel *topLabel;
@property UILabel *detailLabel;
@property UILabel *cashLabel;

@property BOOL enabled;

@end
