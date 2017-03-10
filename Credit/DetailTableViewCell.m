//
//  DetailTableViewCell.m
//  CreditPurchased
//
//  Created by Sergey Silak on 30.08.14.
//  Copyright (c) 2014 Sergey Silak. All rights reserved.
//

#import "DetailTableViewCell.h"
#import "SaveDetailViewController.h"


@implementation DetailTableViewCell
@synthesize S_L_Balans=_S_L_Balans,S_L_Interest=_S_L_Interest,S_L_NN=_S_L_NN,S_L_Payment=_S_L_Payment,S_L_Transfer=_S_L_Transfer;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType isEqualToString:@"iPhone"])
    {

        
        [ _S_L_NN setFont:[UIFont systemFontOfSize:9]];
        [ _S_L_Balans setFont:[UIFont systemFontOfSize:9]];
        [ _S_L_Payment setFont:[UIFont systemFontOfSize:9]];
        [ _S_L_Interest setFont:[UIFont systemFontOfSize:9]];
        [ _S_L_Transfer setFont:[UIFont systemFontOfSize:9]];
        }

        
    _S_L_NN.frame = CGRectMake(35-_S_L_NN.frame.size.width, _S_L_NN.frame.origin.y, _S_L_NN.frame.size.width, _S_L_NN.frame.size.height);
    _S_L_Balans.frame = CGRectMake(135-_S_L_Balans.frame.size.width, _S_L_Balans.frame.origin.y, _S_L_Balans.frame.size.width, _S_L_Balans.frame.size.height);
    _S_L_Payment.frame = CGRectMake(345-_S_L_Payment.frame.size.width, _S_L_Payment.frame.origin.y, _S_L_Payment.frame.size.width, _S_L_Payment.frame.size.height);
    _S_L_Interest.frame = CGRectMake(525-_S_L_Interest.frame.size.width, _S_L_Interest.frame.origin.y, _S_L_Interest.frame.size.width, _S_L_Interest.frame.size.height);
    _S_L_Transfer.frame = CGRectMake(760-_S_L_Transfer.frame.size.width, _S_L_Transfer.frame.origin.y, _S_L_Transfer.frame.size.width, _S_L_Transfer.frame.size.height);
    
    

    
        
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
