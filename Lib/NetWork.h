//
//  NetWork.h
//  LoginFrame
//
//  Created by liuxuxing on 14-2-12.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//  处理网络请求

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

typedef NS_ENUM(NSInteger, RQIdentifier){
    RQIdentifierForGetWeather = 100,
    RQIdentifierForLogin,
    RQIdentifierForRegister,
    RQIdentifierForSendHome,
    RQIdentifierForSendGameNum,
    RQIdentifierForSendGameUser,
    RQIdentifierForSendschedle,
    RQIdentifierForSendteamlogo
};


@protocol NetWorkDelegate <NSObject>
// 请求失败
- (void)requestFailed:(NSError *)error;
@optional
// 获取天气
- (void)finishRequestWithGetWeather:(NSDictionary *)weather;
// 登陆
- (void)finishRequestWithLogin:(NSString *)login;
// 注册
- (void)finishRequestWithRegister:(NSArray *)Register;
//获取房间号
- (void)finishRequestWithSendHome:(NSDictionary *)SendHome;
//获取桌号
- (void)finishRequestWithSendGameNum:(NSDictionary *)SendGameNum;
//获取collectionV1数据
- (void)finishRequestWithSendGameUser:(NSArray *)SendGameUser;
//世界杯数据
- (void)finishRequestWithSendschedle:(NSArray *)Sendschedle;
//世界杯球队图
- (void)finishRequestWithSendteamlogo:(NSArray *)Sendteamlogo;



@end


@interface NetWork : NSObject<ASIHTTPRequestDelegate>
{
    ASIHTTPRequest *asiRequest;
   
}

@property (nonatomic, assign) id<NetWorkDelegate> delegate;

// 传入URL和请求类型  并开始请求数据
- (void)requestWithStrURL:(NSString *)strURL withIdentifier:(RQIdentifier)identifier;

// 检测请求状态
- (void)checkSimple;

//检查请求的状态
- (void)checkRequestStatus;


@end
