//
//  WModle.h
//  JUJU
//
//  Created by linchuanbin on 14-5-13.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WModle : NSObject
{
    NSString * _Home_team;//主队
    NSString * _Visiting_team;//客队
    NSString * _HometeamURL;
    NSString * _VisitingURL;
    NSString * _Result;//结果
    NSString * _TimeDate;
    NSString * _Home_teamlist;
    NSString * _Visiting_teamlist;
}

@property(nonatomic,retain)NSString * Home_team;
@property(nonatomic,retain)NSString * Visiting_team;
@property(nonatomic,retain)NSString * HometeamURL;
@property(nonatomic,retain)NSString * VisitingURL;
@property(nonatomic,retain)NSString * Result;
@property(nonatomic,retain)NSString * TimeDate;
@property(nonatomic,retain)NSString * Home_teamlist;
@property(nonatomic,retain)NSString * Visiting_teamlist;

@end
