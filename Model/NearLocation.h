//
//  RequestLocation.h
//  MyGooi
//
//  Created by BLT0003-MACBK on 04/07/14.
//  Copyright (c) 2014 Vijayakumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NearLocationDelegate <NSObject>
@optional
- (void)connectionDidLoadResponse:(id)response;
- (void)connectionDidLoadResponseFailed:(NSError*)error;
@end
@interface NearLocation : NSObject
{
    NSMutableData *dataResponse;
}
-(void)sendLatitude:(NSString*)aLatitude Longtidute:(NSString*)aLongtidute Radius:(NSString*)aRadius Type:(NSString*)aType Delegate:(id<NearLocationDelegate>)delegae;
-(void)sendCurrentLocation:(NSString*)aLatitude Longtidute:(NSString*)aLongtidute Radius:(NSString*)aRadius Delegate:(id<NearLocationDelegate>)delegae;

@property(retain,nonatomic) id<NearLocationDelegate> delegae;
@end
