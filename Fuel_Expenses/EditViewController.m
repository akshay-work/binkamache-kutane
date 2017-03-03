//
//  EditViewController.m
//  Fuel_Expenses
//
//  Created by Anveshak on 25/11/1938 Saka.
//  Copyright © 1938 Saka Anveshak. All rights reserved.
//

#import "EditViewController.h"
#import <sqlite3.h>

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _vtext.text=_temp2;
    _ptext.text=_temp3;
    [_ptext setDelegate:self];
    [_vtext setDelegate:self];
    NSLog(@"%@  %@",_temp3,_temp2);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)updtbtn:(id)sender {
    
    
    
    NSArray *dir=  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbpath=[NSString stringWithFormat:@"%@/Fueldb2.sqlite",[dir lastObject]];
    
    sqlite3 *db;
    
    
    if( sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
    {
        NSString *query=[NSString stringWithFormat:@"update fuel set vol=\"%@\",price=\"%@\" where dayd=\"%@\" AND monthd=\"%@\" AND yeard=\"%@\" ",_vtext.text,_ptext.text,_temp1,_temp4,_temp5];
        
        if(sqlite3_exec(db,[query UTF8String],NULL,NULL,NULL)==SQLITE_OK)
        {
            NSLog(@"updated");
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Update" message:@"Record Updated Successfully" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alert dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];

            
        }
        else
        {
            NSLog(@"fail to update");
        }
    }
    
    sqlite3_close(db);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
