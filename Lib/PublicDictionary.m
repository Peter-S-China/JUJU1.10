//
//  PublicDictionary.m
//  LoginFrame
//
//  Created by liuxuxing on 14-2-17.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "PublicDictionary.h"

@implementation PublicDictionary

- (void)dealloc
{
    [_dictionary release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+ (NSMutableDictionary *)shareDictionary
{
    static PublicDictionary *publicDictionary;
    
    if (!publicDictionary) {
        publicDictionary = [[PublicDictionary alloc] init];
    }
    return publicDictionary.dictionary;
}

@end
