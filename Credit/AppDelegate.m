//
//  AppDelegate.m
//  Credit
//
//  Created by Sergey Silak on 20.06.14.
//  Copyright (c) 2014 Sergey Silak. All rights reserved.
//




#import "AppDelegate.h"
#import "SaveConstants.h"
#import "SingletonClass.h"

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   //если файл настроек отсутствует - копируем его их ресурсов проекта
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *myFilePathSettings = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    myFilePathSettings = [myFilePathSettings stringByAppendingPathComponent:@"Settings.plist"];

    if (![fileManager fileExistsAtPath:myFilePathSettings]) {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
        [fileManager copyItemAtPath:sourcePath toPath:myFilePathSettings error:nil];
    }
   
    NSMutableDictionary *settingiCloud = [[NSMutableDictionary alloc] initWithContentsOfFile:myFilePathSettings];
    NSString  *iCloudIDStr  = [settingiCloud objectForKey:iCloudID_KEY];
    
    if ([iCloudIDStr isEqualToString:@"ON"])   {
        
        [self loadiCloud];
   
    } else {

        [self LoadCredits];
    }
    
    NSMetadataQuery *query = [[NSMetadataQuery alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadiCloud) name: UIApplicationDidBecomeActiveNotification object:query];

    return YES;
}


- (void)loadiCloud {
    
    NSURL *ubiq = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    if (ubiq) {
        //     NSLog(@"Доступ к iCloud  %@", ubiq);
        [self LoadFile];
    } else {
        
        NSLog(@"Нет доступа к  iCloud");
    }
}


- (void)LoadFile {
    
    NSMetadataQuery *query = [[NSMetadataQuery alloc] init];
    _query = query;
    [query setSearchScopes:[NSArray arrayWithObject:NSMetadataQueryUbiquitousDocumentsScope]];
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"%K == %@", NSMetadataItemFSNameKey, kFILENAME];
    [query setPredicate:pred];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryDidFinishGathering:) name:NSMetadataQueryDidFinishGatheringNotification object:query];
    
    [query startQuery];
    
    
    [self loadPlist];
    
}

- (void)queryDidFinishGathering:(NSNotification *)notification {
    
    NSMetadataQuery *query = [notification object];
    [query disableUpdates];
    [query stopQuery];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSMetadataQueryDidFinishGatheringNotification object:query];
    
    _query = nil;
    
}

- (void)loadPlist {
    
    //ищем путь к папке Documents
    NSString *myFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    myFilePath = [myFilePath stringByAppendingPathComponent:@"CreditList.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //ищем путь к контейнеру 
    NSString *fileName = [NSString stringWithFormat:@"CreditList.plist"];
    NSURL *ubiq = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    NSURL *ubiquitousPackage = [[ubiq URLByAppendingPathComponent:@"Documents"] URLByAppendingPathComponent:fileName];
    NSString *convertedURL= [ubiquitousPackage path];

    


    
    
    // если данные в iCloud есть - копируем их в наш каталог
     if ([fileManager fileExistsAtPath:convertedURL]) {
    
         [fileManager removeItemAtPath:myFilePath error:nil];
         [fileManager copyItemAtPath:convertedURL toPath:myFilePath error:nil];
         
      //   NSLog(@"Данные обновлены");
     }
     else
     {
         NSLog(@"Нет данных в iCloud!!!");
         
         if (![fileManager fileExistsAtPath:myFilePath]) {
             NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"CreditList" ofType:@"plist"];
            [fileManager copyItemAtPath:sourcePath toPath:myFilePath error:nil];
            [fileManager copyItemAtPath:myFilePath toPath:convertedURL error:nil];
         }
     }
    
    
    if ([fileManager fileExistsAtPath:myFilePath]) {
    
    [self LoadCredits];
 //   NSLog(@"Пошла загрузка дальше");
    } 
}



-(void)LoadCredits {
    
        NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //если файл Creditlist отсутствует, копируем его из ресурсов проекта
    NSString *myFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    myFilePath = [myFilePath stringByAppendingPathComponent:@"CreditList.plist"];

    if (![fileManager fileExistsAtPath:myFilePath]) {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"CreditList" ofType:@"plist"];
        [fileManager copyItemAtPath:sourcePath toPath:myFilePath error:nil];
    }

    //загружаем информацию о кредитах в Массив без размера Credits
    [SingletonClass sharedInstance].Credits = [[NSMutableArray alloc] initWithContentsOfFile:myFilePath];
    if  (![SingletonClass sharedInstance].Credits) {
        NSLog(@"Не загружено!!!");
        
       
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
