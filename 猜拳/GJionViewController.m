//
//  GJionViewController.m
//  JUJU
//
//  Created by linchuanbin on 14-5-21.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "GJionViewController.h"

@interface GJionViewController ()

@end

@implementation GJionViewController
static RQIdflower ident;
static bool PKTAB = NO;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)openMybutton
{
    MyButon[2].userInteractionEnabled = YES;
    MyButon[3].userInteractionEnabled = YES;
    MyButon[4].userInteractionEnabled = YES;
    MyButon[2].alpha = 1.0;
    MyButon[3].alpha = 1.0;
    MyButon[4].alpha = 1.0;
    
    
    
    srand((unsigned)time(0));
    int result1 = (rand() % 6);
    switch (result1) {
        case 0:
        {
            [MyButon[2] setBackgroundImage:[UIImage imageNamed:@"MyButton4.PNG"] forState:UIControlStateNormal];
            MyButon[2].tag = 4;
            [MyButon[3] setBackgroundImage:[UIImage imageNamed:@"MyButton5.PNG"] forState:UIControlStateNormal];
            MyButon[3].tag = 5;
            [MyButon[4] setBackgroundImage:[UIImage imageNamed:@"MyButton3.PNG"] forState:UIControlStateNormal];
            MyButon[4].tag = 3;
            
        }break;
        case 1:
        {
            [MyButon[2] setBackgroundImage:[UIImage imageNamed:@"MyButton5.PNG"] forState:UIControlStateNormal];
            MyButon[2].tag = 5;
            [MyButon[3] setBackgroundImage:[UIImage imageNamed:@"MyButton3.PNG"] forState:UIControlStateNormal];
            MyButon[3].tag = 3;
            [MyButon[4] setBackgroundImage:[UIImage imageNamed:@"MyButton4.PNG"] forState:UIControlStateNormal];
            MyButon[4].tag = 4;
            
        }break;
        case 2:
        {
            [MyButon[2] setBackgroundImage:[UIImage imageNamed:@"MyButton4.PNG"] forState:UIControlStateNormal];
            MyButon[2].tag = 4;
            [MyButon[3] setBackgroundImage:[UIImage imageNamed:@"MyButton3.PNG"] forState:UIControlStateNormal];
            MyButon[3].tag = 3;
            [MyButon[4] setBackgroundImage:[UIImage imageNamed:@"MyButton5.PNG"] forState:UIControlStateNormal];
            MyButon[4].tag = 5;
            
        }break;
        case 3:
        {
            [MyButon[2] setBackgroundImage:[UIImage imageNamed:@"MyButton5.PNG"] forState:UIControlStateNormal];
            MyButon[2].tag = 5;
            [MyButon[3] setBackgroundImage:[UIImage imageNamed:@"MyButton4.PNG"] forState:UIControlStateNormal];
            MyButon[3].tag = 4;
            [MyButon[4] setBackgroundImage:[UIImage imageNamed:@"MyButton3.PNG"] forState:UIControlStateNormal];
            MyButon[4].tag = 3;
            
        }break;
        case 4:
        {
            [MyButon[2] setBackgroundImage:[UIImage imageNamed:@"MyButton3.PNG"] forState:UIControlStateNormal];
            MyButon[2].tag = 3;
            [MyButon[3] setBackgroundImage:[UIImage imageNamed:@"MyButton5.PNG"] forState:UIControlStateNormal];
            MyButon[3].tag = 5;
            [MyButon[4] setBackgroundImage:[UIImage imageNamed:@"MyButton4.PNG"] forState:UIControlStateNormal];
            MyButon[4].tag = 4;
            
        }break;
        default:
            break;
    }

    
}
-(void)endMybutton
{
    MyButon[0].userInteractionEnabled = NO;
    MyButon[1].userInteractionEnabled = NO;
    MyButon[0].alpha = 0.0;
    MyButon[1].alpha = 0.0;
    
    MyButon[2].userInteractionEnabled = NO;
    MyButon[3].userInteractionEnabled = NO;
    MyButon[4].userInteractionEnabled = NO;
    MyButon[2].alpha = 0.0;
    MyButon[3].alpha = 0.0;
    MyButon[4].alpha = 0.0;
    
}

-(void) OpenTimer
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    ident = RQIdentifierForStartfingerguess;
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:StartfingerguessURL]];
    [upLoadRequest setPostValue:[defaults objectForKey:@"usergamehomenum"] forKey:@"gamehomenum"];//桌名
    //[upLoadRequest setPostValue:@"1" forKey:@"isgameover"];
    //[upLoadRequest setPostValue:[defaults objectForKey:@"userID"] forKey:@"gameuserid"];
   // [upLoadRequest setPostValue:@"0" forKey:@"flag"];
    
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    [upLoadRequest startAsynchronous];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self endMybutton];
    
    OpenTimer = [NSTimer scheduledTimerWithTimeInterval:(0.1) target:self selector:@selector(OpenTimer) userInfo:nil repeats:YES];
    Continuetime = [NSTimer scheduledTimerWithTimeInterval:(0.1) target:self selector:@selector(Continuetime) userInfo:nil repeats:YES];
    [Continuetime setFireDate:[NSDate distantFuture]];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ReturnBut
{
    NSLog(@"MyReturn");
    
    [UIView animateWithDuration:0.5 animations:^{
        BGImage[2].frame = CGRectMake(0, 0, 114.5, 320);
        BGImage[3].frame = CGRectMake(471, 0, 97, 316.5);
        BGImage[4].frame = CGRectMake(0, 0,568, 53.5);
    }completion:^(BOOL finished){
        [UIView animateWithDuration:0.5 animations:^{
            BGImage[0].frame = CGRectMake(0, 0, 305, 320);
            BGImage[1].frame = CGRectMake(283, 0, 285, 320);
    }completion:^(BOOL finished){
            
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择游戏退出还是挂起！" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"挂起", nil];
        [alertView show];
        }];
        
    }];
    
}


-(void)MyButon:(UIButton *)but
{
    
    static SystemSoundID soundIDTest = 0;
    NSString * path = [[NSBundle mainBundle] pathForResource:@"488" ofType:@"wav"];//音频
    CFURLRef dropURL = (__bridge CFURLRef)[NSURL fileURLWithPath:path];
    if (path) {
        AudioServicesCreateSystemSoundID(dropURL, &soundIDTest);
    }
    
    AudioServicesPlaySystemSound(soundIDTest);
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
            NSString * str;
            switch (but.tag) {
                case 3:
                {
                    NSLog(@"剪刀 2");
                    str = @"2";
                    
                }break;
                case 4:
                {
                    NSLog(@"石头 1");
                    str = @"1";
                }break;
                case 5:
                {
                    NSLog(@"布 3");
                    str = @"3";
                }break;
                default:
                    break;
            }
            [ENdTimer setFireDate:[NSDate distantFuture]];
            NSLog(@"jieguo = %@",str);
            
            ident = RQIdentifierForGetguesscover;
            upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:GetguesscoverURL]];
            [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
            [upLoadRequest setPostValue:[defaults objectForKey:@"usergamehomenum"] forKey:@"gamehomenum"];//桌名
            //[upLoadRequest setPostValue:@"1" forKey:@"isgameover"];
            [upLoadRequest setPostValue:str forKey:@"guesscover"];
            
            [upLoadRequest setTimeOutSeconds:10.f];//设置超时秒
            
            upLoadRequest.delegate = self;
            [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
            [upLoadRequest startAsynchronous];
    
}

-(void)Continuetime
{
    //加载结果list
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    ident = RQIdentifierForSendguesscover;
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SendguesscoverURL]];
    [upLoadRequest setPostValue:[defaults objectForKey:@"guessflag"] forKey:@"flag"];
    [upLoadRequest setPostValue:[defaults objectForKey:@"usergamehomenum"] forKey:@"gamehomenum"];//桌名
    [upLoadRequest setPostValue:[defaults objectForKey:@"sum"] forKey:@"sum"];//个数
    
    
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    [upLoadRequest startAsynchronous];
}

-(void)butPK
{
    PKTAB = YES;
    [butPK removeFromSuperview];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    ident = RQIdentifierForContinueguess;
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:ContinueguessURL]];
    [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
    [upLoadRequest setPostValue:[defaults objectForKey:@"usergamehomenum"] forKey:@"gamehomenum"];//桌名
    [upLoadRequest setPostValue:@"1" forKey:@"timeflag"];
    
    [upLoadRequest setTimeOutSeconds:10.f];//设置超时秒
    
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    [upLoadRequest startAsynchronous];
}

-(void)PKopen
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    ident = RQIdentifierForContinueguess;
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:ContinueguessURL]];
    [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
    [upLoadRequest setPostValue:[defaults objectForKey:@"usergamehomenum"] forKey:@"gamehomenum"];//桌名
    [upLoadRequest setPostValue:@"0" forKey:@"timeflag"];
    
    [upLoadRequest setTimeOutSeconds:10.f];//设置超时秒
    
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    [upLoadRequest startAsynchronous];
}


-(void)PKend:(NSTimer * )time
{
    if(PKTAB)
    {
        PKTAB = NO;
        
         PKopen = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(PKopen) userInfo:nil repeats:YES];
        //[time setFireDate:[NSDate distantFuture]];
        
    }else{
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        ident = RQIdentifierForContinueguess;
        upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:ContinueguessURL]];
        [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
        [upLoadRequest setPostValue:[defaults objectForKey:@"usergamehomenum"] forKey:@"gamehomenum"];//桌名
        [upLoadRequest setPostValue:@"2" forKey:@"timeflag"];
        
        [upLoadRequest setTimeOutSeconds:10.f];//设置超时秒
        
        upLoadRequest.delegate = self;
        [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
        [upLoadRequest startAsynchronous];
        
        
        _BackCenterImage.image = [UIImage imageNamed:@"GEND.PNG"];
        _BackCenterImage.bounds = CGRectMake(0, 0, 114.5, 20.5);
        [butPK removeFromSuperview];
    }

    
}

-(void)PKtime:(NSTimer *)time
{
    static int i = 0;
    i++;
    switch (i) {
        case 1:
        {
            _BackCenterImage.image = [UIImage imageNamed:@"G3.PNG"];
        }break;
        case 2:
        {
            _BackCenterImage.image = [UIImage imageNamed:@"G2.PNG"];
        }break;
        case 3:
        {
            _BackCenterImage.image = [UIImage imageNamed:@"G1.PNG"];
            
        }break;
        default:{
            _BackCenterImage.image = nil;
            [time setFireDate:[NSDate distantFuture]];
            //[self endMybutton];
           
        }break;
    }
}




//-------------上传信息-------------

#pragma mark - ASIHttpDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    //反馈数据
    //[activityView hidden];
    
    NSString *str = [request responseString];
   NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    switch (ident) {
        case RQIdentifierForStartfingerguess:
        {//开始
             NSLog(@"时时访问开始 = %@",str);
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"dictionary = %d",[[dictionary objectForKey:@"guessflag"] intValue]);
            if(str.length > 15)
            {
                [defaults setObject:[dictionary objectForKey:@"sum"] forKey:@"sum"];
                [defaults synchronize];//用synchronize方法把数据持久化到standardUse
            if([[dictionary objectForKey:@"guessflag"] integerValue] == 1 ||[[dictionary objectForKey:@"guessflag"] integerValue] == 0)
            {
                
                NSLog(@"guessflag  == %@",[dictionary objectForKey:@"guessflag"]);
                [defaults setObject:[dictionary objectForKey:@"guessflag"] forKey:@"guessflag"];
                [defaults synchronize];//用synchronize方法把数据持久化到standardUse

                 [self openMybutton];
                [OpenTimer setFireDate:[NSDate distantFuture]];
                
                 ENdTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(PKtime:) userInfo:nil repeats:YES];
                //[OpenTimer setFireDate:[NSDate date]];//继续
                
            }
            }
        }break;
        case RQIdentifierForGetguesscover:
        {///上传结果
            NSLog(@"结果 = %@",str);
            [Continuetime setFireDate:[NSDate date]];//继续
        }break;
        case RQIdentifierForSendguesscover:
        {
             NSLog(@"结果list =%@",str);
           NSArray * array = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            
            [Namedata removeAllObjects];
            
            for(NSDictionary * dict in array)
            {
                [Continuetime setFireDate:[NSDate distantFuture]];
                if([[dict objectForKey:@"username"] isEqualToString:@"平局"])
                {
                    //提示
                    NSLog(@"平局");
                    [self openMybutton];
                    break;
                }else{
                    [Namedata addObject:dict];
                    
                    [self endMybutton];
                    NSString * str11 = [defaults objectForKey:@"_userID"];
                    NSLog(@"%@ == %@",str11 ,[dict objectForKey:@"id"]);
                    if([[dict objectForKey:@"id"] intValue] == [str11 intValue])
                    {
                        NSLog(@"bu继续PK");
                        _BackCenterImage.image = [UIImage imageNamed:@"GEND.PNG"];
                        _BackCenterImage.bounds = CGRectMake(0, 0, 114.5, 20.5);
                        //结束游戏
                    }else{
                        //继续PK
                        NSLog(@"继续PK");
                        butPK = [[UIButton alloc] initWithFrame:CGRectMake(105,274,111, 32)];
                        [butPK setBackgroundImage:[UIImage imageNamed:@"GPK.PNG"] forState:UIControlStateNormal];
                        [butPK addTarget:self action:@selector(butPK) forControlEvents:UIControlEventTouchUpInside];
                        [self.view addSubview:butPK];
                        
                        [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(PKend:) userInfo:nil repeats:NO];
                        //RQIdentifierForContinueguess
                        
                    }
                }
            }
            
            NameList = [[UITableView alloc] init];
            NameList.center = CGPointMake(284, 135);
            NameList.bounds = CGRectMake(0, 0,100, 30);
            NameList.delegate = self;
            NameList.dataSource = self;
            NameList.separatorStyle = UITableViewCellSeparatorStyleNone;//去除边框
            //[self.view addSubview:NameList];
            
            [NameList reloadData];
            
        }break;
        case RQIdentifierForContinueguess:
        {
            NSLog(@"PK 结果");
             NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"dictionary = %@",[dictionary objectForKey:@"sum"]);
            if([[dictionary objectForKey:@"sum"] length] > 0)
            {
            [defaults setObject:[dictionary objectForKey:@"sum"] forKey:@"sum"];
                [self openMybutton];
            }
            
        }break;
            
        default:
            break;
    }
    
    //    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    
    
    
}

//上传失败
- (void)upLoadFailed:(ASIHTTPRequest *)request
{
    //    //[activityView hidden];
    //    MyAlertView *alert = [[MyAlertView alloc] initWithTitle:@"提示" contentText:@"加入游戏失败！" leftButtonTitle:nil rightButtonTitle:nil addkAlertHeight:100.0];
    //    [alert show];
    //
    //    // [alert release];
    
    NSString *str = [request responseString];
    NSLog(@"加载dice结果str = %@",str);
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
    
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    self.navigationController.view.transform = CGAffineTransformIdentity;
    self.navigationController.view.transform = CGAffineTransformMakeRotation(M_PI*(0)/180.0);
    self.navigationController.view.bounds = CGRectMake(0, 0, 320, 568);
    [UIView commitAnimations];
    
    [self.navigationController popViewControllerAnimated:YES];//返回上级
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

//---------------------------------------------
#pragma mark - View lifecycle

//自动调用后
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0f;
}


//返回每个section的元数个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Namedata count];
}


//开辟存储数据的空间
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier =@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ 出了 %@",[[[Namedata objectAtIndex:indexPath.row] objectForKey:@"username"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[Namedata objectAtIndex:indexPath.row] objectForKey:@"useroutcome"]];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"dan ji");
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
