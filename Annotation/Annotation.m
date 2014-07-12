//
//  myAnnotation.m
//  MapView
//
//  Created by dev27 on 5/30/13.
//  Copyright (c) 2013 codigator. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation

//3.2
-(id) initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title {
  if ((self = [super init])) {
    self.coordinate =coordinate;
    self.strTitle = title;
  }
  return self;
}

@end
