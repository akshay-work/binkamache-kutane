//
//  ChangePriceViewController.h
//  Fuel_Expenses
//
//  Created by Anveshak on 24/11/1938 Saka.
//  Copyright © 1938 Saka Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol senddataprotocol <NSObject>
-(void)senddata:(NSString *)str;
@end

@interface ChangePriceViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *pricetext;
@property(nonatomic,retain)NSString *tempstr;
- (IBAction)sbtn:(id)sender;
@property(nonatomic,assign)id delegate;
- (IBAction)chngeseg:(id)sender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *seg;

@end
