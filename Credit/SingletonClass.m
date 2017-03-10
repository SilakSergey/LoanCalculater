//
//  SingletonClass.m
//  Credit
//
//  Created by Sergey Silak on 30.06.14.
//  Copyright (c) 2014 Sergey Silak. All rights reserved.
//

#import "SingletonClass.h"


@implementation SingletonClass

+(SingletonClass*) sharedInstance{
    static SingletonClass* _shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
        _shared.Credits = [[NSMutableArray alloc] init];
    });
    return _shared;
}


@end
