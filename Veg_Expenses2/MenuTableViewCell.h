//
//  MenuTableViewCell.h
//  Veg_Expenses2
//
//  Created by Anveshak on 27/11/1938 Saka.
//  Copyright © 1938 Saka Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *namelbl;
@property (strong, nonatomic) IBOutlet UITextField *quantitytext;
@property (strong, nonatomic) IBOutlet UITextField *pricetext;

@property (strong, nonatomic) IBOutlet UIButton *bbtn;




@end
