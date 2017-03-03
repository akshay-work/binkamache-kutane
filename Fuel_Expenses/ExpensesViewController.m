//
//  ExpensesViewController.m
//  Fuel_Expenses
//
//  Created by Anveshak on 25/11/1938 Saka.
//  Copyright © 1938 Saka Anveshak. All rights reserved.
//

#import "ExpensesViewController.h"
#import <sqlite3.h>

@interface ExpensesViewController ()

@end

@implementation ExpensesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _parray=[[NSMutableArray alloc]init];
    _varray=[[NSMutableArray alloc]init];
    _daaray=[[NSMutableArray alloc]init];
    _temparray=[[NSMutableArray alloc]init];
    
    [_frmtext setDelegate:self];
    [_totext setDelegate:self];
    [_frmtext setKeyboardType:UIKeyboardTypeNumberPad];
    [_totext setKeyboardType:UIKeyboardTypeNumberPad];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_parray removeAllObjects];
    [_varray removeAllObjects];
    [_daaray removeAllObjects];
    
    
    NSArray *dir=  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *dbpath=[NSString stringWithFormat:@"%@/Fueldb2.sqlite",[dir lastObject]];
    
    sqlite3 *db;
    
    sqlite3_stmt *mystmt;
    
    if( sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
    {
         NSString *query=[NSString stringWithFormat:@"select * from fuel WHERE monthd=\"%@\"",_monthstr];
        
        if(sqlite3_prepare(db,[query UTF8String], -1, &mystmt, NULL)==SQLITE_OK)
        {
            while (sqlite3_step(mystmt)==SQLITE_ROW) {
                
                
                NSString *temp=[ NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt,0)];
                NSString *temp2=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 1)];
                NSString *temp3=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 2)];
                
                NSLog(@"%@ %@  %@ ",temp,temp2,temp3);
                [_varray addObject:temp];
                [_parray addObject:temp2];
               // [_daaray addObject:temp3];
            }
        }
        else
        {
            NSLog(@"fail to execute query");
        }
        
    }
    
    sqlite3_close(db);

    float sum=0;
    for(NSNumber *n in _varray)
    {
        sum +=[n floatValue];
        NSLog(@"total= %f",sum);
    }
   // _totalfuel.text=[NSNumber numberWithFloat:sum].description;
    _totalfuel.text=[NSString stringWithFormat:@"%.2f",sum];
    
    int tcount=0;
    for (NSNumber *no in _varray)
    {
        tcount += 1;
    }
    NSLog(@"%d",tcount);
    NSLog(@"%f",sum/tcount);
    float fav=sum/tcount;
    //_fuelavg.text=[NSNumber numberWithFloat:fav].description;
    _fuelavg.text=[NSString stringWithFormat:@"%.2f",fav];
    NSLog(@"%f",fav);
   
    
    float pricesum;
    for(NSNumber *i in _parray)
    {
        pricesum +=[i floatValue];
    }
    
    
       float pav = pricesum/tcount;
  //  _priceavg.text=[NSNumber numberWithFloat:pav].description;
    _priceavg.text=[NSString stringWithFormat:@"%.2f",pav];
    float tot=sum*pav;
    
    _totalprice.text=[NSString stringWithFormat:@"%.2f",tot];
    //_totalprice.text=[NSNumber numberWithFloat:tot].description;
    

    
    
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
        _monthstr=@"Jan";
    }
    else
        if(_segm.selectedSegmentIndex==1)
        {
            NSLog(@"Feb");
            _monthstr=@"Feb";
        }
    
        else if (_segm.selectedSegmentIndex==2)
        {
            NSLog(@"Mar");
            _monthstr=@"Mar";
        }
    
        else if (_segm.selectedSegmentIndex==3)
        {
            NSLog(@"April");
            _monthstr=@"April";
        }
        else if (_segm.selectedSegmentIndex==4)
        {
            NSLog(@"May");
            _monthstr=@"May";
        }
        else if (_segm.selectedSegmentIndex==5)
        {
            NSLog(@"June");
            _monthstr=@"June";
        }
        else if (_segm.selectedSegmentIndex==6)
        {
            NSLog(@"July");
            _monthstr=@"July";
        }
        else if (_segm.selectedSegmentIndex==7)
        {
            NSLog(@"Aug");
            _monthstr=@"Aug";
        }
        else if (_segm.selectedSegmentIndex==8)
        {
            NSLog(@"Sept");
            _monthstr=@"Sept";
        } else if (_segm.selectedSegmentIndex==9)
        {
            NSLog(@"Oct");
            _monthstr=@"Oct";
        } else if (_segm.selectedSegmentIndex==10)
        {
            NSLog(@"Nov");
            _monthstr=@"Nov";
        } else if (_segm.selectedSegmentIndex==11)
        {
            NSLog(@"Dec");
            _monthstr=@"Dec";
        }
    
    [self viewWillAppear:YES];
    

    
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return textField;
}
- (IBAction)showbtn:(id)sender {
    
    [_parray removeAllObjects];
    [_varray removeAllObjects];
    [_daaray removeAllObjects];
    [self textFieldShouldReturn:_totext];
    [self textFieldShouldReturn:_frmtext];
    
    NSArray *dir=  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *dbpath=[NSString stringWithFormat:@"%@/Fueldb2.sqlite",[dir lastObject]];
    
    sqlite3 *db;
    
    sqlite3_stmt *mystmt;
    
    if( sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
    {
        NSString *query=[NSString stringWithFormat:@"select * from fuel WHERE dayd BETWEEN \"%@\" AND \"%@\" AND monthd=\"%@\"",_frmtext.text,_totext.text,_monthstr];
        
        if(sqlite3_prepare(db,[query UTF8String], -1, &mystmt, NULL)==SQLITE_OK)
        {
            while (sqlite3_step(mystmt)==SQLITE_ROW) {
                
                
                NSString *temp=[ NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt,0)];
                NSString *temp2=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 1)];
                NSString *temp3=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 2)];
                
                NSLog(@"%@ %@  %@ ",temp,temp2,temp3);
                [_varray addObject:temp];
                [_parray addObject:temp2];
                // [_daaray addObject:temp3];
            }
        }
        else
        {
            NSLog(@"fail to execute query");
        }
        
    }
    
    sqlite3_close(db);
    
    float sum=0;
    for(NSNumber *n in _varray)
    {
        sum +=[n floatValue];
        NSLog(@"total= %f",sum);
    }
    // _totalfuel.text=[NSNumber numberWithFloat:sum].description;
    _totalfuel.text=[NSString stringWithFormat:@"%.2f",sum];
    
    int tcount=0;
    for (NSNumber *no in _varray)
    {
        tcount += 1;
    }
    NSLog(@"%d",tcount);
    NSLog(@"%f",sum/tcount);
    float fav=sum/tcount;
    //_fuelavg.text=[NSNumber numberWithFloat:fav].description;
   //_fuelavg.text=[NSString stringWithFormat:@"%.2f",fav];
    
    _fuelavg.text=[NSString stringWithFormat:@"--"];
    NSLog(@"%f",fav);
    
    
    float pricesum;
    for(NSNumber *i in _parray)
    {
        pricesum +=[i floatValue];
    }
    
    
    float pav = pricesum/tcount;
    //  _priceavg.text=[NSNumber numberWithFloat:pav].description;
   // _priceavg.text=[NSString stringWithFormat:@"%.2f",pav];
    _priceavg.text=[NSString stringWithFormat:@"--"];
    float tot=sum*pav;
    
    _totalprice.text=[NSString stringWithFormat:@"%.2f",tot];
    //_totalprice.text=[NSNumber numberWithFloat:tot].description;
    
    
}
@end
