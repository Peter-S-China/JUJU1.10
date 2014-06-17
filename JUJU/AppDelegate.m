//
//  AppDelegate.m
//  JUJU
//
//  Created by linchuanbin on 14-4-22.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"
#import "LandViewController.h"

#import "NOrganigerViewController.h"


@implementation AppDelegate

static RQIdflower ident;

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    //[WXApi registerApp:@"wxd930ea5d5a258f4f" withDescription:@"demo 2.0"];
    
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
        
    {
        
        [self prefersStatusBarHidden];
        
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];//隐藏状态栏
        
    }

        LandViewController * LandV = [[LandViewController alloc] init];
        UINavigationController * Nav = [[UINavigationController alloc] initWithRootViewController:LandV];
        
        self.window.rootViewController = Nav;
    
    [self.window makeKeyAndVisible];
    return YES;
}

//------------------

#pragma mark -   activityView.delegate代理方法 加载试图
- (void)CancelTab:(BOOL)tab
{
    NSLog(@"=%@=",tab ? @"YES":@"NO");//YES是放弃加载 NO是加载完成
    if(tab) [upLoadRequest clearDelegatesAndCancel];
    
    LandViewController * LandV = [[LandViewController alloc] init];
    UINavigationController * Nav = [[UINavigationController alloc] initWithRootViewController:LandV];
    
    self.window.rootViewController = Nav;
    
    //[upLoadRequest cancel];//[netWork checkSimple];//取消加载
}



//-------------上传信息-------------

#pragma mark - ASIHttpDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    //反馈数据
    [activityView hidden];
    NSString *str = [request responseString];
    NSLog(@"return  = %@",str);
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
               //登陆
            if(1 == [[dictionary objectForKey:@"loginresult"] intValue])
            {
                NSLog(@"登录成功");
                
                LandViewController * LandV = [[LandViewController alloc] init];
                UINavigationController * Nav = [[UINavigationController alloc] initWithRootViewController:LandV];
                
                self.window.rootViewController = Nav;
                
                MenuViewController * MenuV = [[MenuViewController alloc] init];
                [LandV.navigationController pushViewController:MenuV animated:YES];
                
            }else{
                LandViewController * LandV = [[LandViewController alloc] init];
                UINavigationController * Nav = [[UINavigationController alloc] initWithRootViewController:LandV];
                
                self.window.rootViewController = Nav;

            }
    
    NSLog(@"dictionary = %@  ,%@",dictionary,[dictionary objectForKey:@"error"]);
    
}

//上传失败
- (void)upLoadFailed:(ASIHTTPRequest *)request
{
    
    LandViewController * LandV = [[LandViewController alloc] init];
    UINavigationController * Nav = [[UINavigationController alloc] initWithRootViewController:LandV];
    
    self.window.rootViewController = Nav;
    // [alert release];
    
    NSString *str = [request responseString];
    NSLog(@"str = %@",str);
}



//-=--------------------------


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //Dice:X application 申请调用这应用的表格
    NSLog(@"application = %@,url = %@",sourceApplication,url);
    
   
    //return [WeiboSDK handleOpenURL:url delegate:self];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"applicationWillResignActive");//近来后台
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"0" forKey:@"NOphoneEND"];//Nophone结束标记
    //[defaults setObject:@"1" forKey:@"_Roomnumber"];
    [defaults synchronize];//用synchronize方法把数据持久化到standardUserDefaults数据库
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
     NSLog(@"applicationDidEnterBackground");// 当程序将要退出前调用 时间最长5秒
    
//    ident =  RQIdentifierForExithome;
//    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
//    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:ExithomeURL]];
//    [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
//    [upLoadRequest setTimeOutSeconds:2.f];//设置超时秒
//    upLoadRequest.delegate = self;
//    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
//    
//    [upLoadRequest startAsynchronous];
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
     NSLog(@"applicationWillEnterForeground");
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
     NSLog(@"applicationDidBecomeActive");//前台
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
     //NSLog(@"applicationWillTerminate");//当程序将要退出是被调用
//    ident =  RQIdentifierForExithome;
//    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
//    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:ExithomeURL]];
//    [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
//    [upLoadRequest setTimeOutSeconds:2.f];//设置超时秒
//    upLoadRequest.delegate = self;
//    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
//    
//    [upLoadRequest startAsynchronous];
    
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"1" forKey:@"_Roomnumber"];

     NSLog(@"applicationWillTerminate");//当程序将要退出是被调用

    
    //这样可以让你可以做一些清理工作。你可以保存一些数据或app的状态。这个方法也有5秒钟的限制。超时后方法会返回程序从内存中清除。
    //注意：用户可以手工关闭应用程序。
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
