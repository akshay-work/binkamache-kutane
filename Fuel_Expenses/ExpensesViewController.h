//
//  ExpensesViewController.h
//  Fuel_Expenses
//
//  Created by Anveshak on 25/11/1938 Saka.
//  Copyright © 1938 Saka Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpensesViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *totalfuel;
@property (strong, nonatomic) IBOutlet UILabel *fuelavg;

@property (strong, nonatomic) IBOutlet UILabel *totalprice;
@property (strong, nonatomic) IBOutlet UILabel *priceavg;

@property(nonatomic,retain)NSMutableArray *parray,*varray,*daaray,*temparray,*daytotalarr;

@property (nonatomic,retain)NSString *monthstr;
- (IBAction)segmchnge:(id)sender;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segm;

@property (strong, nonatomic) IBOutlet UITextField *frmtext;
@property (strong, nonatomic) IBOutlet UITextField *totext;


- (IBAction)showbtn:(id)sender;

@end
