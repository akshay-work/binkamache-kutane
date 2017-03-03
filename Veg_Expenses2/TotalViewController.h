//
//  TotalViewController.h
//  Veg_Expenses2
//
//  Created by Anveshak on 21/02/2017 .
//  Copyright © 1938 Saka Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TotalViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *quantitylbl;

@property (strong, nonatomic) IBOutlet UILabel *pricelbl;
@property(nonatomic,retain)NSMutableArray *parr,*qarr,*totalarr;
@property(nonatomic,retain)NSString *mstr;
@property (strong, nonatomic) IBOutlet UILabel *monlbl;
@property(nonatomic,retain)NSString *temp1,*temp2,*temp3;
@end
