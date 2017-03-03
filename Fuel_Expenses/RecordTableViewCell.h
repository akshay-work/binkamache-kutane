//
//  RecordTableViewCell.h
//  Fuel_Expenses
//
//  Created by Anveshak on 24/11/1938 Saka.
//  Copyright © 1938 Saka Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *pricelabel;

@property (strong, nonatomic) IBOutlet UILabel *volumelabel;
@property (strong, nonatomic) IBOutlet UILabel *daytotal;
//@property (strong, nonatomic) IBOutlet UILabel *datelbl;
- (IBAction)editbtn:(id)sender;
- (IBAction)deletebtn:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *daylbl;

@property (strong, nonatomic) IBOutlet UILabel *monthlbl;
@property (strong, nonatomic) IBOutlet UILabel *yearlbl;


@end
