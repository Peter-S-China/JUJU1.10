//
//  WCell.h
//  JUJU
//
//  Created by linchuanbin on 14-5-13.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WModle.h"
#import "EGOImageView.h"

@interface WCell : UITableViewCell
{
    UILabel * hometeam;//主队
    UILabel * visitingteam;//客队
    EGOImageView * hometeamV;//图标
    EGOImageView * visitingteamV;//图标
    WModle * _Data;
}

@property(nonatomic, retain)WModle * Data;
@property(nonatomic, retain)UILabel * hometeam;
@property(nonatomic, retain)UILabel * visitingteam;
@property(nonatomic, retain)EGOImageView * hometeamV;
@property(nonatomic, retain)EGOImageView * visitingteamV;

-(UIView*)getCellView;

@end
