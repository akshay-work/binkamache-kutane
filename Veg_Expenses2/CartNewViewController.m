//
//  CartNewViewController.m
//  Veg_Expenses2
//
//  Created by Anveshak on 21/02/2017 .
//  Copyright © 1938 Saka Anveshak. All rights reserved.
//

#import "CartNewViewController.h"
#import "CartTableViewCell.h"
#import "TotalViewController.h"
#import <sqlite3.h>


@interface CartNewViewController ()

@end

@implementation CartNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _namearr=[[NSMutableArray alloc]init];
    _quantarr=[[NSMutableArray alloc]init];
    _pricearr=[[NSMutableArray alloc]init];
    _dayarr=[[NSMutableArray alloc]init];
    _montharr=[[NSMutableArray alloc]init];
    _yeararr=[[NSMutableArray alloc]init];
    _totalparr=[[NSMutableArray alloc]init];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _frmtext.delegate=self;
    _totext.delegate=self;
    _yeartextf.delegate=self;
    [_frmtext setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [_totext setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    
    
//    _yeararr2=[[NSMutableArray alloc]initWithObjects:@"2016",@"2017",@"2018",@"2019",@"2020",@"2021",@"2022",@"2023",@"2024",@"2025",@"2026",@"2027",@"2028",@"2029",@"2030", nil];
//    
//    _yearpickerv=[[UIPickerView alloc]init];
//    _yearpickerv.delegate=self;
//    _yearpickerv.showsSelectionIndicator=YES;
//    [_yearpickerv selectRow:0 inComponent:0 animated:YES];
//    //dpickerview.tag=2;
//    [_yeartextf setInputView:_yearpickerv];
//    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [_namearr removeAllObjects];
    [_pricearr removeAllObjects];
    [_quantarr removeAllObjects];
    [_dayarr removeAllObjects];
    [_montharr removeAllObjects];
    [_yeararr removeAllObjects];
    [_totalparr removeAllObjects];
    
    
    NSArray *dir=  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *dbpath=[NSString stringWithFormat:@"%@/Vegedb2.sqlite",[dir lastObject]];
    
    sqlite3 *db;
    
    sqlite3_stmt *mystmt;
    
    if( sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
    {
        //const char * query="select * from vege WHERE monthd=\"%@\",_";
        NSString *query=[NSString stringWithFormat:@"select * from vege WHERE yeard=\"%@\" AND monthd=\"%@\"",_yeartextf.text,_mstr];
        
        // if(sqlite3_prepare(db, query, -1, &mystmt, NULL)==SQLITE_OK)
        if(sqlite3_prepare(db,[query UTF8String],-1,&mystmt,NULL)==SQLITE_OK)
        {
            while (sqlite3_step(mystmt)==SQLITE_ROW) {
                
                
                NSString *temp=[ NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt,0)];
                NSString *temp2=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 1)];
                NSString *temp3=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 2)];
                
                NSString *temp4=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 3)];
                NSString *temp5=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 4)];
                NSString *temp6=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 5)];
                
                NSString *temp7=[NSString stringWithFormat:@"%@-%@-%@",temp4,temp5,temp6];
                
                NSLog(@"%@ %@  %@ ",temp,temp2,temp3);
                [ _namearr addObject:temp];
                [_quantarr addObject:temp2];
                [_pricearr addObject:temp3];
                [_dayarr addObject:temp4];
                [_montharr addObject:temp5];
                [_yeararr addObject:temp6];
                
                NSLog(@"%@",temp7);
            }
        }
        else
        {
            NSLog(@"fail to execute query");
        }
        
        
        
        
    }
    
    
    sqlite3_close(db);
    [self.tableview reloadData];
    
    
    
    float sum=0;
    for(NSNumber *n in _quantarr)
    {
        sum +=[n floatValue];
        NSLog(@"total= %f",sum);
    }
    
    _vegetotallabel.text=[[NSString stringWithFormat:@"%.2f",sum]description];
    

    
//    NSNumber *myNum1 = [NSNumber numberWithInt:1];
//    NSNumber *myNum2 = [NSNumber numberWithInt:2];
//    NSNumber *myNum3 = [NSNumber numberWithInt:3];
//    
//    NSArray *a = [NSArray arrayWithObjects: myNum1, myNum2, myNum3, nil];
//    NSArray *b = [NSArray arrayWithObjects: myNum1, myNum2, myNum3, nil];
    float sum2=0;
    for (int i=0; i<[_quantarr count]; i++) {
        NSLog(@"%@",[_quantarr objectAtIndex:i]);
        sum2 =sum2 +[[_quantarr objectAtIndex:i] floatValue]*[[_pricearr objectAtIndex:i] floatValue];
    }
    _pricetotallabel.text=[NSString stringWithFormat:@"%.2f",sum2];
    NSLog(@"Sum is %.2f", sum2);

    
    
    
}



//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//{
//    return 1;
//}
//
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//{
//    return _yeararr2.count;
//}
//
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//        NSString * nameInRow;
//        nameInRow=[_yeararr2 objectAtIndex:row];
//        return nameInRow;
//}
//
//-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//    
//        _yeartextf.text=[_yeararr2 objectAtIndex:row];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return _namearr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CartTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.namelbl.text=[_namearr objectAtIndex:indexPath.row];
    cell.quantitylbl.text=[_quantarr objectAtIndex:indexPath.row];
    
    
    NSString *num1=[[_quantarr objectAtIndex:indexPath.row]description];
    NSString *num2=[[_pricearr objectAtIndex:indexPath.row]description];
    
    
    float f=[num1 floatValue];
    float f2=[num2 floatValue];
    
    float f3=f*f2;
    cell.pricelbl.text=[NSString stringWithFormat:@"%.2f",f3];
    
    [_totalparr addObject:[NSString stringWithFormat:@"%@",cell.pricelbl.text]];
    
    
//    float sum=0;
//    for(NSNumber *n in _totalparr)
//    {
//        sum +=[n floatValue];
//        NSLog(@"total= %f",sum);
//    }
//    
//    _vegetotallabel.text=[[NSString stringWithFormat:@"%.2f",sum]description];
//    

    
    
    //  cell.pricelbl.text=[_pricearr objectAtIndex:indexPath.row];
    cell.daylbl.text=[_dayarr objectAtIndex:indexPath.row];
    cell.monthlbl.text=[_montharr objectAtIndex:indexPath.row];
    cell.yearlbl.text=[_yeararr objectAtIndex:indexPath.row];
    cell.ratelbl.text=[_pricearr objectAtIndex:indexPath.row];
    [[cell.cancelbtn layer]setCornerRadius:10.0f];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CartTableViewCell *cell=[_tableview cellForRowAtIndexPath:indexPath];
    // NSLog(@"%@    %@   %@",cell.namelbl.text,cell.pricetext.text,cell.quantitytext.text);
    _tempnamestr=cell.namelbl.text;
    _tempdaystr=cell.daylbl.text;
    _tempmonthstr=cell.monthlbl.text;
    _tempyearstr=cell.yearlbl.text;
    //  _temppricestr=cell.pricelbl.text;
    _tempquantitystr=cell.quantitylbl.text;
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

- (IBAction)segmchnge:(id)sender {
    
    if(_segm.selectedSegmentIndex==0)
    {
        NSLog(@"Jan");
        _mstr=@"Jan";
    }
    else
        if(_segm.selectedSegmentIndex==1)
        {
            NSLog(@"Feb");
            _mstr=@"Feb";
        }
    
        else if (_segm.selectedSegmentIndex==2)
        {
            NSLog(@"Mar");
            _mstr=@"Mar";
        }
    
        else if (_segm.selectedSegmentIndex==3)
        {
            NSLog(@"April");
            _mstr=@"April";
        }
        else if (_segm.selectedSegmentIndex==4)
        {
            NSLog(@"May");
            _mstr=@"May";
        }
        else if (_segm.selectedSegmentIndex==5)
        {
            NSLog(@"June");
            _mstr=@"June";
        }
        else if (_segm.selectedSegmentIndex==6)
        {
            NSLog(@"July");
            _mstr=@"July";
        }
        else if (_segm.selectedSegmentIndex==7)
        {
            NSLog(@"Aug");
            _mstr=@"Aug";
        }
        else if (_segm.selectedSegmentIndex==8)
        {
            NSLog(@"Sept");
            _mstr=@"Sept";
        } else if (_segm.selectedSegmentIndex==9)
        {
            NSLog(@"Oct");
            _mstr=@"Oct";
        } else if (_segm.selectedSegmentIndex==10)
        {
            NSLog(@"Nov");
            _mstr=@"Nov";
        } else if (_segm.selectedSegmentIndex==11)
        {
            NSLog(@"Dec");
            _mstr=@"Dec";
        }
    
    [self viewWillAppear:YES];
    
}
- (IBAction)showbtn:(id)sender {
    
    
    
    [_namearr removeAllObjects];
    [_pricearr removeAllObjects];
    [_quantarr removeAllObjects];
    [_dayarr removeAllObjects];
    [_montharr removeAllObjects];
    [_yeararr removeAllObjects];
    [_totalparr removeAllObjects];
    
    
    NSArray *dir=  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *dbpath=[NSString stringWithFormat:@"%@/Vegedb2.sqlite",[dir lastObject]];
    
    sqlite3 *db;
    
    sqlite3_stmt *mystmt;
    
    if( sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
    {
        //const char * query="select * from vege WHERE monthd=\"%@\",_";
        NSString *query=[NSString stringWithFormat:@"select * from vege WHERE dayd BETWEEN \"%@\" AND \"%@\" AND monthd=\"%@\"",_frmtext.text,_totext.text,_mstr];
        
        
//        NSString *query=[NSString stringWithFormat:@"select * from fuel WHERE dayd BETWEEN \"%@\" AND \"%@\" AND monthd=\"%@\"",_frmtext.text,_totext.text,_monthstr];
//        
        
        // if(sqlite3_prepare(db, query, -1, &mystmt, NULL)==SQLITE_OK)
        if(sqlite3_prepare(db,[query UTF8String],-1,&mystmt,NULL)==SQLITE_OK)
        {
            while (sqlite3_step(mystmt)==SQLITE_ROW) {
                
                
                NSString *temp=[ NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt,0)];
                NSString *temp2=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 1)];
                NSString *temp3=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 2)];
                
                NSString *temp4=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 3)];
                NSString *temp5=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 4)];
                NSString *temp6=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 5)];
                
                NSString *temp7=[NSString stringWithFormat:@"%@-%@-%@",temp4,temp5,temp6];
                
                NSLog(@"%@ %@  %@ ",temp,temp2,temp3);
                [ _namearr addObject:temp];
                [_quantarr addObject:temp2];
                [_pricearr addObject:temp3];
                [_dayarr addObject:temp4];
                [_montharr addObject:temp5];
                [_yeararr addObject:temp6];
                
                _frmtext.text=@"";
                _totext.text=@"";
                
                
                float sum=0;
                for(NSNumber *n in _quantarr)
                {
                    sum +=[n floatValue];
                    NSLog(@"total= %f",sum);
                }

                _vegetotallabel.text=[[NSString stringWithFormat:@"%.2f",sum]description];
                

                
                float sum2=0;
                for (int i=0; i<[_quantarr count]; i++) {
                    NSLog(@"%@",[_quantarr objectAtIndex:i]);
                    sum2 =sum2 +[[_quantarr objectAtIndex:i] floatValue]*[[_pricearr objectAtIndex:i] floatValue];
                }
                _pricetotallabel.text=[[NSString stringWithFormat:@"%.2f",sum2]description];
                NSLog(@"Sum is %f", sum2);
                

                
                
                
                NSLog(@"%@",temp7);
            }
        }
        else
        {
            NSLog(@"fail to execute query");
        }
        
        [self textFieldShouldReturn:_yeartextf];
        [self textFieldShouldReturn:_frmtext];
        [self textFieldShouldReturn:_totext];
    }
    
    
    sqlite3_close(db);
    [self.tableview reloadData];
    
}

- (IBAction)deletebtn:(id)sender {
    
    if(_tempnamestr==nil)
    {
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Failed to Delete" message:@"Please select item to Delete" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
    
    NSArray *dir=  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbpath=[NSString stringWithFormat:@"%@/Vegedb2.sqlite",[dir lastObject]];
    
    sqlite3 *db;
    
    
    if( sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
    {
        NSLog(@"%@",_tempnamestr);
        NSString *query=[NSString stringWithFormat:@"delete from vege where vname=\"%@\" AND dayd=\"%@\" AND monthd=\"%@\" AND yeard=\"%@\" AND vquantity=\"%@\"",_tempnamestr,_tempdaystr,_tempmonthstr,_tempyearstr,_tempquantitystr];
        
        
        if(sqlite3_exec(db,[query UTF8String],NULL,NULL,NULL)==SQLITE_OK)
        {
            NSLog(@"deleted");
            //[self.tableView reloadData];
            
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"DELETED" message:@"Record Deleted Successfully" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alert dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        else
        {
            NSLog(@"fail to delete");
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
        [self.tableview reloadData];
    }
    
    sqlite3_close(db);
    
    [self.tableview reloadData];
    [self viewWillAppear:YES];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return textField;
}
@end
