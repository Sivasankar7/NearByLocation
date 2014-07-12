//
//  NearByViewController.m
//  New Topic
//
//  Created by BLT0003-MACBK on 04/07/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "NearByViewController.h"

#import <CoreLocation/CoreLocation.h>
#import "MapViewViewController.h"
#import "NearByCell.h"
#import "NearLocation.h"
@interface NearByViewController ()<NearLocationDelegate,CLLocationManagerDelegate>
{
    IBOutlet UITableView *tableViewNearBy;
    IBOutlet UILabel *labelNearBy;
    NSArray *arrayNearBy;
    NSString *strLatitude,*strLongtitude;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;

}
@end

@implementation NearByViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [tableViewNearBy registerNib:[UINib nibWithNibName:@"NearByCell" bundle:nil] forCellReuseIdentifier:@"NearByCell"];

    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
    labelNearBy.text=self.strTitle;
    // Configure the new event with information from the location
    


    // Do any additional setup after loading the view from its nib.
}

#pragma mark TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayNearBy.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NearByCell*  cell=(NearByCell*)[tableView dequeueReusableCellWithIdentifier:@"NearByCell"];
    NSDictionary *dic=[arrayNearBy objectAtIndex:indexPath.row];
    
    cell.labelTitle.text=[dic valueForKey:@"name"];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[dic valueForKey:@"icon"]]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(data)
            cell.imageViewLocation.image=[UIImage imageWithData:data];
    }];
    cell.labelAddress.text=[dic valueForKey:@"vicinity"];//vicinity
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=[arrayNearBy objectAtIndex:indexPath.row];

    MapViewViewController *map=[[MapViewViewController alloc]initWithNibName:@"MapViewViewController" bundle:nil];
     map.strLatitude=[dic valueForKeyPath:@"geometry.location.lat"];
    map.strLongtitude=[dic valueForKeyPath:@"geometry.location.lng"];
    [self.navigationController pushViewController:map animated:YES];
    
}
#pragma mark Button Action
-(IBAction)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark CLlocation Deleagate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *loc=[locations lastObject];
    strLongtitude=[NSString stringWithFormat:@"%f",loc.coordinate.longitude];
    strLatitude=[NSString stringWithFormat:@"%f",loc.coordinate.latitude];
     [self getNearLocation];
    [manager stopUpdatingLocation];
   
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}
#pragma mark Requset
-(void)getNearLocation
{
    NearLocation *location=[[NearLocation alloc]init];
    [location sendLatitude:strLatitude Longtidute:strLongtitude Radius:@"1000" Type:self.strLocationType Delegate:self];
}
#pragma mark Locatoin Delegate
- (void)connectionDidLoadResponse:(id)response;
{
    arrayNearBy=[response valueForKey:@"results"];
    [tableViewNearBy reloadData];
    NSLog(@"response %@",response);
}
- (void)connectionDidLoadResponseFailed:(NSError*)error;
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
