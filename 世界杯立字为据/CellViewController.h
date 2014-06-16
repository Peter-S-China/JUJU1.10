//
//  CellViewController.h
//  JUJU
//
//  Created by linchuanbin on 14-5-18.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "WViewController.h"
#import "EGOImageView.h"

@interface CellViewController : WViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIImageView * _TitleImage;
    UIImageView * _TeamImage;
    UILabel * hometeam;//主队
    UILabel * visitingteam;//客队
    EGOImageView * hometeamV;//图标
    EGOImageView * visitingteamV;//图标
    
    UIButton * Tbutton;
    
    UIScrollView * ChoiceScrollV;//选择
    
    UIView * UITableV;
    UITableView * QtableV;
    NSMutableArray * QArray;
    ASIFormDataRequest *upLoadRequest;   // 上传请求
    
    UIView * tchuV;
    
    
}

@property(nonatomic, retain)UILabel * hometeam;
@property(nonatomic, retain)UILabel * visitingteam;
@property(nonatomic, retain)EGOImageView * hometeamV;
@property(nonatomic, retain)EGOImageView * visitingteamV;

@end
