//
//  WModle.m
//  JUJU
//
//  Created by linchuanbin on 14-5-13.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "WModle.h"

@implementation WModle

@synthesize Home_team = _Home_team, HometeamURL = _HometeamURL, Visiting_team = _Visiting_team, VisitingURL = _VisitingURL,Result = _Result, TimeDate = _TimeDate, Home_teamlist = _Home_teamlist, Visiting_teamlist = _Visiting_teamlist ;

-(void)dealloc
{
    [_Home_team release];
    [_HometeamURL release];
    [_Visiting_team release];
    [_VisitingURL release];
    [_Result release];
    [_TimeDate release];
    [_Home_teamlist release];
    [_Visiting_teamlist release];
    
    [super dealloc];
}

@end
