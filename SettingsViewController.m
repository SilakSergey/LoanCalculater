//
//  SettingsViewController.m
//  CreditPurchased
//
//  Created by Sergey Silak on 23.08.14.
//  Copyright (c) 2014 Sergey Silak. All rights reserved.
//

#import "SettingsViewController.h"
#import "SaveConstants.h"
#import "FirstViewController.h"


@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize iCloudSwitcher=_iCloudSwitcher,DetailSwitcher=_DetailSwitcher,RedText=_RedText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}



-(void)viewWillAppear:(BOOL)animated {
    
    
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    NSString *FilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    FilePath = [FilePath stringByAppendingPathComponent:@"key.txt"];
    
    if ([defaultManager fileExistsAtPath:FilePath]) {
        self.RedText.hidden = YES;
        self.buttonBuy.hidden=YES;
    } 
    
    
    
    
    
    
    NSString *myFilePathSettings = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    myFilePathSettings = [myFilePathSettings stringByAppendingPathComponent:@"Settings.plist"];
    NSMutableDictionary *settingiCloud = [[NSMutableDictionary alloc] initWithContentsOfFile:myFilePathSettings];

    NSString  *iCloudIDStr  = [settingiCloud objectForKey:iCloudID_KEY];
    
    if ([iCloudIDStr isEqualToString:@"ON"])   {
        
        [_iCloudSwitcher setOn:YES animated:NO];
       // NSLog(@"%@", iCloudIDStr);
    } else {
        [_iCloudSwitcher setOn:NO animated:NO];
      //  NSLog(@"%@", iCloudIDStr);
    }

    
    
    NSString  *DetailID  = [settingiCloud objectForKey:DetailID_KEY];
    
    if ([DetailID isEqualToString:@"OFF"])   {
        
        [_DetailSwitcher setOn:NO animated:NO];
  //      NSLog(@"%@", iCloudIDStr);
    } else {
        [_DetailSwitcher setOn:YES animated:NO];
   //     NSLog(@"%@", iCloudIDStr);
    }

    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}



- (IBAction)iCloudSwitcher:(id)sender {
    
    NSString *myFilePathSettings = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    myFilePathSettings = [myFilePathSettings stringByAppendingPathComponent:@"Settings.plist"];
   

    NSMutableArray *Settings = [[NSMutableArray alloc] init];
    NSMutableDictionary *setting = [[NSMutableDictionary alloc] initWithContentsOfFile:myFilePathSettings];

    
    
    if (_iCloudSwitcher.on) {
        
  
        [setting setValue:@"ON"  forKey:iCloudID_KEY];
        [Settings addObject:setting];
        [setting writeToFile:myFilePathSettings atomically:YES];
        
    } else {
        

        [setting setValue:@"OFF"  forKey:iCloudID_KEY];
        [Settings addObject:setting];
        [setting writeToFile:myFilePathSettings atomically:YES];
    }
}


- (IBAction)DetailSwitcher:(id)sender {
    
    NSString *myFilePathSettings = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    myFilePathSettings = [myFilePathSettings stringByAppendingPathComponent:@"Settings.plist"];
   
    
    NSMutableArray *Settings = [[NSMutableArray alloc] init];
    NSMutableDictionary *setting = [[NSMutableDictionary alloc] initWithContentsOfFile:myFilePathSettings];
    

    
    
    if (_DetailSwitcher.on) {
        
        
        [setting setValue:@"ON"  forKey:DetailID_KEY];
        [Settings addObject:setting];
        [setting writeToFile:myFilePathSettings atomically:YES];
        
    } else {
        
        
        [setting setValue:@"OFF"  forKey:DetailID_KEY];
        [Settings addObject:setting];
        [setting writeToFile:myFilePathSettings atomically:YES];
    }
    
    
}
- (IBAction)buttonBuy:(id)sender {
        
        //сообщение о покупке платной версии
        self.SVC = [[SettingsViewController alloc] init];
        
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        
        self.SVC.productID = @"info.snteam.CP.Donate";
        [self.SVC getProductID:self];
    }


-(void)getProductID:(FirstViewController *)viewController {
    

    if ([SKPaymentQueue canMakePayments]) {
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:self.productID]];
        request.delegate = self;
        [request start];
    } else
        NSLog(@"Пожалуйста настройте ваш APP");
}


#pragma mark _
#pragma  mark SKProductsRequestDelegate


-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSArray *products = response.products;
    
    if (products.count==1) {
        _product = products[0];
        NSLog(@"Покупается %@", _product.productIdentifier);
        [self BuyProduct];
    } else {
        
        NSLog(@"Продукт не найден.");
    }
}

-(void)BuyProduct {
    
    SKPayment *payment = [SKPayment paymentWithProduct:_product];
    
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:[self UnlockPurchase];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
                
            case SKPaymentTransactionStateFailed:NSLog(@"Transaction failed");
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            default:
                break;
        }
    }
}


-(void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue {
    [self UnlockPurchase];
}
    

-(void)UnlockPurchase {
    self.RedText.hidden = YES;
    self.buttonBuy.hidden=YES;
}


@end
