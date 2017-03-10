//
//  HelpViewController.m
//  Credit
//
//  Created by Sergey Silak on 13.08.14.
//  Copyright (c) 2014 Sergey Silak. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController
@synthesize HelpTextView=HelpTextView_;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.HelpTextView setEditable:NO];
    [self.HelpTextView setScrollEnabled:NO];
    
    // Set data type to specify URL/link
    [self.HelpTextView setDataDetectorTypes:UIDataDetectorTypeLink];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
@end
