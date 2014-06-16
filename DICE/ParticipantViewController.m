//
//  ParticipantViewController.m
//  Dice
//
//  Created by linchuanbin on 14-4-30.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "ParticipantViewController.h"
#import "JionViewController.h"

@interface ParticipantViewController ()

@end

@implementation ParticipantViewController

static int Dicenamber = 6;
static bool gameTAB = NO;
static int TT = 0;
static int GameTime = 0;
static RQIdflower ident;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    //[self.navigationController setNavigationBarHidden:NO];
    [self removeGame];
    
    Dicenamber = 6;
    gameTAB = NO;
    TT = 0;
    _Title12.alpha = 1.0;

    _GameOpen = [[UILabel alloc] initWithFrame:CGRectMake(60, 250,200, 40)];
    _GameOpen.text = @"等待游戏开始》》》》》》》";
    _GameOpen.textAlignment = NSTextAlignmentCenter;
    _GameOpen.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_GameOpen];
    
     _chattime = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(scrollTimer)userInfo:nil repeats:YES];
    
    gameArray = [[NSMutableArray alloc] init];
    
    //_SHUtime = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(SHUTime) userInfo:nil repeats:YES];
//    [_chattime setFireDate:[NSDate date]];//继续
}



-(void)scrollTimer
{
    NSLog(@"查筛子数目!");
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString * usergamehomenum = [defaults objectForKey:@"usergamehomenum"];//根据键值取出usergamehomenum桌号
    NSLog(@"usergamehomenum = %@",usergamehomenum);
    
    //获取筛子数目
    ident = RQIdentifierForSendbosonsNum;
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SendbosonsNumURL]];
    [upLoadRequest setPostValue:usergamehomenum forKey:@"gamehomenum"];//桌名
    
    [upLoadRequest setTimeOutSeconds:30.f];//设置超时秒
    
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self.Dice setUserInteractionEnabled:NO];
  
    
    
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
-(void)DiceBut
{
    NSLog(@"Dice 游戏名");
}
//-(void)ShareBut
//{
//    NSLog(@"ShareBut 分享");
//}

-(void)GameBut
{
    NSLog(@"GameBut 再来一局");
   
}

-(void)ShakeBut
{
    NSLog(@"ShakeBut 摇起来");
    if(gameTAB)
    {
    
    static SystemSoundID soundIDTest = 0;
    
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"yao" ofType:@"wav"];//音频
    CFURLRef dropURL = (__bridge CFURLRef)[NSURL fileURLWithPath:path];
    //AudioServicesCreateSystemSoundID ((__bridge CFURLRef) alertSound, &soundFileObject);
    //或
    //AudioServicesCreateSystemSoundID ((CFURLRef) CFBridgingRetain(alertSound), &soundFileObject);
    // OSStatus status = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundIDTest); NSLog(@"AudioServicesCreateSystemSoundID status = %d", status);
    if (path) {
        AudioServicesCreateSystemSoundID(dropURL, &soundIDTest);
    }

    AudioServicesPlaySystemSound(soundIDTest);
    
    
    //隐藏初始位置的骰子
    for(int i = 0 ;i < Dicenamber;i++)
    {
        _DiceImage[i].hidden = YES;
        _Dicedong[i].hidden = YES;
    }
    //******************旋转动画的初始化******************
    //转动骰子的载入
        
        NSArray * myImages1 = [NSArray arrayWithObjects:
                               [UIImage imageNamed:@"0010028.png"],
                               [UIImage imageNamed:@"0010024.png"],
                               [UIImage imageNamed:@"0010036.png"],nil];
        srand((unsigned)time(0));  //不加这句每次产生的随机数不变
    for(int i = 0; i < Dicenamber; i++)
    {
        int result1 = (rand() % 180);  //产生0～180的数
        int result2 = (rand() % 190);  //产生0～190的数
        _Dicedong[i] = [[UIImageView alloc]init];
        _Dicedong[i].center = CGPointMake(45.0 + result1, 150 + result2);
        _Dicedong[i].bounds = CGRectMake(0, 0, 192, 144);
        //_Dicedong[i].frame = CGRectMake(75.0 + 60*(i%3), 75.0 + 60*(i%3), 45.0, 45.0);
        _Dicedong[i].animationImages = myImages1;
        _Dicedong[i].animationDuration = 0.1;
        [_Dicedong[i] startAnimating];
        [self.view addSubview:_Dicedong[i]];
    }
    
        GameTime = (rand() % 60)+30;//产生30～90的数
         _chattime = [NSTimer scheduledTimerWithTimeInterval:(0.1) target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
       
    }
}
-(void)AdventureBut
{
    NSLog(@"AdventureBut 大冒陷");
}



//---开始游戏----
-(void)openGame
{
    //逐个添加骰子
    srand((unsigned)time(0));  //不加这句每次产生的随机数不变
    for(int i = 0; i < Dicenamber; i++)
    {
        if(i%2 == 0)
            pos[i] = CGPointMake(15.0, 7.5);
        else pos[i] = CGPointMake(15.0, 15.0);
        
        _DiceImage[i] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"dice%d.png",i+1]]];
        int result1 = (rand() % 180);  //产生1～6的数
        int result2 = (rand() % 190);  //产生1～6的数

        _DiceImage[i].center = CGPointMake(45.0 + result1, 150 + result2);
        _DiceImage[i].bounds = CGRectMake(0, 0, 192, 144);
        [self.view addSubview:_DiceImage[i]];
    }
}
-(void)removeGame
{
    for(int i = 0; i < Dicenamber; i++)
    {
        [_Dicedong[i] removeFromSuperview];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"animationDidStop = %@",[anim valueForKeyPath:@"animType"]);
    //int shu = [[anim valueForKeyPath:@"animType"] intValue];
    
    srand((unsigned)time(0));  //不加这句每次产生的随机数不变
    for(int i = 0; i < Dicenamber; i++)
    {//停止骰子自身的转动
        [_Dicedong[i] stopAnimating];
        //*************产生随机数，真正博饼*************
        int result1 = (rand() % 5) +1 ;  //产生1～6的数
        NSLog(@"result = %d",result1);
        if([[NSString stringWithFormat:@"%@",[anim valueForKeyPath:@"animType"]] isEqualToString:@"ss= 0"])
        {
            [gameArray addObject:[NSString stringWithFormat:@"%d",result1]];
        }
        _Dicedong[i].image = [UIImage imageNamed:[NSString stringWithFormat:@"%d%d.png",result1,result1]];
    }
    
    NSLog(@"结束了");
    if([[NSString stringWithFormat:@"%@",[anim valueForKeyPath:@"animType"]] isEqualToString:@"ss= 0"])
    [self performSelector:@selector(loadTimeline) withObject:nil afterDelay:2];
    
}

-(void)loadTimeline
{
    NSString * string = [gameArray componentsJoinedByString:@","];
    [gameArray removeAllObjects];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString * usergamehomenum = [defaults objectForKey:@"usergamehomenum"];//根据键值取出usergamehomenum桌号
    NSString * gameuser = [defaults objectForKey:@"Game_Name"];
    NSLog(@"桌号 =%@",usergamehomenum);
    NSLog(@"筛子结果2 = %@,游戏名2 = %@",string,gameuser);
    //上传筛子 结果
    ident = RQIdentifierForGetbosonsCover;
        upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:GetbosonsCoverURL]];
        [upLoadRequest setPostValue:usergamehomenum forKey:@"gamehomenum"];//桌名
        [upLoadRequest setPostValue:string forKey:@"bosonscover"];//筛子结果
        [upLoadRequest setPostValue:[gameuser stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"username"];//游戏名
    
        [upLoadRequest setTimeOutSeconds:30.f];//设置超时秒
    
        upLoadRequest.delegate = self;
        [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
        [upLoadRequest startAsynchronous];

//    //从UIViewController返回上一个UIViewController
//    [self dismissViewControllerAnimated:true completion:^{}];
}

//-------------摇动-------------
//- (BOOL)canBecomeFirstResponder
//{
//    return YES;// default is NO
//}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"开始摇动手机");
    static SystemSoundID soundIDTest1 = kSystemSoundID_Vibrate;
    
    AudioServicesPlaySystemSound(soundIDTest1);
    [self ShakeBut];//开始
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"摇动停止");
    //UIAlertView *yaoyiyao = [[UIAlertView alloc]initWithTitle:@"温馨提示：" message:@"您摇动了手机，想干嘛？" delegate:self cancelButtonTitle:@"CANCEL" otherButtonTitles:nil];
    //[yaoyiyao show];
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"摇动取消 后");
}
//---------------------------
//-------------上传信息-------------

#pragma mark - ASIHttpDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    //反馈数据
    //[activityView hidden];
    
    NSString *str = [request responseString];
    NSLog(@"获取个数 = %@",str);
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    
    
    
    switch (ident) {
        case RQIdentifierForExitgamehome:
        {
            NSLog(@"RQIdentifierForExitgamehome");
            //[_chattime setFireDate:[NSDate distantFuture]];//暂停
            
        }break;
        case RQIdentifierForHoldgame:
        {
            NSLog(@"RQIdentifierForHoldgame");
            //[_chattime setFireDate:[NSDate distantFuture]];//暂停
            
        }break;
        case RQIdentifierForSendbosonsNum:
        {
            NSLog(@"RQIdentifierForSendbosonsNum");
            if([[dictionary objectForKey:@"bosonsnum"] intValue] > 0)
            {
                //[_SHUtime setFireDate:[NSDate distantFuture]];//暂停
                NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                [defaults setObject:[dictionary objectForKey:@"sum"] forKey:@"sum"];
                [defaults synchronize];//用synchronize方法把数据持久化到standardUse
                
                _Title12.alpha = 0.0;
                
                [_chattime setFireDate:[NSDate distantFuture]];//暂停
                Dicenamber =[[dictionary objectForKey:@"bosonsnum"] intValue];
                [_GameOpen removeFromSuperview];
                gameTAB = YES;
                [self openGame];
            }else{
                _Title12.text = [NSString stringWithFormat:@"人数：%@", [dictionary objectForKey:@"personsum"]];
            }

            
        }break;
        case RQIdentifierForGetbosonsCover:
        {
            NSLog(@"RQIdentifierForGetbosonsCover");
            if([[dictionary objectForKey:@"bosonscoverflag"] intValue] == 1){
                JionViewController * JionV = [[JionViewController alloc] init];
                [self.navigationController pushViewController:JionV animated:YES];
                
                // [self presentViewController:JionV animated:true completion:^{}];
            }
            
        }break;
            
        default:
        {
            
        }
            break;
    }

  /*
    if([[dictionary objectForKey:@"bosonsnum"] intValue] > 0)
    {
        
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        [defaults setObject:[dictionary objectForKey:@"sum"] forKey:@"sum"];
        [defaults synchronize];//用synchronize方法把数据持久化到standardUse
        
    [_chattime setFireDate:[NSDate distantFuture]];//暂停
    Dicenamber =[[dictionary objectForKey:@"bosonsnum"] intValue];
    [_GameOpen removeFromSuperview];
    gameTAB = YES;
    [self openGame];
    }
    
    //JionViewController *  JionV = [[JionViewController alloc] init];
    //[self.view addSubview:JionV];
    
    if([[dictionary objectForKey:@"bosonscoverflag"] intValue] == 1){
    JionViewController * JionV = [[JionViewController alloc] init];
    [self.navigationController pushViewController:JionV animated:YES];

   // [self presentViewController:JionV animated:true completion:^{}];
    }
    //[_chattime setFireDate:[NSDate distantFuture]];//暂停

    
//    if([[dictionary objectForKey:@"bosonsnum"] intValue] == 1)
//    {
//        [_GameOpen removeFromSuperview];
//        gameTAB = YES;
//        [self openGame];
//        // MenuViewController * MenuV = [[MenuViewController alloc] init];
//        // [self.navigationController pushViewController:MenuV animated:YES];
//    }else{
//        MyAlertView *alert = [[MyAlertView alloc] initWithTitle:@"提示" contentText:@"获取个数出错！" leftButtonTitle:nil rightButtonTitle:nil addkAlertHeight:100.0];
//        [alert show];
//    }
    */
    
}

//上传失败
- (void)upLoadFailed:(ASIHTTPRequest *)request
{
    //[activityView hidden];
//    MyAlertView *alert = [[MyAlertView alloc] initWithTitle:@"提示" contentText:@"加入游戏失败！" leftButtonTitle:nil rightButtonTitle:nil addkAlertHeight:100.0];
//    [alert show];
    
    // [alert release];
    
    NSString *str = [request responseString];
    NSLog(@"str = %@",str);
}

-(void)ReturnBut
{
    NSLog(@"MyReturn");
    [_chattime setFireDate:[NSDate distantFuture]];//暂停
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: ([self.navigationController.viewControllers count] -2)] animated:YES];
    
    //UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择游戏退出还是挂起！" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"挂起", nil];
    //[alertView show];
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
        [upLoadRequest setPostValue:@"0" forKey:@"gameuserid"];
        
        [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
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
        
        [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
        upLoadRequest.delegate = self;
        [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
        
        [upLoadRequest startAsynchronous];
    }
    [_chattime setFireDate:[NSDate distantFuture]];//暂停
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: ([self.navigationController.viewControllers count] -2)] animated:YES];
}

//------------ 结果---
-(void) onTimer {
    
    TT ++;
    NSLog(@"onTimer");
    for (int i = 0; i < Dicenamber; i++) {
        _Dicedong[i].center = CGPointMake(_Dicedong[i].center.x + pos[i].x, _Dicedong[i].center.y + pos[i].y);
        
        if (_Dicedong[i].center.x > 235 || _Dicedong[i].center.x < 35)
            pos[i].x = -pos[i].x;
        if (_Dicedong[i].center.y > 350 || _Dicedong[i].center.y < 150)
            pos[i].y = -pos[i].y;
    }
    if(TT  == GameTime){
        srand((unsigned)time(0));  //不加这句每次产生的随机数不变
        for(int i = 0; i < Dicenamber; i++)
        {//停止骰子自身的转动
            [_Dicedong[i] stopAnimating];
            //*************产生随机数，真正博饼*************
            int result1 = (rand() % 5) +1 ;  //产生1～6的数
            NSLog(@"result = %d",result1);
            [gameArray addObject:[NSString stringWithFormat:@"%d",result1]];
            _Dicedong[i].image = [UIImage imageNamed:[NSString stringWithFormat:@"dice%d.png",result1]];
        }
        [_chattime setFireDate:[NSDate distantFuture]];//暂停
        [self performSelector:@selector(loadTimeline) withObject:nil afterDelay:2];
    }
}



@end
