//
//  RequestLocation.m
//  MyGooi
//
//  Created by BLT0003-MACBK on 04/07/14.
//  Copyright (c) 2014 Vijayakumar. All rights reserved.
//

#import "NearLocation.h"

@implementation NearLocation

-(void)sendLatitude:(NSString*)aLatitude Longtidute:(NSString*)aLongtidute Radius:(NSString*)aRadius Type:(NSString*)aType Delegate:(id<NearLocationDelegate>)delegae;
{
    self.delegae=delegae;
    NSString *str_Object=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%@,%@&radius=%@&types=%@&sensor=false&key=AIzaSyDN1QX-gWUR-mIYo_D21PNFLHHpNQkIkGU",aLatitude,aLongtidute,aRadius,aType];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:str_Object]];
    [request setHTTPMethod:@"GET"];
    NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}
-(void)sendCurrentLocation:(NSString*)aLatitude Longtidute:(NSString*)aLongtidute Radius:(NSString*)aRadius Delegate:(id<NearLocationDelegate>)delegae
{
    self.delegae=delegae;
    NSString *str_Object=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%@,%@&radius=%@&sensor=false&key=AIzaSyDN1QX-gWUR-mIYo_D21PNFLHHpNQkIkGU",aLatitude,aLongtidute,aRadius];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:str_Object]];
    [request setHTTPMethod:@"GET"];
    NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}
#pragma mark Connection
#pragma mark NSURLConnection methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    dataResponse=[[NSMutableData alloc]init];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [dataResponse appendData:data];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [[self delegae] connectionDidLoadResponseFailed:error];
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *respose= [NSJSONSerialization JSONObjectWithData:dataResponse options:kNilOptions error:nil];
    [[self delegae] connectionDidLoadResponse:respose];
}
@end
