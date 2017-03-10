//
//  FirstViewController.m
//  Credit
//
//  Created by Sergey Silak on 20.06.14.
//  Copyright (c) 2014 Sergey Silak. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "SaveDetailViewController.h"
#import "HelpViewController.h"
#import "SaveConstants.h"
#import "SingletonClass.h"

@interface FirstViewController ()


@end

@implementation FirstViewController
@synthesize Platezh=Platezh_;
@synthesize Procent=Procent_;
@synthesize FieldSumm=FieldSumm_;
@synthesize FieldProcent=FieldProcent_;
@synthesize FieldSrok=FieldSrok_;
@synthesize FieldFirst=FieldFirst_;
@synthesize stepSrok=stepSrok_;
@synthesize labelPlatezh=LabelPlatezh_;
@synthesize LabelProcent=LabelProcent_;
@synthesize metodRaschet=metodRaschet_;
@synthesize metodFirstPay=metodFirstPay_;
@synthesize labelFirstConvert=labelFirstConvert_;
@synthesize buttonRaschet=buttonRaschet_;
@synthesize stepProcent=stepProcent_;
@synthesize labelMax=labelMax_;
@synthesize Typelabel=Typelabel_;
@synthesize FieldName=FieldName_;






//Ограничение ввода текстовые поля -только цифры
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *decimalSeperator;

    NSString *localeID = ( [[NSLocale currentLocale] localeIdentifier]);
//    NSLog (@"  : %@", localeID);
    

    if ([localeID  isEqual: @"ru_RU"])
    {
//        NSLog (@"Локаль  : %@", localeID);
        decimalSeperator = @",";}
    else
    {
        decimalSeperator = @".";
    }

    
    NSString *text = textField.text;
    NSCharacterSet *charSet = nil;
    NSString *numberChars = @"0123456789";
    
    static NSNumberFormatter *numberFormatter;

 
    if (!numberFormatter) {
        numberFormatter = [[NSNumberFormatter alloc] init];


 //       [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];

    
        numberFormatter.maximumFractionDigits = 10;
        numberFormatter.minimumFractionDigits = 0;
        numberFormatter.decimalSeparator = decimalSeperator;
        numberFormatter.usesGroupingSeparator = NO; }
    
    
    NSRange decimalRange = [text rangeOfString:decimalSeperator];
    
    
    BOOL isDecimalNumber = (decimalRange.location != NSNotFound);
    
    if (isDecimalNumber) { charSet = [NSCharacterSet characterSetWithCharactersInString:numberChars];
    }
    
    else { numberChars = [numberChars stringByAppendingString:decimalSeperator];
        charSet = [NSCharacterSet characterSetWithCharactersInString:numberChars]; }
    
    NSCharacterSet *invertedCharSet = [charSet invertedSet];
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:invertedCharSet];
    text = [text stringByReplacingCharactersInRange:range withString:trimmedString];
    
    
    if ([string isEqualToString:decimalSeperator] == YES) {
        
        textField.text = text; }
    
    else {
        
        NSNumber *number = [numberFormatter numberFromString:text];
        
        if (number == nil) {
            
            number = [NSNumber numberWithInt:0];
            
        }
        
        textField.text = isDecimalNumber ? text : [numberFormatter stringFromNumber:number];
     
    }
    
    return NO;

}






//Расчет
- (IBAction)Raschet:(id)sender {
    
    labelMax_.hidden=YES;
    
    
    NSString* Summ = FieldSumm_.text;
    fieldSumm_fl = [Summ floatValue];
    
    NSString* Procent = FieldProcent_.text;
    fieldProcent_fl = [Procent floatValue];
    
    
    NSString* Srok = FieldSrok_.text;
    fieldSrok_fl = [Srok floatValue];
    
    NSString* First = FieldFirst_.text;
    fieldFirst_fl = [First floatValue];
    
    
    if (fieldSumm_fl>0.00) {
        if (fieldProcent_fl>0.00) {
            if (fieldSrok_fl>0.00) {
                
                
                
                //первый взнос
                //если селектор на процентах-рассчитать процент от общей суммы
                if (segmentSelectorFirstPay==1){
                    
                    fieldFirst_fl=fieldSumm_fl*fieldFirst_fl/100;
                    NSString* First_int= [NSString stringWithFormat:@"%0.2f",fieldFirst_fl];
                    labelFirstConvert_.text=First_int;
                }
                else {
                    labelFirstConvert_.text=FieldFirst_.text;
                    
                }
                
                fieldSumm_fl=fieldSumm_fl-fieldFirst_fl;
                
                if (segmentSelector==0) {
                    
                
                    
                    Procent_.hidden=NO;
                    LabelProcent_.hidden=NO;
                    
                    
                    //ануитентный платеж
                    //=(сумма кредита×(Процентная ставка÷1200))÷(1−(1+(Процентная ставка÷1200))^(1−(Срок кредита+1)))
                    float RaschetSumm=fieldSumm_fl*fieldProcent_fl/1200/(1-powf((1+fieldProcent_fl/1200),-fieldSrok_fl));
                    
                    
                    //расчет процентов
                    float RaschetProcent=RaschetSumm*fieldSrok_fl-fieldSumm_fl;
                    
                    NSString* Platezh_Summ= [NSString stringWithFormat:@"%.2f",RaschetSumm];
                    NSString* Platezh_Procent= [NSString stringWithFormat:@"%.2f",RaschetProcent];
                    
                    Platezh_.text=Platezh_Summ;
                    Procent_.text=Platezh_Procent;
                }
                
                else {
                    
                    //дифференцированный платеж
                    labelMax_.hidden=NO;
                    
                    
                    //месячный платеж без процентов
                    float RaschetSumm=fieldSumm_fl/fieldSrok_fl;
                    
                    
                    //Месячный платеж + проценты
                    float RaschetAll=RaschetSumm+fieldSumm_fl*fieldProcent_fl/1200;
                    
                    //Проценты
                    //         float RaschetProcent=fieldSumm_fl*fieldProcent_fl/1200*fieldSrok_fl;
                    
                    NSString* Platezh_Summ= [NSString stringWithFormat:@"%.2f",RaschetAll];
                    //        NSString* Platezh_Procent= [NSString stringWithFormat:@"%.2f",RaschetProcent];
                    
                    Platezh_.text=Platezh_Summ;
                    Procent_.hidden=YES;
                    Procent_.text=@"";
                    LabelProcent_.hidden=YES;
                }
            }
            else
                
            { UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Title of AlertView")message:NSLocalizedString(@"Loan term must be > 0", nil)  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                Platezh_.text=@"";
                Procent_.text=@"";}
        }
        else
            
            
            
        {UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Title of AlertView")message:NSLocalizedString(@"Interest rate must be > 0",nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            Platezh_.text=@"";
            Procent_.text=@"";}
    }
    else
        
        
    {UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Title of AlertView")message:NSLocalizedString(@"Amount of loan must be > 0",nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        Platezh_.text=@"";
        Procent_.text=@"";
    }
}

-(IBAction)metodRaschet:(id)sender{
	if(metodRaschet_.selectedSegmentIndex == 0){
        segmentSelector=0;
	}
	if(metodRaschet_.selectedSegmentIndex == 1){
        segmentSelector=1;
	}
}


//Первый взнос- % или сумма
- (IBAction)metodFirstPay:(id)sender {
    if(metodFirstPay_.selectedSegmentIndex == 0){
        segmentSelectorFirstPay=0;
	}
	if(metodFirstPay_.selectedSegmentIndex == 1){
        segmentSelectorFirstPay=1;
	}
}

- (IBAction)stepProcent:(id)sender {
    self.stepProcent.wraps=NO;
    self.stepProcent.autorepeat=YES;
    NSUInteger value =self.stepProcent.value;
    self.FieldProcent.text = [NSString stringWithFormat:@"%.1lu", (unsigned long)value];
    self.stepProcent.maximumValue = 100;
    
    
}

//Сохранить расчет
-(IBAction)Save:(id)sender {
    
    if ([FieldName_.text isEqualToString:@""]) {
        FieldName_.text = FieldSumm_.text;
    }
    
    
    if ([Platezh_.text isEqualToString:@""]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(nil, nil)message:NSLocalizedString(@"Perform the calculation, please", nil)  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else {
  
    NSMutableDictionary *newSave = [[NSMutableDictionary alloc] init];
    
    if (segmentSelector==0) {
        
        Typelabel_.text =  NSLocalizedString(@"Annuitet", nil);}

        else {
            
        Typelabel_.text =  NSLocalizedString(@"Different", nil);
    
        }
    
    
    
        [newSave setValue:self.FieldName.text  forKey:NAME_KEY];
        [newSave setValue:self.FieldSumm.text forKey:AMOUNT_KEY];
        [newSave setValue:self.FieldProcent.text forKey:RATE_KEY];
        [newSave setValue:self.FieldSrok.text forKey:TERM_KEY];
        [newSave setValue:self.labelFirstConvert.text forKey:FIRSTPAY_KEY];
        [newSave setValue:self.Platezh.text forKey:MONTHLYPAY_KEY];
        [newSave setValue:self.Procent.text forKey:PERCENTPAY_KEY];
        [newSave setValue:Typelabel_.text forKey:TYPE_KEY];

    // добавляем новую запись в созданный массив
    [[SingletonClass sharedInstance].Credits addObject:newSave];

    
 {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(nil, nil)message:NSLocalizedString(@"Saved", nil)  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        }
    }
}

- (IBAction)buttonHelp:(id)sender {
    
}

- (IBAction)stepSrok:(id)sender {
    
    self.stepSrok.wraps = NO;
    self.stepSrok.autorepeat = YES;
    NSUInteger value =self.stepSrok.value;
    self.FieldSrok.text = [NSString stringWithFormat:@"%01lu", (unsigned long)value];
    self.stepSrok.maximumValue = 1200;
    
}


//Убрать клавиатуру с экрана, при нажатии на пустое поле
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.FieldSumm resignFirstResponder];
    [self.FieldProcent resignFirstResponder];
    [self.FieldSrok resignFirstResponder];
    [self.FieldFirst resignFirstResponder];
    [self.FieldName resignFirstResponder];
}

-(void)applicationDidEnterBackground: (NSNotification *) notification {
    
    NSError *error;
    NSString *myFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    myFilePath = [myFilePath stringByAppendingPathComponent:@"CreditList.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];


    // сохраняем
    [[SingletonClass sharedInstance].Credits writeToFile:myFilePath atomically:YES];
    
    BOOL success = [[SingletonClass sharedInstance].Credits writeToFile:myFilePath atomically:(YES)];
    if(!success){
        NSLog(@"НЕ СОХРАНЕНО!!!");
    }
    else{
        NSLog(@"Сохранено");
    }
    
    // копируем в iCloud (если переключать стоит на iCloud ON
    NSString *myFilePathSettings = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    myFilePathSettings = [myFilePathSettings stringByAppendingPathComponent:@"Settings.plist"];
    NSMutableDictionary *settingiCloud = [[NSMutableDictionary alloc] initWithContentsOfFile:myFilePathSettings];
    
    NSString  *iCloudIDStr  = [settingiCloud objectForKey:iCloudID_KEY];
    
    if ([iCloudIDStr isEqualToString:@"ON"])   {
        
        NSString *fileName = [NSString stringWithFormat:@"CreditList.plist"];
        
        NSURL *ubiq = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
        NSURL *ubiquitousPackage = [[ubiq URLByAppendingPathComponent:@"Documents"] URLByAppendingPathComponent:fileName];
        
        NSString *convertedURL= [ubiquitousPackage path];
        
        [fileManager removeItemAtURL:ubiquitousPackage error:&error];
        BOOL success =  [fileManager copyItemAtPath:myFilePath toPath:convertedURL error:&error];
        if (!success) {
        NSLog(@"НЕ сохранено в iCloud");
        }
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler)];
    [swipeUp setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self.view addGestureRecognizer:swipeUp];
    
}


- (void)viewDidLoad
{
    //загружается форма
    
    [super viewDidLoad];
    

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:)  name:UIApplicationDidEnterBackgroundNotification object:nil];
    

    }
        


-(void)swipeHandler{
    FieldName_.text = NSLocalizedString(@"Name of loan", nil);
    FieldSumm_.text = @"";
    FieldSrok_.text = @"";
    FieldProcent_.text = @"";
    FieldFirst_.text = @"0.00";
    Procent_.text = @"";
    Platezh_.text = @"";
    labelFirstConvert_.text = @"";
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end