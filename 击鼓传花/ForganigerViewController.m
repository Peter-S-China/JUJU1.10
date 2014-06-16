//
//  ForganigerViewController.m
//  JUJU
//
//  Created by linchuanbin on 14-5-10.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "ForganigerViewController.h"
#import "AdventViewController.h"

@interface ForganigerViewController ()

@end

@implementation ForganigerViewController


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

//-------------上传信息-------------

#pragma mark - ASIHttpDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *str = [request responseString];
    NSLog(@"击鼓传花request = %@",str);
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString * FuserID = [defaults objectForKey:@"_userID"];//ID
    switch (ident) {
        case RQIdentifierForSenddrumflowerStart:
        {
            NSLog(@"击鼓传花开始 = %@",str);
            
            
            if([[dictionary objectForKey:@"randomid"] intValue] == 0)
            {
            
                
               

                [UIView animateWithDuration:5 animations:^{
                    hop = [[UILabel alloc] init];
                    hop.center = self.view.center;
                    hop.bounds = CGRectMake(0, 0, 240, 30);
                    hop.text = @"您好这游戏不可以单人玩！";
                    hop.backgroundColor = [UIColor clearColor];
                    [self.view addSubview:hop];
                                    } completion:^(BOOL finished){
                    [hop removeFromSuperview];
                   self.Button.alpha = 1.0;
                   self.Button.userInteractionEnabled = YES;
                   [_chattime setFireDate:[NSDate date]];//暂停
                    
                }];
                
                
            }else
            {
                
                srand((unsigned)time(0));  //不加这句每次产生的随机数不变
                int result1 = (rand() % 30 + 30);  //产生60～的数
                _chattime = [NSTimer scheduledTimerWithTimeInterval:result1 target:self selector:@selector(scrollTimer)userInfo:nil repeats:YES];
                [_chattime1 setFireDate:[NSDate date]];//继续
//            if([[dictionary objectForKey:@"randomid"] intValue] == [FuserID intValue])
//            {
//                [_chattime setFireDate:[NSDate date]];//继续
//                [UIView animateWithDuration:1 animations:^{
//                    self.flowerV.frame = CGRectMake(91.5,320, 135, 135);
//                } completion:^(BOOL finished){
//                }];
//                
//                _MYbutton.alpha = 1.0;
//                _MYbutton.userInteractionEnabled = YES;
//                [_MYbutton setBackgroundImage:[UIImage imageNamed:@"Fjion.PNG"] forState:UIControlStateNormal];
//                [_MYbutton addTarget:self action:@selector(Fbutton) forControlEvents:UIControlEventTouchUpInside];
//            }else{
//                [_chattime1 setFireDate:[NSDate date]];//继续
//                [_chattime setFireDate:[NSDate date]];//继续
//            }
            }
        }
            break;
         case RQIdentifierForSenddrumflowerEnd:
        {
            NSLog(@"击鼓传花结束 = %@",str);
            [_chattime1 setFireDate:[NSDate distantFuture]];//暂停
            
            _MYbutton.alpha = 1.0;
            _MYbutton.userInteractionEnabled = YES;
            [_MYbutton setBackgroundImage:[UIImage imageNamed:@"Flai.PNG"] forState:UIControlStateNormal];
            [_MYbutton addTarget:self action:@selector(Flai) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
            case RQIdentifierForSenddrumflowerPass:
        {
            [_chattime1 setFireDate:[NSDate date]];//继续
             NSLog(@"击鼓传花传 = %@",str);
        } break;
            case RQIdentifierForSenddrumflowerWait:
        {
            NSLog(@"击鼓传花查 = %@",str);
            if([[dictionary objectForKey:@"randomid"] intValue] == [FuserID intValue])
            {
                [UIView animateWithDuration:1 animations:^{
                    self.flowerV.frame = CGRectMake(91.5,320, 135, 135);
                } completion:^(BOOL finished){
                    //self.flowerV.frame = CGRectMake(-200,500, 135, 135);
                }];
                
                _MYbutton.alpha = 1.0;
                _MYbutton.userInteractionEnabled = YES;
                [_MYbutton setBackgroundImage:[UIImage imageNamed:@"Fjion.PNG"] forState:UIControlStateNormal];
                [_MYbutton addTarget:self action:@selector(Fbutton) forControlEvents:UIControlEventTouchUpInside];
                
                [_chattime1 setFireDate:[NSDate distantFuture]];//暂停
            }

        }break;
        default:
            break;
    }
    //NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    
    
    
    
}

//上传失败
- (void)upLoadFailed:(ASIHTTPRequest *)request
{
    //[activityView hidden];
//    MyAlertView *alert = [[MyAlertView alloc] initWithTitle:@"提示" contentText:@"加入游戏数据失败！" leftButtonTitle:nil rightButtonTitle:nil addkAlertHeight:100.0];
//    [alert show];
//    
    // [alert release];
    
    NSString *str = [request responseString];
    NSLog(@"str = %@",str);
}

-(void)Flai
{
    NSLog(@"在来一局");
    [_MYbutton removeFromSuperview];
    
    self.Button.alpha = 1.0;
    self.Button.userInteractionEnabled = YES;
    [self.Button setBackgroundImage:[UIImage imageNamed:@"Fopen.PNG"] forState:UIControlStateNormal];
   
}

-(void)Fbutton
{
    NSLog(@"传");
    _MYbutton.alpha = 0.0;
    _MYbutton.userInteractionEnabled = NO;
    
   
    
    [UIView animateWithDuration:1 animations:^{
        self.flowerV.frame = CGRectMake(500,-200, 135, 135);
    } completion:^(BOOL finished){
        self.flowerV.frame = CGRectMake(-200,500, 135, 135);
    }];
    
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString * usergamehomenum = [defaults objectForKey:@"usergamehomenum"];//根据键值取出usergamehomenum桌号
    
    ident = RQIdentifierForSenddrumflowerPass;
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SenddrumflowerinfoURL]];
    [upLoadRequest setPostValue:usergamehomenum forKey:@"gamehomenum"];//桌名
    [upLoadRequest setPostValue:@"3" forKey:@"istimeover"];//1 开始 0 结束 2 参与 3传
    [upLoadRequest setPostValue:@"1" forKey:@"gameuserid"];//身份标识
    [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];//身份标识

    
    
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];
}



-(void)ButtonBut
{
    NSLog(@"开始 传");
    
    self.Button.alpha = 0.0;
    self.Button.userInteractionEnabled = NO;
    
    _MYbutton = [[UIButton alloc]initWithFrame:self.Button.frame];
     _MYbutton.alpha = 0.0;
     _MYbutton.userInteractionEnabled = NO;
    [self.view addSubview:_MYbutton];

    
//    srand((unsigned)time(0));  //不加这句每次产生的随机数不变
//     int result1 = (rand() % 30 + 30);  //产生60～的数
//    _chattime = [NSTimer scheduledTimerWithTimeInterval:result1 target:self selector:@selector(scrollTimer)userInfo:nil repeats:YES];
    //[_chattime setFireDate:[NSDate date]];//暂停
    
    
    
    _chattime1 = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollTimer1)userInfo:nil repeats:YES];
    //[_chattime1 setFireDate:[NSDate date]];//继续
    [_chattime1 setFireDate:[NSDate distantFuture]];//暂停
    
    [UIView animateWithDuration:1 animations:^{
        self.flowerV.frame = CGRectMake(500,-200, 135, 135);
    } completion:^(BOOL finished){
        self.flowerV.frame = CGRectMake(-200,500, 135, 135);
        //self.flowerV.frame = CGRectMake(500,-200, 135, 135);
    }];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString * usergamehomenum = [defaults objectForKey:@"usergamehomenum"];//根据键值取出usergamehomenum桌号
    
    ident = RQIdentifierForSenddrumflowerStart;
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SenddrumflowerinfoURL]];
    [upLoadRequest setPostValue:usergamehomenum forKey:@"gamehomenum"];//桌名
    [upLoadRequest setPostValue:@"1" forKey:@"istimeover"];//1 开始 0 结束
    [upLoadRequest setPostValue:@"1" forKey:@"gameuserid"];//身份标识
    [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];//id
    
    
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];

}

-(void)AdventureBut
{
    NSLog(@"大冒险");
    AdventViewController * AdventV = [[AdventViewController alloc] init];
    [self.navigationController pushViewController:AdventV animated:YES];
}

//-========
-(void)scrollTimer
{
    NSLog(@"结束");
    [_chattime setFireDate:[NSDate distantFuture]];//暂停
    //[_chattime1 setFireDate:[NSDate distantFuture]];//暂停
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString * usergamehomenum = [defaults objectForKey:@"usergamehomenum"];//根据键值取出usergamehomenum桌号
    
    ident = RQIdentifierForSenddrumflowerEnd;
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SenddrumflowerinfoURL]];
    [upLoadRequest setPostValue:usergamehomenum forKey:@"gamehomenum"];//桌名
    [upLoadRequest setPostValue:@"0" forKey:@"istimeover"];//1 开始 0 结束 2 参与 3传
    [upLoadRequest setPostValue:@"1" forKey:@"gameuserid"];//身份标识
    [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];//id
    
    
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];
}


-(void)scrollTimer1
{
    
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString * usergamehomenum = [defaults objectForKey:@"usergamehomenum"];//根据键值取出usergamehomenum桌号
    
    ident = RQIdentifierForSenddrumflowerWait;
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SenddrumflowerinfoURL]];
    [upLoadRequest setPostValue:usergamehomenum forKey:@"gamehomenum"];//桌名
    [upLoadRequest setPostValue:@"2" forKey:@"istimeover"];//1 开始 0 结束
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
[_chattime1 setFireDate:[NSDate distantFuture]];
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择游戏退出还是挂起！" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"挂起", nil];
    [alertView show];

    
    
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
