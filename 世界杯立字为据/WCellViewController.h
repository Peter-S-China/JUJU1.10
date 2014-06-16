//
//  WCellViewController.h
//  JUJU
//
//  Created by linchuanbin on 14-5-29.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "WViewController.h"
#import "EGOImageView.h"

@interface WCellViewController : WViewController<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView * _TitleImage;
    UIImageView * _TeamImage;
    UILabel * hometeam;//主队
    UILabel * visitingteam;//客队
    UILabel * Result;
    EGOImageView * hometeamV;//图标
    EGOImageView * visitingteamV;//图标
    
    ASIFormDataRequest *upLoadRequest;   // 上传请求
    
    UIButton * hometeamBut;
    UIButton * dogfallbut;
    UIButton * visitingteamBut;
    
    UIView * QuizV;
    
    UIView * NamelistV;
    UITableView * Namelist;
    
    NSMutableArray * hometeamArray;
    NSMutableArray * dogfallArray;
    NSMutableArray * visitingteamArray;
    
}

@property(nonatomic, retain)UILabel * hometeam;
@property(nonatomic, retain)UILabel * visitingteam;
@property(nonatomic, retain)EGOImageView * hometeamV;
@property(nonatomic, retain)EGOImageView * visitingteamV;

@end
