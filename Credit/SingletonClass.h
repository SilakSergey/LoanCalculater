//
//  SingletonClass.h
//  Credit
//
//  Created by Sergey Silak on 30.06.14.
//  Copyright (c) 2014 Sergey Silak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonClass : NSObject
@property (nonatomic,retain) NSMutableArray *Credits;
+(SingletonClass*) sharedInstance;
@end





