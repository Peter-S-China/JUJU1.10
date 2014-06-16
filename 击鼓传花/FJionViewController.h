//
//  FJionViewController.h
//  JUJU
//
//  Created by linchuanbin on 14-5-10.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "FlowerViewController.h"

@interface FJionViewController : FlowerViewController<UIAlertViewDelegate>
{
    ASIFormDataRequest *upLoadRequest;   // 上传请求
     NSTimer * _chattime;
    UIButton * _MYbutton;
    UILabel * _Datashu;
}
@end
