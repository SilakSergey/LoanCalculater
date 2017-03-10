//
//  DetailTableViewCell.h
//  CreditPurchased
//
//  Created by Sergey Silak on 30.08.14.
//  Copyright (c) 2014 Sergey Silak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *S_L_NN;
@property (strong, nonatomic) IBOutlet UILabel *S_L_Balans;
@property (strong, nonatomic) IBOutlet UILabel *S_L_Payment;
@property (strong, nonatomic) IBOutlet UILabel *S_L_Interest;
@property (strong, nonatomic) IBOutlet UILabel *S_L_Transfer;

@end
