//
//  AddVegetableViewController.m
//  Veg_Expenses2
//
//  Created by Anveshak on 21/02/2017 .
//  Copyright © 1938 Saka Anveshak. All rights reserved.
//

#import "AddVegetableViewController.h"
#import <sqlite3.h>

@interface AddVegetableViewController ()

@end

@implementation AddVegetableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
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
        const char * query=" create table vegename (vegname varchar(20))";
        
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

- (IBAction)submitbtn:(id)sender
{
    if([_addvegetextf.text isEqualToString:@""])
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Failed" message:@"Plese Insert Vegetable Name" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
        NSLog(@"Please Select Item");
    }
    else{
    
    NSArray *dir=  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbpath=[NSString stringWithFormat:@"%@/Vegedb2.sqlite",[dir lastObject]];
    sqlite3 *db;
    if( sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
    {
        NSString *insertquery=[NSString stringWithFormat:@"insert into vegename values(\"%@\")",_addvegetextf.text];
        NSLog(@"%@",insertquery);
        if(sqlite3_exec(db,[insertquery UTF8String],NULL,NULL,NULL)==SQLITE_OK)
        {
            NSLog(@"record inserted");
            _addvegetextf.text=@"";
        }
        else
        {
            NSLog(@"fail to insert record");
        }
    }
    
    sqlite3_close(db);
    }
}
@end
