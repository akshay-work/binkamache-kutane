//
//  FuelViewController.m
//  Fuel_Expenses
//
//  Created by Anveshak on 24/11/1938 Saka.
//  Copyright © 1938 Saka Anveshak. All rights reserved.
//

#import "FuelViewController.h"
#import "ChangePriceViewController.h"
#import <sqlite3.h>

@interface FuelViewController ()

@end

@implementation FuelViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    _montharray=[[NSMutableArray alloc]initWithObjects:@"Jan",@"Feb",@"Mar",@"April",@"May",@"June",@"July",@"Aug",@"Sept",@"Oct",@"Nov",@"Dec",nil];
    UIPickerView *mpickerview=[[UIPickerView alloc]init];
    mpickerview.delegate=self;
    mpickerview.showsSelectionIndicator=YES;
    [mpickerview selectRow:0 inComponent:0 animated:YES];
    [_monthtext setInputView:mpickerview];
    
    [_daytext setKeyboardType:UIKeyboardTypeNumberPad];
    [_yeartext setKeyboardType:UIKeyboardTypeNumberPad];
    [_ratetextf setDelegate:self];
    [_volrstext setDelegate:self];
    [_daytext setDelegate:self];
    [_yeartext setDelegate:self];
    [_voltext setDelegate:self];
    [_ratetextf setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [_volrstext setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [_voltext setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];

    
    
    
//    [_dtpicker addTarget:self action:@selector(selectdate:) forControlEvents:UIControlEventValueChanged];
//    _dtpicker.datePickerMode=UIDatePickerModeDate;


    NSArray *dir=  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbpath=[NSString stringWithFormat:@"%@/Fueldb2.sqlite",[dir lastObject]];
    NSLog(@"%@",dbpath);
    NSFileManager *f=[[NSFileManager alloc]init];
    if([f fileExistsAtPath:dbpath])
    {
        NSLog(@"database alreay present");
        return;
    }
    sqlite3 *db;
    if( sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
    {
        const char * query=" create table fuel (vol integer , price integer , dayd integer , monthd varchar(10) , yeard integer)";
        
        if(sqlite3_exec(db,query,NULL,NULL,NULL)==SQLITE_OK)
        {
            NSLog(@"table created");
        }
        else
        {
            NSLog(@"fail to create table");
        }
    }
    else
    {
        NSLog(@"fail to open database");
    }
    
    sqlite3_close(db);
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _montharray.count;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    NSString * nameInRow;
    nameInRow=[_montharray objectAtIndex:row];
    
    
    return nameInRow;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    _monthtext.text=[_montharray objectAtIndex:row];
}







//-(void)selectdate:(UIDatePicker *)sender
//{
//    NSLog(@"hii");
//    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"dd/MMM/YYYY"];
//    _datestr=[NSString stringWithFormat:@"%@",[formatter stringFromDate:_dtpicker.date]];
//    NSLog(@"%@",_datestr);
//    
//    
//}



-(void)senddata:(NSString *)str
{
    [self.pricelbl setText:str];
    NSLog(@"%@",str);
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier]isEqualToString:@"bbb"])
    {
      ChangePriceViewController *c=[segue destinationViewController];
        c.delegate=self;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitbtn:(id)sender {
    
    
    if([_daytext.text isEqual:@"00"])
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Failed" message:@"Plese Select The Date" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        

    }
    
   else if([_ratetextf.text isEqual:@"0"])
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Failed" message:@"Plese Insert Rate" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }

    else if ([_voltext.text isEqual:@""])
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Failed" message:@"Plese Insert Volume" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if([_voltext.text isEqual:@"0.00"])
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Failed" message:@"Plese Insert Volume" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
       
    else
    {
    NSArray *dir=  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbpath=[NSString stringWithFormat:@"%@/Fueldb2.sqlite",[dir lastObject]];
    sqlite3 *db;
    if( sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
    {
        NSString *insertquery=[NSString stringWithFormat:@"insert into fuel values(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",_voltext.text,_ratetextf.text,_daytext.text,_monthtext.text,_yeartext.text];
        NSLog(@"%@",insertquery);
        if(sqlite3_exec(db,[insertquery UTF8String],NULL,NULL,NULL)==SQLITE_OK)
        {
            NSLog(@"record inserted");
            _voltext.text=@"";
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Success" message:@"Record Submited Successfully" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alert dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            NSLog(@"fail to insert record");
        }
    }
    sqlite3_close(db);
    
    }
    
}
- (IBAction)calculatebtn:(id)sender {
    
    NSString *ratestr=_ratetextf.text;
    NSString *volrs=_volrstext.text;
    
    float f1=[ratestr floatValue];
    float f2=[volrs floatValue];
    
    float f3=f2/f1;
    
    _voltext.text=[NSString stringWithFormat:@"%.2f",f3];
    
    [self textFieldShouldReturn:_volrstext];
    
}
@end
