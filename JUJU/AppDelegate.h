//
//  AppDelegate.h
//  JUJU
//
//  Created by linchuanbin on 14-4-22.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,ASIHTTPRequestDelegate,ActivityViewDelegate>
{
    ActivityView *activityView;
     ASIFormDataRequest *upLoadRequest;   // 上传请求
}

@property (strong, nonatomic) UIWindow *window;

@end
