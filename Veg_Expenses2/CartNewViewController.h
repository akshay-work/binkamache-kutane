//
//  CartNewViewController.h
//  Veg_Expenses2
//
//  Created by Anveshak on 21/02/2017 .
//  Copyright © 1938 Saka Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartNewViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate>


@property(nonatomic,retain)NSMutableArray *namearr,*quantarr,*pricearr,*dayarr,*montharr,*yeararr,*yeararr2,*totalparr;
@property(nonatomic,retain)NSString *tempnamestr,*tempdaystr,*tempmonthstr,*tempyearstr,*temppricestr,*tempquantitystr;
@property(nonatomic,retain)NSString *mstr;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segm;

@property (strong, nonatomic) IBOutlet UITextField *yeartextf;

- (IBAction)segmchnge:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) IBOutlet UITextField *frmtext;
@property (strong, nonatomic) IBOutlet UITextField *totext;
- (IBAction)showbtn:(id)sender;
- (IBAction)deletebtn:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *vegetotallabel;
@property (strong, nonatomic) IBOutlet UILabel *pricetotallabel;
@property(nonatomic,retain)UIPickerView *yearpickerv;
@end
