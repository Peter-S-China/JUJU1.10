//
//  NOrganigerViewController.m
//  JUJU
//
//  Created by linchuanbin on 14-5-16.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//
//RQIdentifierForGetnophonecover,
//RQIdentifierForSendnophonecover

#import "NOrganigerViewController.h"
#import "AdventViewController.h"

@interface NOrganigerViewController ()

@end

@implementation NOrganigerViewController

@synthesize GameOpen = _GameOpen, GameEnd = _GameEnd, GameDMX = _GameDMX;

static RQIdflower ident;


static long Time = 0;

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
    [super viewWillAppear:animated];
    //设置默认参数
    Time = 0;
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"1" forKey:@"NOphoneEND"];//Nophone开始
    [defaults synchronize];
    
    GameListData  = [[NSMutableArray alloc] init];
    
    if(1 == [[defaults objectForKey:@"userID"] intValue])
    {
        _GameOpen.alpha = 1.0;
        _GameOpen.userInteractionEnabled = YES;
        
    }
    else{
        [TTtime invalidate];//释放; 后加
        TTtime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TTtime)userInfo:nil repeats:YES];
    }

}

-(void)TTtime
{
    NSLog(@"TTtime");
    ident =  RQIdentifierForStartnophone;
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:StartnophoneURL]];
    [upLoadRequest setPostValue:[defaults objectForKey:@"usergamehomenum"] forKey:@"gamehomenum"];

    //[upLoadRequest setPostValue:@"1" forKey:@"isgameover"];
   // [upLoadRequest setPostValue:@"0" forKey:@"gameuserid"];
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];
    
    //[defaults setObject:@"0" forKey:@"NOphoneEND"];//Nophone开始
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    if(1 == [[defaults objectForKey:@"userID"] intValue])
    {
        _GameOpen = [UIButton buttonWithType:UIButtonTypeCustom];
        _GameOpen.frame = CGRectMake(117.5,self.view.bounds.size.height - 55 , 85, 48);
        [_GameOpen setBackgroundImage:[UIImage imageNamed:@"NOpen.PNG"] forState:UIControlStateNormal];
        [_GameOpen addTarget:self action:@selector(gameOpen) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_GameOpen];
        
        _GameEnd = [UIButton buttonWithType:UIButtonTypeCustom];
        _GameEnd.frame = CGRectMake(125,self.view.bounds.size.height - 55 , 70, 48);
        [_GameEnd setBackgroundImage:[UIImage imageNamed:@"NEnd.PNG"] forState:UIControlStateNormal];
        [_GameEnd addTarget:self action:@selector(gameEnd) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_GameEnd];
        
        _GameDMX = [UIButton buttonWithType:UIButtonTypeCustom];
        _GameDMX.frame = CGRectMake(111,self.view.bounds.size.height - 55 , 98, 52);
        [_GameDMX setBackgroundImage:[UIImage imageNamed:@"NDMX.PNG"] forState:UIControlStateNormal];
        [_GameDMX addTarget:self action:@selector(gameDMX) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_GameDMX];
        
        _GameEnd.alpha = 0.0;
        _GameEnd.userInteractionEnabled = NO;
        _GameDMX.alpha = 0.0;
        _GameDMX.userInteractionEnabled = NO;

        
    }
    else{
        //TTtime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TTtime)userInfo:nil repeats:YES];
        _GameDMX = [UIButton buttonWithType:UIButtonTypeCustom];
        _GameDMX.frame = CGRectMake(111,self.view.bounds.size.height - 55 , 98, 52);
        [_GameDMX setBackgroundImage:[UIImage imageNamed:@"NDMX.PNG"] forState:UIControlStateNormal];
        [_GameDMX addTarget:self action:@selector(gameDMX) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_GameDMX];
        
        _GameDMX.alpha = 0.0;
        _GameDMX.userInteractionEnabled = NO;
    }

    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-----------------
-(void)gameOpen
{
   
    _GameOpen.alpha = 0.0;
    _GameOpen.userInteractionEnabled = NO;
    _GameEnd.alpha = 1.0;
    _GameEnd.userInteractionEnabled = YES;
    
    
    
    ident =  RQIdentifierForGetnophoneflag;
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:GetnophoneflagURL]];
    [upLoadRequest setPostValue:[defaults objectForKey:@"usergamehomenum"] forKey:@"gamehomenum"];
    //[upLoadRequest setPostValue:@"1" forKey:@"isgameover"];
    [upLoadRequest setPostValue:@"1" forKey:@"nophoneflag"];
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];
    
    [defaults setObject:@"1" forKey:@"NOphoneEND"];//Nophone开始
    
    JStime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(OpenGameTime)userInfo:nil repeats:YES];
    _GametimeImage.alpha = 1.0;
    _TimeView.frame = CGRectMake(115, 365, 90, 16);
    [GameListData removeAllObjects];
    [GameList reloadData];
    //[GameList removeFromSuperview];
    
    
}

-(void)gameEnd
{
    //[_GameEnd removeFromSuperview];
    _GameEnd.alpha = 0.0;
    _GameEnd.userInteractionEnabled = NO;
    
    _GameDMX.alpha = 1.0;
    _GameDMX.userInteractionEnabled = YES;
    
    //[JStime setFireDate:[NSDate distantFuture]];//暂停
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"0" forKey:@"NOphoneEND"];//Nophone开始
       //[_chattime setFireDate:[NSDate date]];//继续
    
    _GametimeImage.alpha = 0.0;
    _TimeView.frame = CGRectMake(115, 290, 90, 16);// 365
    
    [_GamebackImage stopAnimating];
    
    _GamebackImage.image = [UIImage imageNamed:@"0000.PNG"];
    NSArray * myImages1 = [NSArray arrayWithObjects:
                           [UIImage imageNamed:@"0000.PNG"],
                           [UIImage imageNamed:@"0001.PNG"],
                           [UIImage imageNamed:@"0002.PNG"],
                           [UIImage imageNamed:@"0003.PNG"],
                           [UIImage imageNamed:@"0004.PNG"],
                           [UIImage imageNamed:@"0005.PNG"],
                           [UIImage imageNamed:@"0006.PNG"],
                           [UIImage imageNamed:@"0007.PNG"],
                           [UIImage imageNamed:@"0008.PNG"],
                           [UIImage imageNamed:@"0009.PNG"],nil];
    _GamebackImage.animationImages = myImages1;
    _GamebackImage.animationDuration = 3;
    [_GamebackImage startAnimating];
    
    
}

-(void)gameDMX
{
    //[_GameDMX removeFromSuperview];
    _GameDMX.alpha = 0.0;
    _GameDMX.userInteractionEnabled = NO;
    
    [_GamebackImage stopAnimating];
    
    _GamebackImage.image = [UIImage imageNamed:@"00000.PNG"];
    NSArray * myImages1 = [NSArray arrayWithObjects:
                           [UIImage imageNamed:@"00000.PNG"],
                           [UIImage imageNamed:@"00001.PNG"],
                           [UIImage imageNamed:@"00002.PNG"],
                           [UIImage imageNamed:@"00003.PNG"],
                           [UIImage imageNamed:@"00004.PNG"],
                           [UIImage imageNamed:@"00005.PNG"],
                           [UIImage imageNamed:@"00006.PNG"],
                           [UIImage imageNamed:@"00007.PNG"],
                           [UIImage imageNamed:@"00008.PNG"],
                           [UIImage imageNamed:@"00009.PNG"],nil];
    _GamebackImage.animationImages = myImages1;
    _GamebackImage.animationDuration = 3;
    [_GamebackImage startAnimating];
    
//    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
//    if(1 == [[defaults objectForKey:@"userID"] intValue])
//    {
//    _GameOpen = [UIButton buttonWithType:UIButtonTypeCustom];
//    _GameOpen.frame = CGRectMake(117.5,self.view.bounds.size.height - 55 , 85, 48);
//    [_GameOpen setBackgroundImage:[UIImage imageNamed:@"NOpen.PNG"] forState:UIControlStateNormal];
//    [_GameOpen addTarget:self action:@selector(gameOpen) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_GameOpen];
//    }else{
//        
//        NSLog(@"加入者");
//        [TTtime setFireDate:[NSDate date]];//继续
//        Time = 0;
//    }
    
    AdventViewController * AdventV = [[AdventViewController alloc] init];
    [self.navigationController pushViewController:AdventV animated:YES];

}
//---------------

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)OpenGameTime
{
    
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    if([[defaults objectForKey:@"NOphoneEND"] intValue] == 0)
    {
        [self gameEnd];
        
        ident =  RQIdentifierForGetnophonecover;
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:GetnophonecoverURL]];
        [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
        [upLoadRequest setPostValue:[defaults objectForKey:@"usergamehomenum"] forKey:@"gamehomenum"];
        [upLoadRequest setPostValue:[NSString stringWithFormat:@"%ld",Time] forKey:@"nophonecover"];
        [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
        upLoadRequest.delegate = self;
        [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
        
        [upLoadRequest startAsynchronous];
        [JStime setFireDate:[NSDate distantFuture]];//暂停;
        Time = 0;
    
        DAtatime = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(DAtaTime)userInfo:nil repeats:YES];
    }else
    {
        [GameListData removeAllObjects];
        [GameList reloadData];
    int time1,time2,time3,time4,time5,time6;
    time1 = Time/36000%2;
    time2 = Time/3600%24;
    time3 = Time/600%6;
    time4 = Time/60%10;
    time5 = Time/10%6;
    time6 = Time%10;
    
    Time++;
    for(UIImageView * imageV in [_TimeView subviews])
    {
        
        if (imageV.tag ==0   ) {
            imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.PNG",time1]];
        }
        if (imageV.tag ==10  ) {
            imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.PNG",time2]];
        }
        if (imageV.tag ==20  ) {
            imageV.image = [UIImage imageNamed:@"NMHBG.PNG"];
        }
        if (imageV.tag ==30  ) {
            imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.PNG",time3]];
        }
        if (imageV.tag ==40 ) {
            imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.PNG",time4]];
        }
        if (imageV.tag ==50 ) {
            imageV.image = [UIImage imageNamed:@"NMHBG.PNG"];
        }
        if (imageV.tag ==60  ) {
            imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.PNG",time5]];
        }

        if (imageV.tag ==70  ) {
            imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.PNG",time6]];
        }
        
    }
        
    }
}

-(void)DAtaTime
{
    //获取数据
    ident =  RQIdentifierForSendnophonecover;
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SendnophonecoverURL]];
    [upLoadRequest setPostValue:[defaults objectForKey:@"usergamehomenum"] forKey:@"gamehomenum"];
    [upLoadRequest setPostValue:[defaults objectForKey:@"sum"] forKey:@"sum"];
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];
   
}

//-------------上传信息-------------

#pragma mark - ASIHttpDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{

     NSString *str = [request responseString];
    //NSLog(@"获取数据  = %@",str);
    switch (ident) {
        case RQIdentifierForSendnophonecover:
        {//获取数据
            NSLog(@"获取数据  = %@",str);
            if(str != nil)
            {
                _GamebackImage.image = [UIImage imageNamed:@"00000.PNG"];
                NSArray * myImages1 = [NSArray arrayWithObjects:
                                       [UIImage imageNamed:@"00000.PNG"],
                                       [UIImage imageNamed:@"00001.PNG"],
                                       [UIImage imageNamed:@"00002.PNG"],
                                       [UIImage imageNamed:@"00003.PNG"],
                                       [UIImage imageNamed:@"00004.PNG"],
                                       [UIImage imageNamed:@"00005.PNG"],
                                       [UIImage imageNamed:@"00006.PNG"],
                                       [UIImage imageNamed:@"00007.PNG"],
                                       [UIImage imageNamed:@"00008.PNG"],
                                       [UIImage imageNamed:@"00009.PNG"],nil];
                _GamebackImage.animationImages = myImages1;
                _GamebackImage.animationDuration = 3;
                [_GamebackImage startAnimating];
                
            NSArray * array = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            [GameListData removeAllObjects];
            for(NSDictionary * dict in array)
            {
                [GameListData addObject:dict];
            }
                 [DAtatime setFireDate:[NSDate distantFuture]];//暂停;
                GameList = [[UITableView alloc] initWithFrame:CGRectMake(80, 310, 160, 175) style:UITableViewStylePlain];
                GameList.separatorStyle = UITableViewCellSeparatorStyleNone;//去除边框
                //_tableV.backgroundColor = [UIColor clearColor];//UIColorFromRGB(0xe6e6e6);
                GameList.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth;
                //_tableV.rowHeight = 40.0;
                GameList.dataSource = self;
                GameList.delegate = self;
                GameList.showsVerticalScrollIndicator = NO;//垂直滚动条
                GameList.backgroundColor = [UIColor clearColor];
                [self.view addSubview:GameList];

                
            }
            
            //NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            //[GameListData removeAllObjects];
            
            
        }break;
        case RQIdentifierForGetnophonecover:
        {
            NSLog(@"上传数据  = %@",str);
            //NSArray * array = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            
        }break;
        case RQIdentifierForStartnophone:
        {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            NSLog(@"是否开始 = %@,%@",str,[defaults objectForKey:@"userID"]);
            if([[dictionary objectForKey:@"nophoneflag"] intValue] == 1 && 0 == [[defaults objectForKey:@"userID"] intValue])
            {
                
                NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                [defaults setObject:[dictionary objectForKey:@"sum"] forKey:@"sum"];
                [defaults synchronize];//用synchronize方法把数据持久化到standardUse
                
                [TTtime setFireDate:[NSDate distantFuture]];//暂停
                //[JStime invalidate];//释放; 后加
                 JStime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(OpenGameTime)userInfo:nil repeats:YES];
                
                _GametimeImage.alpha = 1.0;
                _TimeView.frame = CGRectMake(115, 365, 90, 16);
                _GameEnd = [UIButton buttonWithType:UIButtonTypeCustom];
                _GameEnd.frame = CGRectMake(125,self.view.bounds.size.height - 55 , 70, 48);
                [_GameEnd setBackgroundImage:[UIImage imageNamed:@"NEnd.PNG"] forState:UIControlStateNormal];
                [_GameEnd addTarget:self action:@selector(gameEnd) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:_GameEnd];
            }
            
        }break;
            
        case RQIdentifierForGetnophoneflag:
        {
            NSLog(@"开始 = %@",str);
             NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            [defaults setObject:[dictionary objectForKey:@"sum"] forKey:@"sum"];
            [defaults synchronize];//用synchronize方法把数据持久化到standardUse
        }break;
            
        default:
            break;
    }
}

//上传失败
- (void)upLoadFailed:(ASIHTTPRequest *)request
{
//    //[activityView hidden];
//    MyAlertView *alert = [[MyAlertView alloc] initWithTitle:@"提示" contentText:@"加入游戏失败！" leftButtonTitle:nil rightButtonTitle:nil addkAlertHeight:100.0];
//    [alert show];
//    
    // [alert release];
    
    NSString *str = [request responseString];
    NSLog(@"str = %@",str);
}

//---------------------------

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
  return [GameListData count];
}


//开辟存储数据的空间
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *CellIdentifier =@"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%ld  %@",indexPath.row+1,[[[GameListData objectAtIndex:[GameListData count]-indexPath.row -1] objectForKey:@"username"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ]];//没UTF8
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


//----------------
-(void)ReturnBut
{
    NSLog(@"ReturnBut");
    
    [TTtime setFireDate:[NSDate distantFuture]];
    [DAtatime setFireDate:[NSDate distantFuture]];
    [JStime setFireDate:[NSDate distantFuture]];
    [GameNavtime setFireDate:[NSDate distantFuture]];
    
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
    
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: ([self.navigationController.viewControllers count] -2)] animated:YES];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"1" forKey:@"NOphoneEND"];
}



@end
