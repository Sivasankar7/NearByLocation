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
@interface FindWayViewController ()<CLLocationManagerDelegate,MKMapViewDelegate,NearLocationDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    NSString *strLatitude,*strLongtitude;
    IBOutlet UITextField *textFldRadius;
    IBOutlet UITableView *tableLocations;
    NSArray *arrayCurrentLocations;
    

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
    
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)getCurrentLocation
{
   
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
}
-(IBAction)chooseCurrentLocation
{
    
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

-(void)getNearLocation
{
    if(textFldRadius.text==0)
        [[[UIAlertView alloc]initWithTitle:@"Warning !" message:@"Enter The Radius" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
    else{
    NearLocation *location=[[NearLocation alloc]init];
    [location sendCurrentLocation:strLatitude Longtidute:strLongtitude Radius:textFldRadius.text Delegate:self];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
