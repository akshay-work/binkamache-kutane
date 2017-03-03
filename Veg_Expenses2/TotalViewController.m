//
//  TotalViewController.m
//  Veg_Expenses2
//
//  Created by Anveshak on 21/02/2017 .
//  Copyright © 1938 Saka Anveshak. All rights reserved.
//

#import "TotalViewController.h"
#import <sqlite3.h>

@interface TotalViewController ()

@end

@implementation TotalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _parr=[[NSMutableArray alloc]init];
    _qarr=[[NSMutableArray alloc]init];
   // _totalarr=[[NSMutableArray alloc]init];
    
    float sum2=0;
    for(NSNumber *n in _totalarr)
    {
        sum2 +=[n floatValue];
        NSLog(@"total= %f",sum2);
    }
    
    _pricelbl.text=[[NSString stringWithFormat:@"%.2f",sum2]description];
    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    NSArray *dir=  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *dbpath=[NSString stringWithFormat:@"%@/Vegedb2.sqlite",[dir lastObject]];
    
    sqlite3 *db;
    
    sqlite3_stmt *mystmt;
    
    if( sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
    {
        //const char * query="select * from vege WHERE monthd=\"%@\",_";
        NSString *query=[NSString stringWithFormat:@"select * from vege WHERE monthd=\"%@\"",_temp1];
        
        // if(sqlite3_prepare(db, query, -1, &mystmt, NULL)==SQLITE_OK)
        if(sqlite3_prepare(db,[query UTF8String],-1,&mystmt,NULL)==SQLITE_OK)
        {
            while (sqlite3_step(mystmt)==SQLITE_ROW) {
                
                
              //  NSString *temp=[ NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt,0)];
                NSString *temp2=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 1)];
                NSString *temp3=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 2)];
                
               // NSString *temp4=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 3)];
               // NSString *temp5=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 4)];
               // NSString *temp6=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 5)];
                
               // NSString *temp7=[NSString stringWithFormat:@"%@-%@-%@",temp4,temp5,temp6];
                
               // NSLog(@"%@ %@  %@ ",temp,temp2,temp3);
               // [ _namearr addObject:temp];
                [_qarr addObject:temp2];
                [_parr addObject:temp3];
               // [_dayarr addObject:temp4];
               // [_montharr addObject:temp5];
                //[_yeararr addObject:temp6];
                
               // NSLog(@"%@",temp7);
            }
        }
        else
        {
            NSLog(@"fail to execute query");
        }
        
    }
    
    
    sqlite3_close(db);

    
    
    float sum=0;
    for(NSNumber *n in _qarr)
    {
        sum +=[n floatValue];
        NSLog(@"total= %f",sum);
    }
    
    _quantitylbl.text=[[NSString stringWithFormat:@"%.2f",sum]description];
    
    
    _monlbl.text=_temp1;
    
//    
//    float sum2=0;
//    int c=0;
//    for(NSNumber *n in _parr)
//    {
//        sum2 +=[n floatValue];
//        c +=1;
//        NSLog(@"total= %f",sum);
//    }
//    
//    float s=sum2/c;
//    
//    float s2=s*sum;
//    _pricelbl.text=[NSString stringWithFormat:@"%.2f",s2];
//
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
