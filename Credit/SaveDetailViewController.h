//
//  SaveDetailViewController.h
//  Credit
//
//  Created by Sergey Silak on 21.06.14.
//  Copyright (c) 2014 Sergey Silak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface SaveDetailViewController : UIViewController <MFMailComposeViewControllerDelegate, UIActionSheetDelegate, UIPopoverPresentationControllerDelegate> {
   @private
    UITextField *nameField_;
    UITextField *typeField_;
    UITextField *amountField_;
    UITextField *rateField_;
    UITextField *termField_;
    UITextField *firstpayField_;
    UITextField *monthlypayField_;
    UITextField *percentField_;
    UILabel *S_Type_;
    UILabel *S_Amount_;
    UILabel *S_Rate_;
    UILabel *S_Term_;
    UILabel *S_First_;
    UILabel *S_Monthly_;
    UILabel *S_Percent_;
    UILabel *T_N_;
    UILabel *T_Balans_;
    UILabel *T_Payment_;
    UILabel *T_Interest_;
    UILabel *T_Transfer_;
    NSDictionary *Credit_;
    IBOutlet UIView *myView_;
    NSString *TableIdentifier;
}

@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *typeField;
@property (nonatomic, retain) IBOutlet UITextField *amountField;
@property (nonatomic, retain) IBOutlet UITextField *rateField;
@property (nonatomic, retain) IBOutlet UITextField *termField;
@property (nonatomic, retain) IBOutlet UITextField *firstpayField;
@property (nonatomic, retain) IBOutlet UITextField *monthlypayField;
@property (nonatomic, retain) IBOutlet UITextField *percentField;
@property (nonatomic, retain) NSDictionary *Credit;
@property (strong, nonatomic) IBOutlet UILabel *S_Type;
@property (strong, nonatomic) IBOutlet UILabel *S_Amount;
@property (strong, nonatomic) IBOutlet UILabel *S_Rate;
@property (strong, nonatomic) IBOutlet UILabel *S_Term;
@property (strong, nonatomic) IBOutlet UILabel *S_First;
@property (strong, nonatomic) IBOutlet UILabel *S_Monthly;
@property (strong, nonatomic) IBOutlet UILabel *S_Percent;

@property (strong, nonatomic) NSMutableArray *ArrayN;
@property (strong, nonatomic) NSMutableArray *ArrayBalans;
@property (strong, nonatomic) NSMutableArray *ArrayPayment;
@property (strong, nonatomic) NSMutableArray *ArrayInterest;
@property (strong, nonatomic) NSMutableArray *ArrayTransfer;


@property (strong, nonatomic) IBOutlet UILabel *T_N;
@property (strong, nonatomic) IBOutlet UILabel *T_Balans;
@property (strong, nonatomic) IBOutlet UILabel *T_Payment;
@property (strong, nonatomic) IBOutlet UILabel *T_Interest;
@property (strong, nonatomic) IBOutlet UILabel *T_Transfer;


@property (strong, nonatomic) NSString *label;



@property (strong, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@property (strong, nonatomic) IBOutlet UIView *myView;

@property (strong, nonatomic) IBOutlet UITableView *TableDetail;

- (IBAction)menuButton:(id)sender;

-(void)DetailCalculation;



@end
