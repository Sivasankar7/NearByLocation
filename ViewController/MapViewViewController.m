//
//  MapViewViewController.m
//  New Topic
//
//  Created by Mac on 7/5/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "MapViewViewController.h"
#import <MapKit/MapKit.h>
#import "Annotation.h"

@interface MapViewViewController ()<MKMapViewDelegate,UIActionSheetDelegate>
{
    IBOutlet MKMapView *nearbyMapView;
}
@end

@implementation MapViewViewController

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
    double latitude = [self.strLatitude doubleValue];
    double lontitude = [self.strLongtitude doubleValue];
    CLLocationCoordinate2D coord = {.latitude =  latitude, .longitude =  lontitude};
    MKCoordinateSpan span = {.latitudeDelta =  0.002, .longitudeDelta =  0.002};
    MKCoordinateRegion region = {coord, span};
    [nearbyMapView setRegion:region];

 
    Annotation *annotation = [[Annotation alloc] initWithCoordinate:coord title:@"Alex"];
    [nearbyMapView addAnnotation:annotation];
 

}
- (MKAnnotationView *)mapView:(MKMapView *)_mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *annotationIdentifier = @"annotation";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];   // Reusing
    
    if (!annotationView) {
        MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
        pinView.animatesDrop = YES;
        
        annotationView = pinView;
    }
    else {
        annotationView.annotation = annotation; // Reusing already created pin as UITableViewCell does
    }
    
    return annotationView;
}
-(IBAction)mapType
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select Map Type:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Hyprid Type",
                            @"Satellite Type",
                            @"Standard Type",
                            nil];
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
        nearbyMapView.mapType=MKMapTypeHybrid;
    else if(buttonIndex==1)
        nearbyMapView.mapType=MKMapTypeSatellite;
    else if(buttonIndex==2)
        nearbyMapView.mapType=MKMapTypeStandard;
    
}
-(IBAction)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
