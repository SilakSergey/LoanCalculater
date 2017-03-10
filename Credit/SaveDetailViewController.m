//
//  SaveDetailViewController.m
//  Credit
//
//  Created by Sergey Silak on 21.06.14.
//  Copyright (c) 2014 Sergey Silak. All rights reserved.
//

#import "SaveDetailViewController.h"
#import "SaveConstants.h"
#import "DetailTableViewCell.h"
#import "FirstViewController.h"
#import <MessageUI/MessageUI.h>




@interface SaveDetailViewController ()
{
    CGSize *pageSize;
}


@end

@implementation SaveDetailViewController

@synthesize nameField=nameField_,typeField=typeField_,amountField=amountField_,rateField=rateField_,termField=termField_,firstpayField=firstpayField_,monthlypayField=monthlypayField_,percentField=percentField_,Credit=Credit_,myView=myView_,S_Amount=S_Amount_,S_First=S_First_,S_Monthly=S_Monthly_,S_Percent=S_Percent_,S_Rate=S_Rate_,S_Term=S_Term_,S_Type=S_Type_,T_N=T_N_,T_Balans=T_Balans_,T_Payment=T_Payment_,T_Interest=T_Interest_,T_Transfer=T_Transfer_,ArrayBalans=_ArrayBalans,ArrayN=_ArrayN;



- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

    NSString *myFilePathSettings = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    myFilePathSettings = [myFilePathSettings stringByAppendingPathComponent:@"Settings.plist"];
    
    
    NSMutableDictionary *settingDetails = [[NSMutableDictionary alloc] initWithContentsOfFile:myFilePathSettings];
    NSString  *DetailsIDStr  = [settingDetails objectForKey:DetailID_KEY];
    
    if ([DetailsIDStr isEqualToString:@"ON"])   {
        
        [self DetailCalculation];

    } else {
        self.nameField.hidden=NO;
        self.typeField.hidden=NO;
        self.amountField.hidden=NO;
        self.rateField.hidden=NO;
        self.termField.hidden=NO;
        self.firstpayField.hidden=NO;
        self.monthlypayField.hidden=NO;
        self.percentField.hidden=NO;
        self.S_Amount.hidden=NO;
        self.S_First.hidden=NO;
        self.S_Monthly.hidden=NO;
        self.S_Percent.hidden=NO;
        self.S_Rate.hidden=NO;
        self.S_Term.hidden=NO;
        self.S_Type.hidden=NO;
        
        self.T_N.hidden=YES;
        self.T_Balans.hidden=YES;
        self.T_Payment.hidden=YES;
        self.T_Interest.hidden=YES;
        self.T_Transfer.hidden=YES;
        
        self.TableDetail.hidden=YES;
    }
        self.nameField.text =       [self.Credit objectForKey:NAME_KEY];
        self.typeField.text =       [self.Credit objectForKey:TYPE_KEY];
        self.amountField.text =     [self.Credit objectForKey:AMOUNT_KEY];
        self.rateField.text =       [self.Credit objectForKey:RATE_KEY];
        self.termField.text =       [self.Credit objectForKey:TERM_KEY];
        self.firstpayField.text =   [self.Credit objectForKey:FIRSTPAY_KEY];
        self.monthlypayField.text = [self.Credit objectForKey:MONTHLYPAY_KEY];
        self.percentField.text =    [self.Credit objectForKey:PERCENTPAY_KEY];
}


-(void)DetailCalculation {
    
    self.nameField.hidden=YES;
    self.typeField.hidden=YES;
    self.amountField.hidden=YES;
    self.rateField.hidden=YES;
    self.termField.hidden=YES;
    self.firstpayField.hidden=YES;
    self.monthlypayField.hidden=YES;
    self.percentField.hidden=YES;
    
    self.S_Amount.hidden=YES;
    self.S_First.hidden=YES;
    self.S_Monthly.hidden=YES;
    self.S_Percent.hidden=YES;
    self.S_Rate.hidden=YES;
    self.S_Term.hidden=YES;
    self.S_Type.hidden=YES;
    
     self.T_N.hidden=NO;
     self.T_Balans.hidden=NO;
     self.T_Payment.hidden=NO;
     self.T_Interest.hidden=NO;
     self.T_Transfer.hidden=NO;

    self.TableDetail.hidden=NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    int NUMBER_OF_ROWS = [self.termField.text intValue];
    
   return NUMBER_OF_ROWS+1;
}



- (UITableViewCell *)tableView:(UITableView *)TableDetail cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int NUMBER_OF_ROWS = [self.termField.text intValue];
    
    TableIdentifier = @"DetailCell";
    DetailTableViewCell *cell = (DetailTableViewCell *)([TableDetail dequeueReusableCellWithIdentifier:TableIdentifier]);
    if (cell == nil)
    {
        NSArray *detailCalc = [[NSBundle mainBundle] loadNibNamed:@"TableCell" owner:self options:nil];
        cell = [detailCalc objectAtIndex:0];
    }
    
    if ([self.typeField.text isEqualToString:NSLocalizedString(@"Annuitet", nil)]) {
        
        //заполняем колонку №№ -OK
        _ArrayN = [[NSMutableArray alloc] initWithCapacity:NUMBER_OF_ROWS+1];
        for (int i=0; i<NUMBER_OF_ROWS+1; i++)
        {
            SaveDetailViewController *item1 = [[SaveDetailViewController alloc] init];
            item1.label = [[NSString alloc] initWithFormat:@"%d", i];
            
            
            [self.ArrayN insertObject:item1 atIndex:i];
        }
        
        SaveDetailViewController *item1 = [self.ArrayN objectAtIndex:indexPath.row];
        cell.S_L_NN.text = item1.label;


        
        //0
        if (_ArrayBalans.count==0){
        
        _ArrayBalans = [[NSMutableArray alloc] initWithCapacity:NUMBER_OF_ROWS+1];
        }
        
        if (indexPath.row==0){
            [_ArrayBalans insertObject:amountField_.text atIndex:0];
        }
        
        if (_ArrayPayment.count==0){
            _ArrayPayment = [[NSMutableArray alloc] initWithCapacity:NUMBER_OF_ROWS+1];
        }
        if (indexPath.row==0){
            [_ArrayPayment insertObject:firstpayField_.text atIndex:0];
        }
        
        if (_ArrayInterest.count==0){
        _ArrayInterest = [[NSMutableArray alloc] initWithCapacity:NUMBER_OF_ROWS+1];
        }
        if (indexPath.row==0){
            [_ArrayInterest insertObject:@"0.00" atIndex:0];
        }
        if (_ArrayTransfer.count==0){
        _ArrayTransfer = [[NSMutableArray alloc] initWithCapacity:NUMBER_OF_ROWS+1];
        }
        if (indexPath.row==0){
            [_ArrayTransfer insertObject:firstpayField_.text atIndex:0];
        }
       
        //заполняем колонку Balans
        
        for (int i=1; i<NUMBER_OF_ROWS+1; i++)
        {
            SaveDetailViewController *item2 = [SaveDetailViewController alloc];
            
            float i1 = [[_ArrayBalans objectAtIndex:i-1] floatValue];
            float i2 = [[_ArrayPayment objectAtIndex:i-1] floatValue];
            float fl_bal = (i1) - (i2);
            
            item2.label = [[NSString alloc] initWithFormat:@"%.2f", fl_bal];
            [_ArrayBalans insertObject:item2.label atIndex:i];
            
            
            
            // расчет колонки Платеж -OK
            SaveDetailViewController *item4 = [SaveDetailViewController alloc];
            float i4 = [[_ArrayBalans objectAtIndex:1] floatValue]*[rateField_.text floatValue]/1200/(1-powf((1+[rateField_.text floatValue]/1200),-NUMBER_OF_ROWS));
            item4.label = [NSString stringWithFormat:@"%.2f",i4];
            
            [_ArrayTransfer insertObject:item4.label atIndex:i];
            
            // расчет колонки Проценты -OK
            SaveDetailViewController *item5 = [SaveDetailViewController alloc];
            float i6 = [rateField_.text floatValue]/12/100*[[_ArrayBalans objectAtIndex:i] floatValue];
            item5.label = [NSString stringWithFormat:@"%.2f",i6];
          
            [_ArrayInterest insertObject:item5.label atIndex:i];
            
            
            // расчет колонки Выплата
            SaveDetailViewController *item3 = [SaveDetailViewController alloc];
            
            float i3 = [[_ArrayTransfer  objectAtIndex:i] floatValue] - [[_ArrayInterest  objectAtIndex:i] floatValue];
            
            item3.label = [NSString stringWithFormat:@"%.2f",i3];
            [_ArrayPayment insertObject:item3.label atIndex:i];

        }

        
          cell.S_L_Balans.text      =  [_ArrayBalans objectAtIndex:indexPath.row];
          cell.S_L_Payment.text     =  [_ArrayPayment objectAtIndex:indexPath.row];
          cell.S_L_Interest.text    =  [_ArrayInterest objectAtIndex:indexPath.row];
          cell.S_L_Transfer.text    =  [_ArrayTransfer objectAtIndex:indexPath.row];
  
    } else {
        // дифференцированный расчет
        
        //заполняем колонку №№ -OK
        _ArrayN = [[NSMutableArray alloc] initWithCapacity:NUMBER_OF_ROWS+1];
        for (int i=0; i<NUMBER_OF_ROWS+1; i++)
        {
            SaveDetailViewController *item1 = [[SaveDetailViewController alloc] init];
            item1.label = [[NSString alloc] initWithFormat:@"%d", i];
            
            
            [self.ArrayN insertObject:item1 atIndex:i];
        }
        
        SaveDetailViewController *item1 = [self.ArrayN objectAtIndex:indexPath.row];
        cell.S_L_NN.text = item1.label;
        
        
        
        
        //0
        if (_ArrayBalans.count==0){
            
            _ArrayBalans = [[NSMutableArray alloc] initWithCapacity:NUMBER_OF_ROWS+1];
        }
        
        if (indexPath.row==0){
            [_ArrayBalans insertObject:amountField_.text atIndex:0];
        }
        
        if (_ArrayPayment.count==0){
            _ArrayPayment = [[NSMutableArray alloc] initWithCapacity:NUMBER_OF_ROWS+1];
        }
        if (indexPath.row==0){
            [_ArrayPayment insertObject:firstpayField_.text atIndex:0];
        }
        
        if (_ArrayInterest.count==0){
            _ArrayInterest = [[NSMutableArray alloc] initWithCapacity:NUMBER_OF_ROWS+1];
        }
        if (indexPath.row==0){
            [_ArrayInterest insertObject:@"0.00" atIndex:0];
        }
        if (_ArrayTransfer.count==0){
            _ArrayTransfer = [[NSMutableArray alloc] initWithCapacity:NUMBER_OF_ROWS+1];
        }
        if (indexPath.row==0){
            [_ArrayTransfer insertObject:firstpayField_.text atIndex:0];
        }

        
        //заполняем колонку Balans
        
        for (int i=1; i<NUMBER_OF_ROWS+1; i++)
        {
            SaveDetailViewController *item2 = [SaveDetailViewController alloc];
            
            float i1 = [[_ArrayBalans objectAtIndex:i-1] floatValue];
            float i2 = [[_ArrayPayment objectAtIndex:i-1] floatValue];
            float fl_bal = (i1) - (i2);
            
            item2.label = [[NSString alloc] initWithFormat:@"%.2f", fl_bal];
            [_ArrayBalans insertObject:item2.label atIndex:i];
            
            
            // расчет колонки Проценты -OK
            SaveDetailViewController *item5 = [SaveDetailViewController alloc];
            float i6 = [rateField_.text floatValue]/12/100*[[_ArrayBalans objectAtIndex:i] floatValue];
            item5.label = [NSString stringWithFormat:@"%.2f",i6];
            
            [_ArrayInterest insertObject:item5.label atIndex:i];
            
            // расчет колонки Выплата
            SaveDetailViewController *item3 = [SaveDetailViewController alloc];
            
            float i3 = [[_ArrayBalans  objectAtIndex:1] floatValue] / [termField_.text floatValue];
            
            item3.label = [NSString stringWithFormat:@"%.2f",i3];
            [_ArrayPayment insertObject:item3.label atIndex:i];
            
            // расчет колонки Платеж -OK
            SaveDetailViewController *item4 = [SaveDetailViewController alloc];
            float i4 = ([[_ArrayInterest objectAtIndex:i] floatValue]+[[_ArrayPayment objectAtIndex:i] floatValue]);
            item4.label = [NSString stringWithFormat:@"%.2f",i4];
            
            [_ArrayTransfer insertObject:item4.label atIndex:i];

            
            
        }
        cell.S_L_Balans.text      =  [_ArrayBalans objectAtIndex:indexPath.row];
        cell.S_L_Payment.text     =  [_ArrayPayment objectAtIndex:indexPath.row];
        cell.S_L_Interest.text    =  [_ArrayInterest objectAtIndex:indexPath.row];
        cell.S_L_Transfer.text    =  [_ArrayTransfer objectAtIndex:indexPath.row];
        
        
   
        
    }
                return cell;
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20;
}


-(void) viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnLoad
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




- (IBAction)menuButton:(id)sender {
    
    
    
    
   
    NSMutableData * pdfData=[NSMutableData data];
    
    NSString *fileName = @"credit.pdf";
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [path objectAtIndex:0];
    NSString *pdfPathWithFileName = [documentDirectory stringByAppendingPathComponent:fileName];
    
    UIGraphicsBeginPDFContextToData(pdfData, self.myView.bounds, nil);
    UIGraphicsBeginPDFPage();
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    
    [myView_.layer renderInContext:pdfContext] ;
    UIGraphicsEndPDFContext();
    
    
    [pdfData writeToFile:pdfPathWithFileName atomically:YES];
    //  NSLog(@"documentDirectoryFileName: %@",pdfPathWithFileName);
    



    UIAlertController * view=   [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Menu" , nil) message:NSLocalizedString(@"Make your choise" , nil) preferredStyle:UIAlertControllerStyleActionSheet];
    
    view.popoverPresentationController.barButtonItem = _menuButton;
    
    UIAlertAction* mail = [UIAlertAction actionWithTitle:NSLocalizedString(@"Send mail" , nil ) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                         {
                             
                             NSString *theMessage = [NSString stringWithFormat:@"%@", nameField_.text ? nameField_.text : @""];
                             
                             
                             if ([MFMailComposeViewController canSendMail]) {
                                 MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
                                 picker.mailComposeDelegate = self;
                                 
                                 //Тема письма - наименование кредита
                                 [picker setSubject:theMessage];
                                 
                                 //Прикрепление файлов к письму
                                 [picker addAttachmentData:pdfData mimeType:@"application/pdf" fileName:@"credit.pdf"];
                                 
                                 NSString *emailBody =  NSLocalizedString( @"Loan payment", nil);
                                 [picker setMessageBody:emailBody isHTML:NO];
                                 
                                 [self presentViewController:picker animated:YES completion:nil];
                                 
                             }
                             

                             
                         }];
    UIAlertAction* print = [UIAlertAction actionWithTitle:NSLocalizedString(@"Print", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {
                                
                                 
                                 // распечатать
                                 NSLog(@"Нажата кнопка Печать");
                                 
                                 UIPrintInteractionController *printer=[UIPrintInteractionController sharedPrintController];
                                 UIPrintInfo *info = [UIPrintInfo printInfo];
                                 info.orientation = UIPrintInfoOrientationPortrait;
                                 info.outputType = UIPrintInfoOutputGeneral;
                                 info.jobName=@"credit.pdf";
                                 info.duplex=UIPrintInfoDuplexLongEdge;
                                 printer.printInfo = info;
                                 printer.showsPageRange=YES;
                                 printer.printingItem=pdfData;
                                 
                                 UIPrintInteractionCompletionHandler completionHandler = ^(UIPrintInteractionController *pic, BOOL completed, NSError *error) {
                                     if (!completed && error)
                                         NSLog(@"FAILED! error = %@",[error localizedDescription]);
                                 };
                                 
                                 
                                 
                                 if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                                
                                     [printer presentFromBarButtonItem:_menuButton animated:YES completionHandler:completionHandler];
                                 }
                                 else {
                                     [printer presentAnimated:YES completionHandler:completionHandler];
                                 }

                                 
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel" , nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];

    
    [view addAction:mail];
    [view addAction:print];
    [view addAction:cancel];
    [self presentViewController:view animated:YES completion:nil];
}



- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error;
{
	[self dismissViewControllerAnimated:NO completion:nil];

}



@end
