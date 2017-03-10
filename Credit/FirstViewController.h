//
//  FirstViewController.h
//  Credit
//
//  Created by Sergey Silak on 20.06.14.
//  Copyright (c) 2014 Sergey Silak. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController :  UIViewController <UITextFieldDelegate> {
    UILabel *Platezh_,*Procent_,*LabelPlatezh,*LabelProcent,*labelFirstConvert, *Typelabel_;
    IBOutlet UITextField *FieldName_;
    IBOutlet UITextField *FieldSumm_;
    IBOutlet UITextField *FieldProcent_;
    IBOutlet UITextField *FieldSrok_;
    IBOutlet UITextField *FieldFirst_;
    float fieldSumm_fl, fieldProcent_fl, fieldSrok_fl, fieldFirst_fl;
    int segmentSelector,segmentSelectorFirstPay,counter;
    UIStepper *stepSrok_, *stepProcent_;
    UISegmentedControl *metodRaschet,*metodFirstPay;
}


@property (retain, nonatomic) IBOutlet UILabel *Procent;
@property (retain, nonatomic) IBOutlet UILabel *Platezh;
@property (retain, nonatomic) IBOutlet UITextField *FieldName;
@property (retain, nonatomic) IBOutlet UITextField *FieldSumm;
@property (retain, nonatomic) IBOutlet UITextField *FieldProcent;
@property (retain, nonatomic) IBOutlet UITextField *FieldSrok;
@property (retain, nonatomic) IBOutlet UITextField *FieldFirst;
@property (retain, nonatomic) IBOutlet UIStepper *stepSrok;
@property (strong, nonatomic) IBOutlet UILabel *labelPlatezh;
@property (strong, nonatomic) IBOutlet UISegmentedControl *metodRaschet;
@property (strong, nonatomic) IBOutlet UILabel *LabelProcent;
@property (strong, nonatomic) IBOutlet UISegmentedControl *metodFirstPay;
@property (strong, nonatomic) IBOutlet UILabel *labelFirstConvert;
@property (retain, nonatomic) IBOutlet UIStepper *stepProcent;
@property (strong, nonatomic) IBOutlet UILabel *labelMax;
@property (strong, nonatomic) IBOutlet UIButton *buttonRaschet;
@property (strong, nonatomic) IBOutlet UIButton *buttonSave;
@property (strong, nonatomic) IBOutlet UIButton *buttonHelp;

@property (strong, nonatomic) IBOutlet UILabel *Typelabel;











- (IBAction)Raschet:(id)sender;
- (IBAction)stepSrok:(id)sender;
- (IBAction)metodRaschet:(id)sender;
- (IBAction)metodFirstPay:(id)sender;
- (IBAction)stepProcent:(id)sender;
- (IBAction)Save:(id)sender;
- (IBAction)buttonHelp:(id)sender;


@end
