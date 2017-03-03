//
//  EditViewController.h
//  Fuel_Expenses
//
//  Created by Anveshak on 25/11/1938 Saka.
//  Copyright © 1938 Saka Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *vtext;
@property (strong, nonatomic) IBOutlet UITextField *ptext;
@property(nonatomic,retain)NSString *temp1,*temp2,*temp3,*temp4,*temp5;

- (IBAction)updtbtn:(id)sender;


@end
