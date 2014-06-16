//
//  WJionViewController.h
//  JUJU
//
//  Created by linchuanbin on 14-5-13.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//  


#import "WViewController.h"

@interface WJionViewController : WViewController<UITableViewDataSource,UITableViewDelegate,NetWorkDelegate,ASIHTTPRequestDelegate,ActivityViewDelegate>
{
    UITableView * _WorldCuplist;//世界杯
    UIImageView * _WorldCupBG;//世界杯 背景
    NSMutableArray * _WorldCupdata;
    NSMutableArray * _WorldCupDATA;
    NSMutableArray * _WorldTU;
    UIView * tableV;
    
    NetWork * netWork;
    RQIdentifier rqIdentifier;
    ActivityView *activityView;
    int WorldData[30];
    
    ASIFormDataRequest *upLoadRequest;   // 上传请求
    
    NSMutableDictionary * ModleDict;
    
    
    UIButton * headlineBUt;
    UIButton * endBUt1;
    UIButton * openBUt1;
    
    
}

@end
