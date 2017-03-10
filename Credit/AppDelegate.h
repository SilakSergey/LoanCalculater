//
//  AppDelegate.h
//  Credit
//
//  Created by Sergey Silak on 20.06.14.
//  Copyright (c) 2014 Sergey Silak. All rights reserved.
//
#define kFILENAME @"CreditList.plist"


#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (retain, nonatomic) UIWindow *window;

@property (strong) NSMetadataQuery *query;

-(void)loadiCloud;

-(void)LoadFile;

-(void)LoadCredits;






@end
