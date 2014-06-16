//
//  OrganigerViewController.m
//  Dice
//
//  Created by linchuanbin on 14-4-30.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "OrganigerViewController.h"
#import "JionViewController.h"

#import "AdventViewController.h"



@interface OrganigerViewController ()

@end

@implementation OrganigerViewController

static int Dicenamber = 1;

static bool GameTAB = NO;
static bool GameOpen_end = NO;
static int TT = 0;
static int GameTime = 0;
static RQIdflower ident;


//@synthesize Background = _Background;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self removeGame];
    [self addMYView];
    Dicenamber = 1;
    GameTAB = NO;
    GameOpen_end = NO;
    TT = 0;
     _Title12.alpha = 1.0;
    activityView = [[ActivityView alloc] initWithFrame:self.view.bounds];
    
    [activityView hidden];
    activityView.delegate = self;
    
    [self.view addSubview:activityView];
    
     gameArray = [[NSMutableArray alloc] init];
    InvitationArray = [[NSMutableArray alloc] init];
    
    _SHUtime = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(SHUTime) userInfo:nil repeats:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    //[self removeGame];
    //[self addMYView];
    
    //_SHUtime = [NSTimer scheduledTimerWithTimeInterval:(0.1) target:self selector:@selector(SHUTime) userInfo:nil repeats:YES];
}

-(void)SHUTime
{
    //人数
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString * usergamehomenum = [defaults objectForKey:@"usergamehomenum"];//根据键值取出usergamehomenum桌号
    
    ident = RQIdentifierForPersonnum;
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:PersonnumURL]];
    [upLoadRequest setPostValue:usergamehomenum forKey:@"gamehomenum"];//游戏桌号
    //[upLoadRequest setPostValue:[NSString stringWithFormat:@"%d",Dicenamber] forKey:@"bosonsnum"];
    
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.Shake.userInteractionEnabled = YES;
    [self.Shake setUserInteractionEnabled:NO];
    [self.Game setUserInteractionEnabled:NO];
    [self.Dice setUserInteractionEnabled:NO];
    
    //[self.navigationController setNavigationBarHidden:NO];
    //[self addMYView];

//    _Background = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    _Background.image = [UIImage imageNamed:@"BG.PNG"];
    // Do any additional setup after loading the view.
}

-(void)Invitation
{
    //邀请
    ident =  RQIdentifierForSendUserinfo;
    //获取房间内的用户名单
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SendUserinfoURL]];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    //NSString * homenum = [defaults objectForKey:@"homenum"];//根据键值取出homenum
    
    [upLoadRequest setPostValue:[defaults objectForKey:@"_Roomnumber"] forKey:@"homenumber"];//房间号
    
    [upLoadRequest setTimeOutSeconds:30.f];//设置超时秒
    
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];
   
}


-(void)addMYView
{
    _Number = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Number.PNG"]];
    _Number.center = CGPointMake(160, 220);
    _Number.bounds = CGRectMake(0, 0, 102, 14);
    [self.view addSubview:_Number];
    
    _DiceBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DiceBG.PNG"]];
    _DiceBG.center = CGPointMake(160, 274);
    _DiceBG.bounds = CGRectMake(0, 0, 90, 68);
    [self.view addSubview:_DiceBG];
    
    
    _Confirm = [[UIButton alloc] initWithFrame:CGRectMake(107,320, 106, 32)];
    [_Confirm setBackgroundImage:[UIImage imageNamed:@"Confirm.PNG"] forState:UIControlStateNormal];
    [_Confirm addTarget:self action:@selector(ConfirmBut) forControlEvents:UIControlEventTouchUpInside];
    _Confirm.userInteractionEnabled = NO;
    [self.view addSubview:_Confirm];
    
    _Invitation = [[UIButton alloc] initWithFrame:CGRectMake(107,370, 106, 32)];
    [_Invitation setTitle:@"邀请" forState:UIControlStateNormal];
    [_Invitation addTarget:self action:@selector(Invitation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Invitation];
    //邀请
    
    _DiceNumber = [[UIScrollView alloc] initWithFrame:CGRectMake(55, 248, 210, 52)];
    _DiceNumber.backgroundColor = [UIColor clearColor];
    _DiceNumber.alpha = 1.0;
    _DiceNumber.delegate = self;
    _DiceNumber.showsHorizontalScrollIndicator = NO;
    _DiceNumber.showsVerticalScrollIndicator = NO;
    // _DiceNumber.scrollEnabled = YES;
    _DiceNumber.contentSize = CGSizeMake(200*3, 52);
    //_DiceNumber.pagingEnabled = YES;
    [self.view addSubview:_DiceNumber];
    
    for (int i = 0; i < 8; i++) {
        UIImageView * imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"dice%d.png",i]]];
        imageV.center = CGPointMake(15+i*80, 24);
        imageV.tag = i;
        if(i == 1)imageV.alpha = 1.0;
        else imageV.alpha = 0.5;
        imageV.bounds = CGRectMake(0, 0, 160, 120);
        imageV.backgroundColor = [UIColor clearColor];
        [_DiceNumber addSubview:imageV];
    }

}

-(void)removeMYView
{
    [_Number removeFromSuperview];
    [_DiceBG removeFromSuperview];
    [_Confirm removeFromSuperview];
    [_Invitation removeFromSuperview];
    [_DiceNumber removeFromSuperview];
    
}



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
//    [self removeGame];
//    [self addMYView];
}

-(void)ShakeBut
{
    
    NSLog(@"ShakeBut 摇起来");
    if(!GameOpen_end)
    {
        
        GameOpen_end = YES;
        
    if(GameTAB)
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
        int result1 = (rand() % 180);  //产生1～6的数
        int result2 = (rand() % 190);  //产生1～6的数
        _Dicedong[i] = [[UIImageView alloc]init];
        _Dicedong[i].center = CGPointMake(45.0 + result1, 150 + result2);
        _Dicedong[i].bounds = CGRectMake(0, 0, 192, 144);
        //_Dicedong[i].frame = CGRectMake(75.0 + 60*(i%3), 75.0 + 60*(i%3), 45.0, 45.0);
        _Dicedong[i].animationImages = myImages1;
        _Dicedong[i].animationDuration = 0.15;
        [_Dicedong[i] startAnimating];
        [self.view addSubview:_Dicedong[i]];
    }
        
      GameTime = (rand() % 60)+30;//产生30～90的数
    _chattime = [NSTimer scheduledTimerWithTimeInterval:(0.1) target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    }
    }

    
}
-(void)AdventureBut
{
    NSLog(@"AdventureBut 大冒陷");
}


-(void)ConfirmBut
{
    NSLog(@"ConfirmBut 确认");
    
    _Title12.alpha = 0.0;
   
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString * usergamehomenum = [defaults objectForKey:@"usergamehomenum"];//根据键值取出usergamehomenum桌号
    
    [activityView show];
    //上传筛子数
    ident = nil;
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:GetbosonsNumURL]];
    [upLoadRequest setPostValue:usergamehomenum forKey:@"gamehomenum"];//游戏名
    [upLoadRequest setPostValue:[NSString stringWithFormat:@"%d",Dicenamber] forKey:@"bosonsnum"];
    
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];

    
//    GameTAB = YES;
//    [self.Shake setUserInteractionEnabled:YES];
//    [self removeMYView];
//    [self openGame];
    
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
#pragma mark -   MyAlertV.delegate代理方法 
//----------------------------------
-(void)MyAlertVTab:(BOOL)tab
{//邀请
    if(tab)
    {
         NSArray * array = [[PublicDictionary shareDictionary] objectForKey:@"MyAlertV"];
        NSLog(@"点击的 = %@",array);
        NSMutableArray * myarray = [[NSMutableArray alloc] init];
        for(NSDictionary *dict in array)
        {
            [myarray addObject:[dict objectForKey:@"id"]];
        }
        NSString *string = [myarray componentsJoinedByString:@","];
        NSLog(@"string:%@",string);
        
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        NSString * usergamehomenum = [defaults objectForKey:@"usergamehomenum"];//根据键值取出usergamehomenum桌号
        ident = RQIdentifierForGetjoin;
        
        upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:GetjoinURL]];
        [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"mainid"];//邀请人id
         [upLoadRequest setPostValue:string forKey:@"id"];//邀请的id
         [upLoadRequest setPostValue:usergamehomenum forKey:@"gamehomenum"];//桌名
        [upLoadRequest setPostValue:[defaults objectForKey:@"_GmaeName"] forKey:@"gamename"];//游戏名
       
        
        [upLoadRequest setTimeOutSeconds:30.f];//设置超时秒
        
        upLoadRequest.delegate = self;
        [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
        [upLoadRequest startAsynchronous];
    }
}
//----------------------

#pragma mark -   activityView.delegate代理方法 加载试图
- (void)CancelTab:(BOOL)tab
{
    NSLog(@"=%@=",tab ? @"YES":@"NO");//YES是放弃加载 NO是加载完成
    if(tab) {[upLoadRequest clearDelegatesAndCancel];}//取消加载
}

//------------------------------
#pragma mark -

// 是否支持滑动至顶部
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{

    return YES;

}
// 滑动到顶部时调用该方法
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScrollToTop");
    
}

// scrollView 已经滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScroll");
   NSLog(@"ContentOffset  x is  %f,yis %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    for( UIImageView * ImageV in [_DiceNumber subviews])
    {
        if(ImageV.tag == ((int)scrollView.contentOffset.x /75 + 1) )
        {
            NSLog(@"tag -= %ld",(long)ImageV.tag);
            Dicenamber = (int)ImageV.tag;
            ImageV.alpha = 1.0;
        }else
        {
            ImageV.alpha = 0.5;
        }
    }

}

// scrollView 开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    NSLog(@"scrollViewWillBeginDragging");
   
}

// scrollView 结束拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging");
    [scrollView setContentOffset:CGPointMake((int)(scrollView.contentOffset.x /75+0.4) *80, 0) animated:YES];
   
}

// scrollView 开始减速（以下两个方法注意与以上两个方法加以区别）
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDecelerating");
}

// scrollview 减速停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSLog(@"scrollViewDidEndDecelerating");
     NSLog(@"tag = %f",scrollView.contentOffset.x /75 + 1);
    NSLog(@"ContentOffset  x is  %f,yis %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    [scrollView setContentOffset:CGPointMake((int)(scrollView.contentOffset.x /75+0.4) *80, 0) animated:YES];
    
    
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
//删除筛子
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
        _Dicedong[i].image = [UIImage imageNamed:[NSString stringWithFormat:@"dice%d.png",result1]];
    }
    
    NSLog(@"结束了");
   // if([[NSString stringWithFormat:@"%@",[anim valueForKeyPath:@"animType"]] isEqualToString:@"ss= 0"])
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
    NSLog(@"筛子结果1 = %@,游戏名1 = %@",string,gameuser);
    //NSString * str=[url absoluteString];
    //上传筛子 结果
    ident = nil;
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
    [activityView hidden];
    NSLog(@"request = %@",request);
     NSString *str = [request responseString];
     NSLog(@"反馈数据 = %@",str);
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    
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
        case RQIdentifierForPersonnum:
        {
            NSLog(@"RQIdentifierForPersonnum");
             NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"dict =%@",dictionary);
            //NSString * rshu = [dictionary objectForKey:@"personsum"];
            //桌号人数
            _Title12.text = [NSString stringWithFormat:@"人数：%@", [dictionary objectForKey:@"personsum"]];
            if([[dictionary objectForKey:@"personsum"] intValue] >= 1)
            {
                _Confirm.userInteractionEnabled = YES;
            }
            
        }break;
        case RQIdentifierForSendUserinfo:
        {
            NSArray * array = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            //邀请人名单
            [InvitationArray removeAllObjects];
            for(NSDictionary * dict in array)
            {
                NSString * str = [dict objectForKey:@"id"];NSString * str1 = [defaults objectForKey:@"_userID"];
                NSLog(@"str == %@ str1 == %@",str,str1);
                if(!([str intValue] == [str1 intValue]))
                    [InvitationArray addObject:dict];
            }
            MyAlertV  *View = [[MyAlertV alloc] initWithTitle:@"邀请" contentArray:InvitationArray leftButtonTitle:@"取消" rightButtonTitle:@"确定" addTAB:YES];
            View.delegate = self;
            [View show];
            

        }break;
        case RQIdentifierForGetjoin:
        {
            NSLog(@"RQIdentifierForGetjoin邀请 = %@",str);
            //
        }break;
            
        default:
        {
            //NSString *str = [request responseString];
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            
            if([[dictionary objectForKey:@"bosonsnumflag"] intValue] == 1)
            {
                NSLog(@"游戏上传个数 = %@",str);
                
                [_SHUtime setFireDate:[NSDate distantFuture]];//暂停
                
                NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                [defaults setObject:[dictionary objectForKey:@"sum"] forKey:@"sum"];
                [defaults synchronize];//用synchronize方法把数据持久化到standardUse
                
                GameTAB = YES;
                [self.Shake setUserInteractionEnabled:YES];
                [self removeMYView];
                [self openGame];
                // MenuViewController * MenuV = [[MenuViewController alloc] init];
                // [self.navigationController pushViewController:MenuV animated:YES];
            }
            
            if([[dictionary objectForKey:@"bosonscoverflag"] intValue] == 1){
                
                JionViewController * JionV = [[JionViewController alloc] init];
                [self.navigationController pushViewController:JionV animated:YES];
            }
            

        }
            break;
    }
    
}

//上传失败
- (void)upLoadFailed:(ASIHTTPRequest *)request
{
    
//    [activityView hidden];
//    MyAlertView *alert = [[MyAlertView alloc] initWithTitle:@"提示" contentText:@"加入游戏失败！" leftButtonTitle:nil rightButtonTitle:nil addkAlertHeight:100.0];
//    [alert show];
    
    // [alert release];
    
    NSString *str = [request responseString];
    NSLog(@"str = %@",str);
}

//--------------
-(void)ReturnBut
{
    NSLog(@"MyReturn1");
    [_chattime setFireDate:[NSDate distantFuture]];//暂停
    [_SHUtime setFireDate:[NSDate distantFuture]];//暂停

    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择游戏退出还是挂起！" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"挂起", nil];
    [alertView show];
   // [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: ([self.navigationController.viewControllers count] -2)] animated:YES];
//    NSLog(@"count = %D",[self.navigationController.viewControllers count]);
    //[self.navigationController popViewControllerAnimated:YES];//返回上级
    
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
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: ([self.navigationController.viewControllers count] -2)] animated:YES];
    NSLog(@"count = %D",[self.navigationController.viewControllers count]);
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
   // srand((unsigned)time(0));  //不加这句每次产生的随机数不变
    //int result1 = (rand() % 10) +10 ;  //产生1～6的数
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
