//
//  CustomCell.m
//  Hackathon
//
//  Created by Brian Hansen on 7/5/13.
//  Copyright (c) 2013 Chartboost. All rights reserved.
//

#import "CustomCell.h"

@interface CustomCell () {
    
@private
    UIImageView *cellIcon;
    UIImageView *coinIcon;
    
    UILabel *titleLabel;
    UILabel *topLabel;
    UILabel *detailLabel;
    UILabel *cashLabel;
    
}
@end

@implementation CustomCell

@synthesize titleLabel,topLabel,detailLabel,cashLabel,cellIcon,coinIcon;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self->titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 300, 40)] ;
        //self->titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
        //self->titleLabel.textColor = [UIColor whiteColor];
        self->titleLabel.textAlignment = NSTextAlignmentCenter;
        self->titleLabel.backgroundColor = [UIColor clearColor];
        
        self->cellIcon = [[UIImageView alloc] initWithFrame:CGRectMake(9.5, 4, 49, 49)];
        self->coinIcon = [[UIImageView alloc] initWithFrame:CGRectMake(265, 20, 20, 20)];
        
        
        self->topLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 14, 162, 21)] ;
        //self->topLabel.font = [UIFont fontWithName:@"Helvetica" size:22];
        //self->topLabel.adjustsFontSizeToFitWidth = YES;
        //self->topLabel.textColor = [UIColor whiteColor];
        self->topLabel.backgroundColor = [UIColor clearColor];
        
        self->detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 31, 160, 21)];
        //self->detailLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
        //self->detailLabel.adjustsFontSizeToFitWidth = YES;
        //self->detailLabel.textColor = [UIColor whiteColor];
        self->detailLabel.backgroundColor = [UIColor clearColor];
        
        self->cashLabel = [[UILabel alloc] initWithFrame:CGRectMake(225, 11, 80, 41)];
       // self->cashLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
        self->cashLabel.adjustsFontSizeToFitWidth = YES;
        self->cashLabel.textAlignment = UITextAlignmentCenter;
        //self->cashLabel.textColor = [UIColor whiteColor];
        self->cashLabel.backgroundColor = [UIColor clearColor];
        
        
        
        [self.contentView addSubview:self->titleLabel];
        [self.contentView addSubview:self->cellIcon];
        [self.contentView addSubview:self->coinIcon];
        [self.contentView addSubview:self->topLabel];
        [self.contentView addSubview:self->detailLabel];
        [self.contentView addSubview:self->cashLabel];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    NSLog(@"I've been selected!");
    // Configure the view for the selected state
    
    
}


@end
