//
//  ViewController.m
//  Veg_Expenses2
//
//  Created by Anveshak on 27/11/1938 Saka.
//  Copyright © 1938 Saka Anveshak. All rights reserved.
//

#import "ViewController.h"
#import "MenuTableViewCell.h"
#include "AppDelegate.h"
#include <sqlite3.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
  
    _namearr=[[NSMutableArray alloc]init];
    
    
    
//    _namearr=[[NSMutableArray alloc]initWithObjects:@"Potato",@"Onion",@"Tomato",@"Bringal",@"Cabbage",@"CauliFlower",@"Palak",@"Methi",@"Garlik",@"Soyabean", nil];
//    _currentdatecompontnt = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];


    _selectedmenu=[[NSMutableArray alloc]init];
    
    
    _monthsarray=[[NSMutableArray alloc]initWithObjects:@"Jan",@"Feb",@"Mar",@"April",@"May",@"June",@"July",@"Aug",@"Sept",@"Oct",@"Nov",@"Dec",nil];
    
    _dayarr=[[NSMutableArray alloc]initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31", nil];
    
    _yeararr=[[NSMutableArray alloc]initWithObjects:@"2016",@"2017",@"2018",@"2019",@"2020",@"2021",@"2022",@"2023",@"2024",@"2025",@"2026",@"2027",@"2028",@"2029",@"2030", nil];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    _mpickerview=[[UIPickerView alloc]init];
    _mpickerview.delegate=self;
    _mpickerview.showsSelectionIndicator=YES;
    [_mpickerview selectRow:0 inComponent:0 animated:YES];
    //mpickerview.tag=1;
    [_monthtextf setInputView:_mpickerview];
    
    _dpickerview=[[UIPickerView alloc]init];
    _dpickerview.delegate=self;
    _dpickerview.showsSelectionIndicator=YES;
    [_dpickerview selectRow:0 inComponent:0 animated:YES];
    //dpickerview.tag=2;
    [_daytextf setInputView:_dpickerview];
    
    _ypickerview=[[UIPickerView alloc]init];
    _ypickerview.delegate=self;
    _ypickerview.showsSelectionIndicator=YES;
    [_ypickerview selectRow:0 inComponent:0 animated:YES];
    //dpickerview.tag=2;
    [_yeartextf setInputView:_ypickerview];
    
   // [_daytextf setKeyboardType:UIKeyboardTypeNumberPad];
    //[_yeartextf setKeyboardType:UIKeyboardTypeNumberPad];
    
    
    
    
//    UIDatePicker *dtpick=[[UIDatePicker alloc]init];
//    [dtpick setDate:[NSDate date]];
//    dtpick.datePickerMode=UIDatePickerModeDate;
//    [dtpick addTarget:self action:@selector(selectdate:) forControlEvents:UIControlEventValueChanged];
//    [_monthtextf setInputView:dtpick];
//    
    
    
//    [_dtpicker addTarget:self action:@selector(selectdate:) forControlEvents:UIControlEventValueChanged];
//    _dtpicker.datePickerMode=UIDatePickerModeDate;
//    
    
    NSArray *dir=  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbpath=[NSString stringWithFormat:@"%@/Vegedb2.sqlite",[dir lastObject]];
    NSLog(@"%@",dbpath);
    NSFileManager *f=[[NSFileManager alloc]init];
    if([f fileExistsAtPath:dbpath])
    {
        NSLog(@"database alreay present");
        //    return;
    }
    sqlite3 *db;
    if( sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
    {
        const char * query=" create table vege (vname varchar(20) ,vquantity integer , vprice integer , dayd integer , monthd varchar(10) , yeard integer)";
        
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
    
    if([pickerView isEqual:_mpickerview])
    {
        return _monthsarray.count;
    }
    else if([pickerView isEqual:_dpickerview])
    {
        return _dayarr.count;
    }
    else
        return _yeararr.count;
}



-(void)viewWillAppear:(BOOL)animated
{
    
    [_namearr removeAllObjects];
    
    NSArray *dir=  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *dbpath=[NSString stringWithFormat:@"%@/Vegedb2.sqlite",[dir lastObject]];
    
    sqlite3 *db;
    
    sqlite3_stmt *mystmt;
    
    if( sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
    {
        //const char * query="select * from vege WHERE monthd=\"%@\",_";
        NSString *query=[NSString stringWithFormat:@"select * from vegename"];
        
        // if(sqlite3_prepare(db, query, -1, &mystmt, NULL)==SQLITE_OK)
        if(sqlite3_prepare(db,[query UTF8String],-1,&mystmt,NULL)==SQLITE_OK)
        {
            while (sqlite3_step(mystmt)==SQLITE_ROW)
            {
                NSString *temp=[ NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt,0)];
                [_namearr addObject:temp];
            }
        }
        else
        {
            NSLog(@"fail to execute query");
        }
    }
    sqlite3_close(db);
    [self.tableView reloadData];

    
}





//-(void)selectdate:(UIDatePicker *)sender
//{
//    
//    UIDatePicker *picker=(UIDatePicker *)_monthtextf.inputView;
//    [picker setMaximumDate:[NSDate date]];
//    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"MM"];
//    NSDate *eventdate=picker.date;
//    _dtstr=[NSString stringWithFormat:@"%@",[formatter stringFromDate:eventdate]];
//    NSLog(@"%@",_dtstr);
//}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if([pickerView isEqual:_mpickerview])
    {
    NSString * nameInRow;
       nameInRow=[_monthsarray objectAtIndex:row];
    return nameInRow;
    }
    else if([pickerView isEqual:_dpickerview])
    {
        NSString * nameInRow;
        nameInRow=[_dayarr objectAtIndex:row];
        return nameInRow;
    }
    else
    {
    NSString * nameInRow;
    nameInRow=[_yeararr objectAtIndex:row];
    return nameInRow;
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if([pickerView isEqual:_mpickerview])
    {
    _monthtextf.text=[_monthsarray objectAtIndex:row];
    }
    else if([pickerView isEqual:_dpickerview])
    {
        _daytextf.text=[_dayarr objectAtIndex:row];
    }
    
    else{
        _yeartextf.text=[_yeararr objectAtIndex:row];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _namearr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil)
    {
        cell=[[MenuTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
  cell.namelbl.text=[_namearr objectAtIndex:indexPath.row];
    
    //cell.bbtn layer] setBorderWidth:2.0f];
    
   // [[cell.namelbl layer]setBorderWidth:2.0f];
    
//    if([cell.bbtn.titleLabel.text isEqualToString:@"X"])
//    {
//        NSLog(@"%@",cell.bbtn.titleLabel.text);
//        cell.userInteractionEnabled=NO;
//        cell.detailTextLabel.text=@"Already Added";
//        
//    }
//    
//    else
//    {
//        NSLog(@"%@",cell.bbtn.titleLabel.text);
    
        
    [[cell.quantitytext layer]setBorderWidth:2.0f];
    [[cell.pricetext layer]setBorderWidth:2.0f];
    cell.quantitytext.delegate=self;
    cell.pricetext.delegate=self;
    
    [cell.quantitytext setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [cell.pricetext setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    
    
    
    if([_selectedmenu containsObject:cell.namelbl.text])
    {
        [cell.bbtn setImage:[UIImage imageNamed:@"tick.png"] forState:UIControlStateNormal];
       // [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        cell.pricetext.text=@"0";
        cell.quantitytext.text=@"0";
    }
    else
    {
        [cell.bbtn setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
       // [cell.bbtn setHidden:NO];
    }
    
   return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    _namestr=cell.namelbl.text;
    _pricestr=cell.pricetext.text;
    _quantitystr=cell.quantitytext.text;
    NSLog(@"%@    %@   %@",cell.namelbl.text,cell.pricetext.text,cell.quantitytext.text);

        }

- (IBAction)editbtn:(id)sender {
    
   
//    if(_dtstr==nil)
//    {
//        
//        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Failed" message:@"Please Select The Date" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [alert dismissViewControllerAnimated:YES completion:nil];
//        }];
//        [alert addAction:ok];
//        [self presentViewController:alert animated:YES completion:nil];
//        
//        NSLog(@"Please select Date");
//        
//    }
//    else
        if(_namestr==nil)
        {
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Failed" message:@"Plese Select The Item" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alert dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
            NSLog(@"Please Select Item");
        }
    
        else if ([_quantitystr isEqualToString:@"0"])
        {
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Failed" message:@"Please Select The Quantity" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alert dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
            NSLog(@"Add Quantity");
        }
    
        else
            if ([_pricestr isEqualToString:@"0"])
            {
                UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Failed" message:@"Please Insert Price and Item" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [alert dismissViewControllerAnimated:YES completion:nil];
                }];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
                
                NSLog(@"Add Price");
            }
    
            else
            {
                NSArray *dir=  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *dbpath=[NSString stringWithFormat:@"%@/Vegedb2.sqlite",[dir lastObject]];
                
                sqlite3 *db;
                
                
                if( sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
                {
                    NSString *query=[NSString stringWithFormat:@"update vege set vquantity=\"%@\",vprice=\"%@\",dayd=\"%@\",monthd=\"%@\",yeard=\"%@\" where vname=\"%@\"",_quantitystr,_pricestr,_daytextf.text,_monthtextf.text,_yeartextf.text,_namestr];
                    
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
                
                
                
                
            }

    
    [self.view endEditing:YES];
}

- (IBAction)buybtn:(id)sender {
    UIButton *btn=sender;

//    if(_dtstr==nil)
//    {
//        
//        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Failed" message:@"Please Select The Date" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [alert dismissViewControllerAnimated:YES completion:nil];
//        }];
//        [alert addAction:ok];
//        [self presentViewController:alert animated:YES completion:nil];
//
//        NSLog(@"Please select Date");
//        
//    }
//    else
        if(_namestr==nil)
        {
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Failed" message:@"Plese Select The Item" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alert dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];

            NSLog(@"Please Select Item");
        }
    
        else if ([_quantitystr isEqualToString:@"0"])
        {
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Failed" message:@"Please Select The Quantity" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alert dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];

            NSLog(@"Add Quantity");
        }

    else
            if ([_pricestr isEqualToString:@"0"])
        {
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Failed" message:@"Please Insert Price and Item" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alert dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];

            NSLog(@"Add Price");
        }
    
    else
    {
        
        NSArray *dir=  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *dbpath=[NSString stringWithFormat:@"%@/Vegedb2.sqlite",[dir lastObject]];
        sqlite3 *db;
        if( sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
        {
            NSString *insertquery=[NSString stringWithFormat:@"insert into vege values(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",_namestr,_quantitystr,_pricestr,_daytextf.text,_monthtextf.text,_yeartextf.text];
            NSLog(@"%@",insertquery);
            if(sqlite3_exec(db,[insertquery UTF8String],NULL,NULL,NULL)==SQLITE_OK)
            {
                NSLog(@"record inserted");
//
                
                [_selectedmenu addObject:_namestr];
                btn.userInteractionEnabled=NO;
                               // [btn setBackgroundColor:[UIColor greenColor]]
//                [btn setEnabled:NO];
//                [btn setHidden:YES];
                
                [self.tableView reloadData];
                    //                UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Success" message:@"Record Submited Successfully" preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    [alert dismissViewControllerAnimated:YES completion:nil];
//                }];
//                [alert addAction:ok];
//                [self presentViewController:alert animated:YES completion:nil];
            }
            else
            {
                NSLog(@"fail to insert record");
            }
        }
        sqlite3_close(db);
        
           }
    
    
    [self.view endEditing:YES];
    
}


@end
