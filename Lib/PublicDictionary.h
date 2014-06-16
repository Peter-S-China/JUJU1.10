//
//  PublicDictionary.h
//  LoginFrame
//
//  Created by liuxuxing on 14-2-17.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicDictionary : NSObject
@property (nonatomic, retain) NSMutableDictionary *dictionary;

+ (NSMutableDictionary *)shareDictionary;

@end
