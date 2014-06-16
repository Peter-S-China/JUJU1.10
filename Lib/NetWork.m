//
//  NetWork.m
//  LoginFrame
//
//  Created by liuxuxing on 14-2-12.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "NetWork.h"

#import "Reachability.h"


@implementation NetWork

static RQIdentifier ident;

- (void)dealloc
{
    [asiRequest release];
    [super dealloc];
}

- (void)requestWithStrURL:(NSString *)strURL withIdentifier:(RQIdentifier)identifier
{
    ident = identifier;

    NSLog(@"strUrl = %@",strURL);
    
    // url编码
    NSString *encodeURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"encodeUrl = %@",encodeURL);
    
    NSURL *url = [NSURL URLWithString:encodeURL];
    
    asiRequest = [ASIHTTPRequest requestWithURL:url];
    
    asiRequest.delegate = self;
    
    //    asiRequest.showAccurateProgress = YES;
    
    [asiRequest retain];
    
    [asiRequest startAsynchronous];
}


#pragma mark - ASIHTTPRequest代理方法
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *str = [request responseString];
    
    NSLog(@"str = %@",str);
    
    //    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //NSMutableString *result = [[NSMutableString alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];

    
    if (str) {
        if ( ident == RQIdentifierForRegister || ident == RQIdentifierForSendGameUser  || ident == RQIdentifierForSendschedle || ident == RQIdentifierForSendteamlogo) {//ident == RQIdentifierForProductList ||
            array = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        } else if (ident == RQIdentifierForLogin) {
           NSLog(@"str = %@",str);
        } else {
            dictionary = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            
            NSLog(@"dictionary = %@",dictionary);
        }
        
        switch (ident) {
            case RQIdentifierForGetWeather:
                [self.delegate finishRequestWithGetWeather:dictionary];
                break;
            case RQIdentifierForLogin:
                [self.delegate finishRequestWithLogin:str];
                break;
            case RQIdentifierForRegister:
                [self.delegate finishRequestWithRegister:array];
                break;
            case RQIdentifierForSendHome:
                [self.delegate finishRequestWithSendHome:dictionary];
                break;
            case RQIdentifierForSendGameNum:
                [self.delegate finishRequestWithSendGameNum:dictionary];
                break;
            case RQIdentifierForSendGameUser:
                [self.delegate finishRequestWithSendGameUser:array];
                break;
            case RQIdentifierForSendschedle:
                [self.delegate finishRequestWithSendschedle:array];
                break;
                case RQIdentifierForSendteamlogo:
                [self.delegate finishRequestWithSendteamlogo:array];
                break;
            default:
                break;
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(requestFailed:)]) {
            [self.delegate requestFailed:nil];
        }
    }
}

#pragma mark 请求失败
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    [self.delegate requestFailed:error];
}

#pragma mark 取消请求
- (void)checkSimple
{
    if (![asiRequest isFinished]) {
        [asiRequest cancel];
        [asiRequest clearDelegatesAndCancel];
    }
}

- (void)checkRequestStatus
{
    [self checkSimple];
    [asiRequest release];
}



@end
