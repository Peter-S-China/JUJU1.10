//
//  FJionViewController.m
//  JUJU
//
//  Created by linchuanbin on 14-5-10.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "FJionViewController.h"
#import "AdventViewController.h"

@interface FJionViewController ()

@end

@implementation FJionViewController
static RQIdflower ident;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.Button.bounds = CGRectMake(0, 0, 170, 80);
    [self.Button setImage:[UIImage imageNamed:@"Fjion.PNG"] forState:UIControlStateNormal];
    self.Button.userInteractionEnabled = NO;
    self.Button.alpha = 0.0;
    
    _MYbutton = [[UIButton alloc]initWithFrame:self.Button.frame];
    _MYbutton.alpha = 0.0;
    _MYbutton.userInteractionEnabled = NO;
    [self.view addSubview:_MYbutton];
    
    
    _chattime = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollTimer)userInfo:nil repeats:YES];
    //[_chattime setFireDate:[NSDate date]];//继续
    //[_chattime setFireDate:[NSDate distantFuture]];//暂停
    

    //setUserInteractionEnabled

        // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)scrollTimer
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString * usergamehomenum = [defaults objectForKey:@"usergamehomenum"];//根据键值取出usergamehomenum桌号
    ident = RQIdentifierForSenddrumflowerWait;
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SenddrumflowerinfoURL]];
    [upLoadRequest setPostValue:usergamehomenum forKey:@"gamehomenum"];//桌名
    [upLoadRequest setPostValue:@"2" forKey:@"istimeover"];//1 开始 0 结束 2 参与
    [upLoadRequest setPostValue:@"1" forKey:@"gameuserid"];//身份标识
    [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];//id
    
    
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];

}

//-----------------------

-(void)ButtonBut
{
    NSLog(@"开始 传");
    
}

-(void)AdventureBut
{
    NSLog(@"大冒险");
    
    AdventViewController * AdventV = [[AdventViewController alloc] init];
    [self.navigationController pushViewController:AdventV animated:YES];
}

//-------------------

//-------------上传信息-------------

#pragma mark - ASIHttpDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *str = [request responseString];
    NSLog(@"击鼓传花 传 request = %@",str);
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString * FuserID = [defaults objectForKey:@"_userID"];//ID
    switch (ident) {
        case RQIdentifierForSenddrumflowerPass:
        {
            [_chattime setFireDate:[NSDate date]];//继续
            NSLog(@"击鼓传花传 = %@",str);
        } break;
        case RQIdentifierForSenddrumflowerWait:
        {
            NSLog(@"击鼓传花查 = %@",str);
            if([[dictionary objectForKey:@"randomid"] intValue] == [FuserID intValue])
            {
                _MYbutton.alpha = 1.0;
                _MYbutton.userInteractionEnabled = YES;
                [_MYbutton setImage:[UIImage imageNamed:@"Fjion.PNG"] forState:UIControlStateNormal];
                [_MYbutton addTarget:self action:@selector(Fbutton) forControlEvents:UIControlEventTouchUpInside];
                [_chattime setFireDate:[NSDate distantFuture]];//暂停
                [UIView animateWithDuration:1 animations:^{
                    self.flowerV.frame = CGRectMake(91.5,320, 135, 135);
                } completion:^(BOOL finished){
                    //self.flowerV.frame = CGRectMake(-200,500, 135, 135);
                }];

            }
           
            //if()
            
        }break;
        default:
            break;
    }

    
}



//上传失败
- (void)upLoadFailed:(ASIHTTPRequest *)request
{
    //[activityView hidden];
//    MyAlertView *alert = [[MyAlertView alloc] initWithTitle:@"提示" contentText:@"加入游戏数据失败！" leftButtonTitle:nil rightButtonTitle:nil addkAlertHeight:100.0];
//    [alert show];
    
    // [alert release];
    
    NSString *str = [request responseString];
    NSLog(@"str = %@",str);
}

-(void)Fbutton
{
    NSLog(@"传");
    
    [UIView animateWithDuration:1 animations:^{
        self.flowerV.frame = CGRectMake(500,100, 135, 135);//CGRectMake(91.5,320, 135, 135)
    } completion:^(BOOL finished){
        self.flowerV.frame = CGRectMake(-200,500, 135, 135);
    }];

    _MYbutton.alpha = 0.0;
    _MYbutton.userInteractionEnabled = NO;
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString * usergamehomenum = [defaults objectForKey:@"usergamehomenum"];//根据键值取出usergamehomenum桌号
    
    ident = RQIdentifierForSenddrumflowerPass;
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SenddrumflowerinfoURL]];
    [upLoadRequest setPostValue:usergamehomenum forKey:@"gamehomenum"];//桌名
    [upLoadRequest setPostValue:@"3" forKey:@"istimeover"];//1 开始 0 结束 2 参与 3传
    [upLoadRequest setPostValue:@"1" forKey:@"gameuserid"];//身份标识
    [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];//id
    
    
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];
}


-(void)ReturnBut
{
    NSLog(@"MyReturn");
    [_chattime setFireDate:[NSDate distantFuture]];
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择游戏退出还是挂起！" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"挂起", nil];
    [alertView show];

    
    
    // NSLog(@"count = %D",[self.navigationController.viewControllers count]);
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        //退出
        ident =  RQIdentifierForExitgamehome;
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:ExitgamehomeURL]];
        [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
        [upLoadRequest setPostValue:[defaults objectForKey:@"usergamehomenum"]  forKey:@"gamehomenum"];
        [upLoadRequest setPostValue:@"1" forKey:@"gameuserid"];
        
        [upLoadRequest setTimeOutSeconds:0.5f];//设置超时秒
        upLoadRequest.delegate = self;
        [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
        
        [upLoadRequest startAsynchronous];
        
    }else {
        //挂起
        ident =  RQIdentifierForHoldgame;
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:HoldgameURL]];
        [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
        [upLoadRequest setPostValue:[defaults objectForKey:@"usergamehomenum"]  forKey:@"gamehomenum"];
        //[upLoadRequest setPostValue:@"0" forKey:@"gameuserid"];
        
        [upLoadRequest setTimeOutSeconds:0.5f];//设置超时秒
        upLoadRequest.delegate = self;
        [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
        
        [upLoadRequest startAsynchronous];
        
    }
    
    [_FcloudBGV removeFromSuperview];
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: ([self.navigationController.viewControllers count] -2)] animated:YES];
}




@end
