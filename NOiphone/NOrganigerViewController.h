//
//  NOrganigerViewController.h
//  JUJU
//
//  Created by linchuanbin on 14-5-16.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "NophoneViewController.h"

@interface NOrganigerViewController : NophoneViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
     NSTimer * GameOpentime;
     UIButton * _GameOpen;
     UIButton * _GameEnd;
    UIButton * _GameDMX;
    
    NSTimer * JStime;
    NSTimer * DAtatime;
    NSTimer * TTtime;
    ASIFormDataRequest *upLoadRequest;   // 上传请求
    
    UITableView * GameList;
    NSMutableArray * GameListData;
}
@property (nonatomic, retain)UIButton * GameOpen;
@property (nonatomic, retain)UIButton * GameEnd;
@property (nonatomic, retain)UIButton * GameDMX;

@end
