//
//  APIS.h
//  LoginFrame
//
//  Created by liuxuxing on 14-2-17.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//
//外网端口 124.127.127.186:6666 测试端口10.0.0.77:8080
#define BaseURL @"http://124.127.127.186:6666/"

typedef NS_ENUM(NSInteger, RQIdflower){
    RQIdentifierForSenddrumflowerStart = 100,
    RQIdentifierForSenddrumflowerWait,
    RQIdentifierForSenddrumflowerPass,
    RQIdentifierForSenddrumflowerEnd,
    RQIdentifierForCreatehome,
    RQIdentifierForSendnum,
    RQIdentifierForLoginservlet,
    RQIdentifierForExithome,
    RQIdentifierForSendUserinfo,
    RQIdentifierForGameinfolist,
    RQIdentifierForGameUserinfo,
    RQIdentifierForGetMessage,
    RQIdentifierForSendMessage,
    RQIdentifierForGetnophonecover,
    RQIdentifierForSendnophonecover,
    RQIdentifierForStartnophone,
    RQIdentifierForGetuseroutcome,
    RQIdentifierForSenduseroutcome,
    RQIdentifierForExitgamehome,
    RQIdentifierForHoldgame,
    RQIdentifierForSingleadventure,
    RQIdentifierForStartfingerguess,
    RQIdentifierForGetguesscover,
    RQIdentifierForGetguessflag,
    RQIdentifierForSendguesscover,
    RQIdentifierForContinueguess,
    RQIdentifierForGetnophoneflag,
    RQIdentifierForGetjoin,
    RQIdentifierForSendjoin,
    RQIdentifierForExitjoin,
    RQIdentifierForPersonnum,
    RQIdentifierForSendbosonsNum,
    RQIdentifierForGetbosonsCover,
    RQIdentifierForUpdateuseroutcome,
    RQIdentifierForSendisbeginschedle,
    RQIdentifierForChangeimg
};


// 登陆 http://10.0.0.61:33/index/JsonData.aspx?logid=abc&logpwd=123456
#define LoginURL(ID,passW) [NSString stringWithFormat:@"%@index/JsonData.aspx?logid=%@&logpwd=%@",BaseURL,ID,passW]
// 天气
#define WeatherURL(cityId) [NSString stringWithFormat:@"http://www.weather.com.cn/data/cityinfo/%@.html",cityId]
// 注册   http://10.0.0.61:33/index/JsonData.aspx?MINIRegister=abc  M_UserName 用户名  M_Pwd 密码  M_RequestCode 邀请码
#define RegisterURL(ID)    [NSString stringWithFormat:@"%@index/JsonData.aspx?MINIRegister=%@",BaseURL,ID]


// －－－－－－－－－－－－－主页－－－－－－－－－－－－－－－－－－－
// 获取房间号 http://10.0.0.250:6666/JujuDemo/servlet/SendHomenum
#define SendHomeURL [NSString stringWithFormat:@"%@JujuDemo/servlet/SendHomenum",BaseURL]

// 获取桌号 http://10.0.0.77:8080/JujuDemo/servlet/SendGameNum
#define SendGameNumURL [NSString stringWithFormat:@"%@JujuDemo/servlet/SendGameNum",BaseURL]

// 获取collectionV1数据 http://10.0.0.77:8080/JujuDemo/servlet/SendGameUserinfo

#define SendGameUserURL [NSString stringWithFormat:@"%@JujuDemo/servlet/SendGameUserinfo",BaseURL]


// 创建房间 和加入房间 http://10.0.0.77:8080/JujuDemo/servlet/Createhome
#define CreatehomeURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Createhome",BaseURL]

// 退出房间 http://10.0.0.77:8080/JujuDemo/servlet/Exithome
#define ExithomeURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Exithome",BaseURL]

// 获取验证码 http://10.0.0.77:8080/JujuDemo/servlet/sendnum
#define SendnumURL [NSString stringWithFormat:@"%@JujuDemo/servlet/sendnum",BaseURL]

// 登陆  http://10.0.0.77:8080/JujuDemo/servlet/Loginservlet
#define LoginservletURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Loginservlet",BaseURL]

// 获取房间内的用户名单  http://10.0.0.77:8080/JujuDemo/servlet/SendUserinfo
#define SendUserinfoURL [NSString stringWithFormat:@"%@JujuDemo/servlet/SendUserinfo",BaseURL]

// 创建游戏，加入游戏 http://10.0.0.77:8080/JujuDemo/servlet/GameUserinfo
#define GameUserinfoURL [NSString stringWithFormat:@"%@JujuDemo/servlet/GameUserinfo",BaseURL]

// 获取XXX游戏list http://10.0.0.77:8080/JujuDemo/servlet/Gameinfolist
#define GameinfolistURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Gameinfolist",BaseURL]

// 聊天数据上传接口 http://10.0.0.77:8080/JujuDemo/servlet/GetMessage 一个房间号：homenum 一个信息：message
#define GetMessageURL [NSString stringWithFormat:@"%@JujuDemo/servlet/GetMessage",BaseURL]

// 聊天数据下载接口 http://10.0.0.77:8080/JujuDemo/servlet/SendMessage 一个房间号：homenum
#define SendMessageURL [NSString stringWithFormat:@"%@JujuDemo/servlet/SendMessage",BaseURL]


// 退出游戏 http://10.0.0.77:8080/JujuDemo/servlet/Exitgamehome
#define ExitgamehomeURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Exitgamehome",BaseURL]

//挂起接口 http://10.0.0.77:8080/JujuDemo/servlet/Holdgame

#define HoldgameURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Holdgame",BaseURL]


//邀请信息   http://10.0.0.77:8080/JujuDemo/servlet/Getjoin  邀请人id：mainid,被邀请人的id：id，桌号：gamehomenum,游戏名：gamename
#define  GetjoinURL  [NSString stringWithFormat:@"%@JujuDemo/servlet/Getjoin",BaseURL]


//实时访问邀请信息的接口    http://10.0.0.77:8080/JujuDemo/servlet/Sendjoin  要一个字段id
#define  SendjoinURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Sendjoin",BaseURL]

//拒绝邀请的接口   http://10.0.0.77:8080/JujuDemo/servlet/Exitjoin  两个字段：id,gamehomenum
#define ExitjoinURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Exitjoin",BaseURL]


// 实时返回游戏人数的接口 http://10.0.0.77:8080/JujuDemo/servlet/Personnum  要一个参数gamehomenum

#define PersonnumURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Personnum",BaseURL]


// 修改头像 http://10.0.0.77:8080/JujuDemo/servlet/Changeimg
#define ChangeimgURL   [NSString stringWithFormat:@"%@JujuDemo/servlet/Changeimg",BaseURL]







//---------------------DICE---------------
//获取游戏结果list http://10.0.0.77:8080/JujuDemo/servlet/SendbosonsCover

#define SendbosonsCoverURL [NSString stringWithFormat:@"%@JujuDemo/servlet/SendbosonsCover",BaseURL]


//上传筛子数 http://10.0.0.77:8080/JujuDemo/servlet/GetbosonsNum

#define GetbosonsNumURL [NSString stringWithFormat:@"%@JujuDemo/servlet/GetbosonsNum",BaseURL]

//上传筛子 结果 http://10.0.0.77:8080/JujuDemo/servlet/GetbosonsCover

#define GetbosonsCoverURL [NSString stringWithFormat:@"%@JujuDemo/servlet/GetbosonsCover",BaseURL]

//获取筛子数目  http://10.0.0.77:8080/JujuDemo/servlet/SendbosonsNum

#define SendbosonsNumURL [NSString stringWithFormat:@"%@JujuDemo/servlet/SendbosonsNum",BaseURL]

//-----------------------击鼓传花------------------------

//产生随机数（传花） http://10.0.0.77:8080/JujuDemo/servlet/Senddrumflowerinfo

#define SenddrumflowerinfoURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Senddrumflowerinfo",BaseURL]


//-----------------------世界杯---------------------------
//世界杯数据 http://10.0.0.77:8080/JujuDemo/servlet/Sendschedle

#define SendschedleURL  [NSString stringWithFormat:@"%@JujuDemo/servlet/Sendschedle",BaseURL]

//球队图 http://10.0.0.77:8080/JujuDemo/servlet/Sendteamlogo
#define SendteamlogoURL  [NSString stringWithFormat:@"%@JujuDemo/servlet/Sendteamlogo",BaseURL]

// 世界杯上传数据的接口 http://10.0.0.77:8080/JujuDemo/servlet/Getuseroutcome

#define GetuseroutcomeURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Getuseroutcome",BaseURL]

// 我给你发送数据的接口  http://10.0.0.77:8080/JujuDemo/servlet/Senduseroutcome

#define SenduseroutcomeURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Senduseroutcome",BaseURL]

//  删除评论接口  http://10.0.0.77:8080/JujuDemo/servlet/Updateuseroutcome

#define UpdateuseroutcomeURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Updateuseroutcome",BaseURL]

// 1是未结束，0是结束 http://10.0.0.77:8080/JujuDemo/servlet/Sendisbeginschedle  isbegin
#define SendisbeginschedleURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Sendisbeginschedle",BaseURL]


//----------------------NO phone----------------------------
//上传NO Phone 结果  http://10.0.0.77:8080/JujuDemo/servlet/Getnophonecover  用户id，userid 桌号id：gamehomenum 结果：nophonecover
#define GetnophonecoverURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Getnophonecover",BaseURL]

//获取NO Phone 结果    http://10.0.0.77:8080/JujuDemo/servlet/Sendnophonecover 桌号id：gamehomenum
#define SendnophonecoverURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Sendnophonecover",BaseURL]


//NO Phone 时时查询 http://10.0.0.77:8080/JujuDemo/servlet/Startnophone

#define StartnophoneURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Startnophone",BaseURL]

// NO Phone 开始 http://10.0.0.77:8080/JujuDemo/servlet/Getnophoneflag  gamehomenum nophoneflag
#define GetnophoneflagURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Getnophoneflag",BaseURL]


// ----------------------------------------------------------------
//大冒险接口 http://10.0.0.77:8080/JujuDemo/servlet/Singleadventure

#define SingleadventureURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Singleadventure",BaseURL]

//---------------------------------------------------------------
//开始 http://10.0.0.77:8080/JujuDemo/servlet/Getguessflag  gamehomenum  guessflag  用户信息 = {"guessflag":"1"}

#define GetguessflagURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Getguessflag",BaseURL]

// 时时获取 http://10.0.0.77:8080/JujuDemo/servlet/Startfingerguess  桌号，游戏是否开始，身份标识 gamehomenum，isgameover  gameuserid {"guessflag":"1"}
#define StartfingerguessURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Startfingerguess",BaseURL]


// 上传结果 http://10.0.0.77:8080/JujuDemo/servlet/Getguesscover  id，gamehomenum，guesscover

#define GetguesscoverURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Getguesscover",BaseURL]

// 返回列表的接口 http://10.0.0.77:8080/JujuDemo/servlet/Sendguesscover  flag和gamehomenum isget

#define SendguesscoverURL [NSString stringWithFormat:@"%@JujuDemo/servlet/Sendguesscover",BaseURL]


//继续pk的接口1 0   http://10.0.0.77:8080/JujuDemo/servlet/Continueguess  id，gamehomenum，timeflag 1 0

#define ContinueguessURL  [NSString stringWithFormat:@"%@JujuDemo/servlet/Continueguess",BaseURL]







