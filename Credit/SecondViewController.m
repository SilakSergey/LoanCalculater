//
//  SecondViewController.m
//  Credit
//
//  Created by Sergey Silak on 20.06.14.
//  Copyright (c) 2014 Sergey Silak. All rights reserved.
//


#import "SecondViewController.h"
#import "SaveConstants.h"
#import "SaveDetailViewController.h"
#import "SingletonClass.h"
#import "AppDelegate.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize buttoniCloud=_buttoniCloud;


#pragma mark -
#pragma mark View lifecycle




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem=self.editButtonItem;
    
    }






 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
     


   [self.tableView reloadData];
   
     
     NSString *myFilePathSettings = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
     myFilePathSettings = [myFilePathSettings stringByAppendingPathComponent:@"Settings.plist"];
     NSMutableDictionary *settingiCloud = [[NSMutableDictionary alloc] initWithContentsOfFile:myFilePathSettings];
     
     NSString  *iCloudIDStr  = [settingiCloud objectForKey:iCloudID_KEY];
     
     if ([iCloudIDStr isEqualToString:@"ON"])   {
         
         _buttoniCloud.enabled =YES;
        
     } else {
         _buttoniCloud.enabled = NO;
        }
      }



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[SingletonClass sharedInstance].Credits count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	cell.textLabel.text = [[[SingletonClass sharedInstance].Credits objectAtIndex:indexPath.row] objectForKey:NAME_KEY];
    cell.detailTextLabel.text = [[[SingletonClass sharedInstance].Credits objectAtIndex:indexPath.row] objectForKey:AMOUNT_KEY];
	return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


-(void) tableView: (UITableView *) tableView moveRowAtIndexPath: (NSIndexPath *)oldPath toIndexPath:(NSIndexPath *) newPath
{

    NSString *title = [[SingletonClass sharedInstance].Credits objectAtIndex:[oldPath row]];
    [[SingletonClass sharedInstance].Credits removeObjectAtIndex:[oldPath row]];
    [[SingletonClass sharedInstance].Credits insertObject:title atIndex:[newPath row]];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowDetails"]) {
      SaveDetailViewController *savedetailViewController   = [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        int row = [myIndexPath row];
        
        savedetailViewController.Credit = [NSMutableDictionary alloc];
        savedetailViewController.Credit = [[SingletonClass sharedInstance].Credits objectAtIndex:row];
    }
}


-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle==UITableViewCellEditingStyleDelete)
        [[SingletonClass sharedInstance].Credits removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
        withRowAnimation:UITableViewRowAnimationFade];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];

}

- (void)viewDidUnload {
   }




- (IBAction)buttoniCloud:(id)sender {
    
    
    AppDelegate *object = [[AppDelegate alloc] init];
    [object loadiCloud];
    
    [self.tableView reloadData];

}
@end

