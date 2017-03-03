//
//  FuelViewController.h
//  Fuel_Expenses
//
//  Created by Anveshak on 24/11/1938 Saka.
//  Copyright © 1938 Saka Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangePriceViewController.h"

@interface FuelViewController : UIViewController<senddataprotocol,UIPickerViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIDatePicker *dtpicker;
@property (strong, nonatomic) IBOutlet UITextField *voltext;
@property (strong, nonatomic) IBOutlet UILabel *pricelbl;
@property(nonatomic,retain)NSString *temp;
@property(nonatomic,retain)NSString *datestr;
- (IBAction)submitbtn:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *daytext;
@property (strong, nonatomic) IBOutlet UITextField *monthtext;
@property (strong, nonatomic) IBOutlet UITextField *yeartext;
@property(nonatomic,retain)NSMutableArray *montharray;

- (IBAction)calculatebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *volrstext;
@property (strong, nonatomic) IBOutlet UITextField *ratetextf;



@end
