//
//  List1Model.m
//  JUJU
//
//  Created by linchuanbin on 14-5-9.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "List1Model.h"

@implementation List1Model
@synthesize  Name = _Name, NameHead = _NameHead, GameHead = _GameHead;

-(void)dealloc
{
    [_Name release];
    [_NameHead release];
    [_GameHead release];
    
    [super dealloc];
}
@end
