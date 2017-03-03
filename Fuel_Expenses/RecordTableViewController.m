//
//  RecordTableViewController.m
//  Fuel_Expenses
//
//  Created by Anveshak on 24/11/1938 Saka.
//  Copyright © 1938 Saka Anveshak. All rights reserved.
//

#import "RecordTableViewController.h"
#import "RecordTableViewCell.h"
#import <sqlite3.h>
#import "ExpensesViewController.h"
#import "EditViewController.h"
@interface RecordTableViewController ()

@end

@implementation RecordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pricearray=[[NSMutableArray alloc]init];
    _volarray=[[NSMutableArray alloc]init];
   // _datearray=[[NSMutableArray alloc]init];
    _dtotalarray=[[NSMutableArray alloc]init];
    _totalarray=[[NSMutableArray alloc]init];
    _dayarr=[[NSMutableArray alloc]init];
    _montharr=[[NSMutableArray alloc]init];
    _yeararr=[[NSMutableArray alloc]init];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_pricearray removeAllObjects];
    [_volarray removeAllObjects];
    [_dayarr removeAllObjects];
    [_montharr removeAllObjects];
    [_yeararr removeAllObjects];
    
    NSArray *dir=  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *dbpath=[NSString stringWithFormat:@"%@/Fueldb2.sqlite",[dir lastObject]];
    
    sqlite3 *db;
    
    sqlite3_stmt *mystmt;
    
    if( sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
    {
      //  const char * query="select * from fuel WHERE monthd=\"%@\"",_mstr;
         NSString *query=[NSString stringWithFormat:@"select * from fuel WHERE monthd=\"%@\"",_mstr];
        if(sqlite3_prepare(db,[query UTF8String], -1, &mystmt, NULL)==SQLITE_OK)
        {
            while (sqlite3_step(mystmt)==SQLITE_ROW) {
                
                
                NSString *temp=[ NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt,0)];
                NSString *temp2=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 1)];
                NSString *temp3=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 2)];
                NSString *temp4=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 3)];
                NSString *temp5=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 4)];
                NSLog(@"%@ %@  %@ ",temp,temp2,temp3);
                [ _volarray addObject:temp];
                [_pricearray addObject:temp2];
                [_dayarr addObject:temp3];
                [_montharr addObject:temp4];
                [_yeararr addObject:temp5];
                
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return _pricearray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.volumelabel.text=[_volarray objectAtIndex:indexPath.row];
    cell.pricelabel.text=[_pricearray objectAtIndex:indexPath.row];
    //cell.datelbl.text=[_datearray objectAtIndex:indexPath.row];
    cell.daylbl.text=[_dayarr objectAtIndex:indexPath.row];
    cell.monthlbl.text=[_montharr objectAtIndex:indexPath.row];
    cell.yearlbl.text=[_yeararr objectAtIndex:indexPath.row];

    //NSString *tempstr=[NSString stringWithFormat:@"%@",cell.volumelabel.text];
    //NSString *tempstr2=[NSString stringWithFormat:@"%@",cell.pricelabel.text];
    
    float p=[[cell.volumelabel text]floatValue];
    float v=[[cell.pricelabel text]floatValue];
    
    float t= p * v;
    
    cell.daytotal.text=[NSString stringWithFormat:@"%.02f",t];
    NSLog(@"%.02f",t);
    
    [_totalarray addObject:[NSNumber numberWithFloat:t]];
    return cell;
    
    
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RecordTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    _celltext1=cell.daylbl.text;
    _celltext2=cell.volumelabel.text;
    _celltext3=cell.pricelabel.text;
    _celltext4=cell.monthlbl.text;
    _celltext5=cell.yearlbl.text;
    NSLog(@"cell Text %@",_celltext1);
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier]isEqualToString:@"ddd"])
    {
        EditViewController *e =[segue destinationViewController];
        e.temp1=_celltext1;
        e.temp2=_celltext2;
        e.temp3=_celltext3;
        e.temp4=_celltext4;
        e.temp5=_celltext5;
    }
    
    else if([[segue identifier]isEqualToString:@"ccc"])
    {
        ExpensesViewController *ex=[segue destinationViewController];
              ex.daytotalarr=_totalarray;
        
    }
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)edtbtn:(id)sender {
    
    
}

- (IBAction)dltbtn:(id)sender {
    
    
    
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Delete"message:@"Do you really want to delete this record?"delegate:self cancelButtonTitle:@"Cancel"otherButtonTitles:@"Delete", nil];
    
    [alert show];
    
    

    
   
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == [alertView cancelButtonIndex])
    {
        
    }
    else{
        NSArray *dir=  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *dbpath=[NSString stringWithFormat:@"%@/Fueldb2.sqlite",[dir lastObject]];
        
        sqlite3 *db;
        
        
        if( sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
        {
            
            NSString *query=[NSString stringWithFormat:@"delete from fuel where vol=\"%@\" AND price=\"%@\" AND dayd=\"%@\" AND monthd=\"%@\" AND yeard=\"%@\"",_celltext2,_celltext3,_celltext1,_celltext4,_celltext5];
            
            //        NSString *query=[NSString stringWithFormat:@"delete from vege where vname=\"%@\" AND dayd=\"%@\" AND monthd=\"%@\" AND yeard=\"%@\" AND vprice=\"%@\" AND vquantity=\"%@\"",_tempnamestr,_tempdaystr,_tempmonthstr,_tempyearstr,_temppricestr,_tempquantitystr];
            //
            
            if(sqlite3_exec(db,[query UTF8String],NULL,NULL,NULL)==SQLITE_OK)
            {
                NSLog(@"deleted");
                [self.tableView reloadData];
            }
            else
            {
                NSLog(@"fail to delete");
            }
            
            
        }
        
        sqlite3_close(db);
        
        [self viewWillAppear:YES];
        [self.tableView reloadData];
    }
}




- (IBAction)segselect:(id)sender {
    
    if(_segmnt1.selectedSegmentIndex==0)
    {
        NSLog(@"Jan");
        _mstr=@"Jan";
    }
    else
        if(_segmnt1.selectedSegmentIndex==1)
        {
            NSLog(@"Feb");
            _mstr=@"Feb";
        }
    
        else if (_segmnt1.selectedSegmentIndex==2)
        {
            NSLog(@"Mar");
            _mstr=@"Mar";
        }
    
        else if (_segmnt1.selectedSegmentIndex==3)
        {
            NSLog(@"April");
            _mstr=@"April";
        }
        else if (_segmnt1.selectedSegmentIndex==4)
        {
            NSLog(@"May");
            _mstr=@"May";
        }
        else if (_segmnt1.selectedSegmentIndex==5)
        {
            NSLog(@"June");
            _mstr=@"June";
        }
        else if (_segmnt1.selectedSegmentIndex==6)
        {
            NSLog(@"July");
            _mstr=@"July";
        }
        else if (_segmnt1.selectedSegmentIndex==7)
        {
            NSLog(@"Aug");
            _mstr=@"Aug";
        }
        else if (_segmnt1.selectedSegmentIndex==8)
        {
            NSLog(@"Sept");
            _mstr=@"Sept";
        } else if (_segmnt1.selectedSegmentIndex==9)
        {
            NSLog(@"Oct");
            _mstr=@"Oct";
        } else if (_segmnt1.selectedSegmentIndex==10)
        {
            NSLog(@"Nov");
            _mstr=@"Nov";
        } else if (_segmnt1.selectedSegmentIndex==11)
        {
            NSLog(@"Dec");
            _mstr=@"Dec";
        }
    
    [self viewWillAppear:YES];
    

    
    
}
@end
