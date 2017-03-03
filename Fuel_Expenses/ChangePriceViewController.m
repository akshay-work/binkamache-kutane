//
//  ChangePriceViewController.m
//  Fuel_Expenses
//
//  Created by Anveshak on 24/11/1938 Saka.
//  Copyright © 1938 Saka Anveshak. All rights reserved.
//

#import "ChangePriceViewController.h"
#import "FuelViewController.h"

@interface ChangePriceViewController ()

@end

@implementation ChangePriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendar *buddhist = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSBuddhistCalendar];
    NSCalendar *preferred = [NSCalendar currentCalendar];
    NSLog(@"%@", gregorian.calendarIdentifier);
    NSLog(@"%@", buddhist.calendarIdentifier);
    NSLog(@"%@", preferred.calendarIdentifier);
   
//    
//    NSDate *now = [NSDate date];
//    NSCalendar *calendar = [[NSCalendar alloc]
//                            initWithCalendarIdentifier:NSGregorianCalendar];
//    NSCalendarUnit units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
//    NSDateComponents *components = [calendar components:units fromDate:now];
//    
//    NSLog(@"Day: %ld", [components day]);
//    NSLog(@"Month: %ld", [components month]);
//    NSLog(@"Year: %ld", [components year]);
//
//    NSCalendar *calendar = [[NSCalendar alloc]
//                            initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setYear:2012];
//    [components setMonth:11];
//    [components setDay:4];
//    
//    NSDate *november4th2012 = [calendar dateFromComponents:components];
//    NSLog(@"%0.0f seconds between Jan 1st, 2001 and Nov 4th, 2012",
//          [november4th2012 timeIntervalSinceReferenceDate]);
//    
//    
    
    NSDate *start = [NSDate dateWithTimeIntervalSinceReferenceDate:0];
    NSDate *end = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit units = NSWeekCalendarUnit;
    NSDateComponents *components = [calendar components:units
                                               fromDate:start
                                                 toDate:end
                                                options:0];
    NSLog(@"It has been %ld weeks since January 1st, 2001",
          [components week]);
    
    
    
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterShortStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    
//    NSDate *now = [NSDate date];
//    NSString *prettyDate = [formatter stringFromDate:now];
//    NSLog(@"%@", prettyDate);
//
    
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
//    [formatter setLocale:posix];
//    [formatter setDateFormat:@"M.d.y"];
//    // Date to string
//    NSDate *now = [NSDate date];
//    NSString *prettyDate = [formatter stringFromDate:now];
//    NSLog(@"%@", prettyDate);
//    
//    
//    NSString *dateString = @"11.4.2012";
//    NSDate *november4th2012 = [formatter dateFromString:dateString];
//    NSLog(@"%@", november4th2012);
//    
//    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *egyptianArabic = [[NSLocale alloc] initWithLocaleIdentifier:@"ar_EG"];
    [formatter setLocale:egyptianArabic];
    [formatter setDateFormat:@"M.d.y"];
    
    NSDate *now = [NSDate date];
    NSString *prettyDate = [formatter stringFromDate:now];
    NSLog(@"%@", prettyDate);
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

- (IBAction)sbtn:(id)sender {
    
//    FuelViewController *f=[[FuelViewController alloc]init];
//    f.temp=[NSString stringWithFormat:@"%@", _pricetext.text];
//    NSLog(@"%@",f.temp);
    [self.delegate senddata:_pricetext.text];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)chngeseg:(id)sender {
}
@end
