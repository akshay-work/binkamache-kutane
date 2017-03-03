//
//  RecordTableViewController.h
//  Fuel_Expenses
//
//  Created by Anveshak on 24/11/1938 Saka.
//  Copyright © 1938 Saka Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordTableViewController : UITableViewController<UIAlertViewDelegate>


@property(nonatomic,retain)NSMutableArray *pricearray,*volarray,*dtotalarray,*totalarray,*dayarr,*montharr,*yeararr;
@property(nonatomic,retain)NSString *celltext1,*celltext2,*celltext3,*celltext4,*celltext5,*mstr;
- (IBAction)edtbtn:(id)sender;
- (IBAction)dltbtn:(id)sender;


@property (strong, nonatomic) IBOutlet UISegmentedControl *segmnt1;
- (IBAction)segselect:(id)sender;


@end
