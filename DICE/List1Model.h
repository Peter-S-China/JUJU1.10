//
//  List1Model.h
//  JUJU
//
//  Created by linchuanbin on 14-5-9.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface List1Model : NSObject
{
    NSString * _Name;
    NSString * _NameHead;
    NSString * _GameHead;
}
@property(nonatomic,retain)NSString* Name;
@property(nonatomic,retain)NSString* NameHead;
@property(nonatomic,retain)NSString* GameHead;
@end
