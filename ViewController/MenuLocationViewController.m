//
//  MenuLocationViewController.m
//  New Topic
//
//  Created by BLT0003-MACBK on 04/07/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "MenuLocationViewController.h"
#import "NearByViewController.h"

#import "MenuLocation.h"

@interface MenuLocationViewController ()
{
    IBOutlet UITableView *tableViewLoaction;
    NSArray *arrayLocation,*arrayMenuLocation;
}
@end

@implementation MenuLocationViewController

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
    
    [tableViewLoaction registerNib:[UINib nibWithNibName:@"MenuLocation" bundle:nil] forCellReuseIdentifier:@"MenuLocation"];

    arrayLocation=[[NSArray alloc]initWithObjects:@"lodging",@"establishment",@"restaurant",@"school",@"library",@"shopping_mall",@"church",@"place_of_worship",@"university",@"park",@"museum",@"spa",nil];
        arrayMenuLocation=[[NSArray alloc]initWithObjects:@"Lodging", @"Establishment",@"Restaurant",@"School",@"Library",@"Shopping Mall",@"Church",@"Place of Worship",@"University",@"Park",@"Museum",@"Spa",nil];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return arrayLocation.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MenuLocation*  cell=(MenuLocation*)[tableView dequeueReusableCellWithIdentifier:@"MenuLocation"];
    cell.labelTitle.text=[arrayMenuLocation objectAtIndex:indexPath.row];
    cell.imageViewIcon.image=[UIImage imageNamed:[arrayMenuLocation objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NearByViewController *near=[[NearByViewController alloc]initWithNibName:@"NearByViewController" bundle:nil];
    near.strLocationType=[arrayLocation objectAtIndex:indexPath.row];
    near.strTitle=[arrayMenuLocation objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:near animated:YES];
    
}
#pragma mark Button Action
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
