//
//  GorganigerViewController.h
//  JUJU
//
//  Created by linchuanbin on 14-5-21.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "GuessViewController.h"

@interface GorganigerViewController : GuessViewController<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    ASIFormDataRequest *upLoadRequest;   // 上传请求
    NSTimer * Continuetime;
    UIButton * butPK;
    
    
    UITableView  * Namelist;
    NSMutableArray * Namedata;
    NSTimer * ENdTimer;
    
    NSTimer * PKopen;
    

}
@end
