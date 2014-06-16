//
//  GJionViewController.h
//  JUJU
//
//  Created by linchuanbin on 14-5-21.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "GuessViewController.h"

@interface GJionViewController : GuessViewController<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSTimer * OpenTimer;
    NSTimer * Continuetime;
    ASIFormDataRequest * upLoadRequest;   // 上传请求
    UIButton * butPK;
    NSTimer * ENdTimer;
    NSTimer * PKopen;
    
    UITableView  * NameList;
    NSMutableArray * Namedata;
}

@end
