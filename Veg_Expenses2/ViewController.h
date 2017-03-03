//
//  ViewController.h
//  Veg_Expenses2
//
//  Created by Anveshak on 27/11/1938 Saka.
//  Copyright © 1938 Saka Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIDatePicker *dtpicker;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,retain)NSMutableArray *namearr,*pricearr,*quantityarr,*monthsarray,*dayarr,*yeararr,*selectedmenu;
@property(nonatomic,retain)NSString *dtstr,*namestr,*pricestr,*quantitystr;
@property(nonatomic,retain)NSCalendar *currentdatecompontnt;
- (IBAction)editbtn:(id)sender;
- (IBAction)buybtn:(id)sender;

@property(nonatomic,retain)UIPickerView *mpickerview,*dpickerview,*ypickerview;

@property (strong, nonatomic) IBOutlet UITextField *daytextf;

@property (strong, nonatomic) IBOutlet UITextField *monthtextf;
@property (strong, nonatomic) IBOutlet UITextField *yeartextf;


@end

