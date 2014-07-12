//
//  HomeViewController.m
//  NearByLocation
//
//  Created by Mac on 7/12/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "HomeViewController.h"
#import "MenuLocationViewController.h"
#import "FindWayViewController.h"
@interface HomeViewController ()
{
    
}
@end

@implementation HomeViewController

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
-(IBAction)searchPublicPlace
{
    MenuLocationViewController *menu=[[MenuLocationViewController alloc]initWithNibName:@"MenuLocationViewController" bundle:nil];
    [self.navigationController pushViewController:menu animated:YES];
}
-(IBAction)findWay
{
    FindWayViewController *findWay=[[FindWayViewController alloc]initWithNibName:@"FindWayViewController" bundle:nil];
    [self.navigationController pushViewController:findWay animated:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
