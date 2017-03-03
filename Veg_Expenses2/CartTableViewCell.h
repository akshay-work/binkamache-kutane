//
//  CartTableViewCell.h
//  Veg_Expenses2
//
//  Created by Anveshak on 28/11/1938 Saka.
//  Copyright © 1938 Saka Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *namelbl;
@property (strong, nonatomic) IBOutlet UILabel *datelbl;
@property (strong, nonatomic) IBOutlet UILabel *pricelbl;
@property (strong, nonatomic) IBOutlet UILabel *quantitylbl;

@property (strong, nonatomic) IBOutlet UIButton *cancelbtn;

@property (strong, nonatomic) IBOutlet UILabel *daylbl;

@property (strong, nonatomic) IBOutlet UILabel *monthlbl;

@property (strong, nonatomic) IBOutlet UILabel *yearlbl;

@property (strong, nonatomic) IBOutlet UILabel *ratelbl;


@end
