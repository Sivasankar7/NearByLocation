//
//  FindWayViewController.m
//  NearByLocation
//
//  Created by Mac on 7/12/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import "FindWayViewController.h"
#import <MapKit/MapKit.h>
#import "Annotation.h"
#import "NearLocation.h"
#import "NearByCell.h"
#import "MapViewViewController.h"
@interface FindWayViewController ()<CLLocationManagerDelegate,MKMapViewDelegate,NearLocationDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    NSString *strLatitude,*strLongtitude;
    IBOutlet UISlider *sliderRadius;
    IBOutlet UITableView *tableViewLocations;
    IBOutlet UILabel *labelSilderValue,*labelAddress;
    
    NSArray *arrayCurrentLocations;
    NSString *strRadius;
    NSInteger radius;
    NSDictionary *dicCurrentValue;

}
@end

@implementation FindWayViewController

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
    [tableViewLocations registerNib:[UINib nibWithNibName:@"NearByCell" bundle:nil] forCellReuseIdentifier:@"NearByCell"];
    tableViewLocations.hidden=YES;
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)getCurrentLocation
{
    [self animation];
    tableViewLocations.hidden=NO;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
}

-(IBAction)sliderValue
{
    strRadius=[NSString stringWithFormat:@"%f",sliderRadius.value];
    NSInteger radius=[strRadius intValue];
    strRadius=[NSString stringWithFormat:@"%ld",(long)radius];

    labelSilderValue.text=strRadius;
}
#pragma mark Location Delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *loc=[locations lastObject];
    strLongtitude=[NSString stringWithFormat:@"%f",loc.coordinate.longitude];
    strLatitude=[NSString stringWithFormat:@"%f",loc.coordinate.latitude];
    [self getNearLocation];
    [manager stopUpdatingLocation];
    
}
#pragma mark Table View Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayCurrentLocations.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NearByCell*  cell=(NearByCell*)[tableView dequeueReusableCellWithIdentifier:@"NearByCell"];
    NSDictionary *dic=[arrayCurrentLocations objectAtIndex:indexPath.row];

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

    dicCurrentValue=[arrayCurrentLocations objectAtIndex:indexPath.row];
    labelAddress.text=[dicCurrentValue valueForKey:@"name"];

    MapViewViewController *map=[[MapViewViewController alloc]initWithNibName:@"MapViewViewController" bundle:nil];
    map.strLatitude=[dicCurrentValue valueForKeyPath:@"geometry.location.lat"];
    map.strLongtitude=[dicCurrentValue valueForKeyPath:@"geometry.location.lng"];
    [self.navigationController pushViewController:map animated:YES];
    
}
-(void)getNearLocation
{
    NearLocation *location=[[NearLocation alloc]init];
    [location sendCurrentLocation:strLatitude Longtidute:strLongtitude Radius:strRadius Delegate:self];
    
}
#pragma mark Connection Delegate
- (void)connectionDidLoadResponse:(id)response;
{
    arrayCurrentLocations=[response valueForKey:@"results"];
    [tableViewLocations reloadData];
    NSLog(@"response %@",response);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self animation];
    tableViewLocations.hidden=YES;
}
#pragma mark CA Animation
-(void)animation
{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionPush;
    [animation setDuration:.5];
    animation.subtype = kCATransitionFromTop;
    [tableViewLocations.layer addAnimation:animation forKey:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
