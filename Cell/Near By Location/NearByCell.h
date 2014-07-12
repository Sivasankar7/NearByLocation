//
//  NearByCell.h
//  New Topic
//
//  Created by BLT0003-MACBK on 04/07/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearByCell : UITableViewCell

@property(retain,nonatomic) IBOutlet UILabel *labelTitle;
@property(retain,nonatomic) IBOutlet UILabel *labelAddress;
@property(retain,nonatomic) IBOutlet UIImageView *imageViewLocation;

@end
