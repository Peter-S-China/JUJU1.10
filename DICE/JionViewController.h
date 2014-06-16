//
//  JionViewController.h
//  Dice
//
//  Created by linchuanbin on 14-4-30.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//  加入者

#import <UIKit/UIKit.h>

@interface JionViewController : MyViewController<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView * _Gameresult;
    UITableView * _Namelist;
    ASIFormDataRequest *upLoadRequest;   // 上传请求
    NSMutableArray * _Namelietdata;
    NSTimer * _chattime;

}

@end
