//
//  SettingsViewController.h
//  CreditPurchased
//
//  Created by Sergey Silak on 23.08.14.
//  Copyright (c) 2014 Sergey Silak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>


@interface SettingsViewController : UIViewController <SKPaymentTransactionObserver, SKProductsRequestDelegate>
@property (strong, nonatomic) IBOutlet UISwitch *iCloudSwitcher;
- (IBAction)iCloudSwitcher:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *RedText;

@property (strong, nonatomic) IBOutlet UISwitch *DetailSwitcher;
- (IBAction)DetailSwitcher:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *buttonBuy;
- (IBAction)buttonBuy:(id)sender;

-(void)getProductID:(UIViewController *)viewcontroller;
-(void)BuyProduct;



@property (strong, nonatomic) SettingsViewController *SVC;
@property (strong, nonatomic) SKProduct *product;
@property (strong, nonatomic) NSString *productID;


@end
