//
//  HelpViewController.h
//  Credit
//
//  Created by Sergey Silak on 13.08.14.
//  Copyright (c) 2014 Sergey Silak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpViewController : UIViewController {
    UITextView *HelpTextView_;
}


@property (strong, nonatomic) IBOutlet UITextView *HelpTextView;
@property (strong, nonatomic) IBOutlet UIButton *buttonClose;
- (IBAction)buttonClose:(id)sender;

@end
