//
//  WCellViewController.m
//  JUJU
//
//  Created by linchuanbin on 14-5-29.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "WCellViewController.h"
#import "WNamelistViewController.h"

@interface WCellViewController ()

@end

@implementation WCellViewController

@synthesize  hometeam = hometeam, visitingteam = visitingteam, hometeamV = hometeamV,visitingteamV = visitingteamV;

static RQIdflower ident;

static int tab = 1;
static bool Open1Wend = NO;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)addTableView
{
    
    NamelistV = [[UIView alloc] initWithFrame:CGRectMake(0, 180, 320, self.view.bounds.size.height - 180)];
    NamelistV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:NamelistV];
    UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 120, 30)];
    lable.text = @"竟猜信息";
    lable.backgroundColor = [UIColor clearColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor grayColor];
    [NamelistV addSubview:lable];
    
    
    Namelist = [[UITableView alloc] initWithFrame:CGRectMake(0,30, 320, self.view.bounds.size.height - 210) style:UITableViewStylePlain];
    Namelist.separatorStyle = UITableViewCellSeparatorStyleNone;//去除边框
    //_tableV.backgroundColor = [UIColor clearColor];//UIColorFromRGB(0xe6e6e6);
    Namelist.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth;
    //_tableV.rowHeight = 40.0;
    Namelist.dataSource = self;
    Namelist.delegate = self;
    Namelist.showsVerticalScrollIndicator = NO;//垂直滚动条
    Namelist.backgroundColor = [UIColor clearColor];
    [NamelistV addSubview:Namelist];
}


-(void)hometeamB:(UIButton *)but
{
    NSLog(@"hometeamV hometeamB");
    
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    NSArray * array =[NSArray arrayWithObjects:[[defaults objectForKey:@"Modle"] objectAtIndex:1],[[defaults objectForKey:@"Modle"] objectAtIndex:2],[[defaults objectForKey:@"Modle"] objectAtIndex:6], nil];
    [defaults setObject:array forKey:@"Wlist"];
    [defaults synchronize];//用synchronize方法把数据持久化到standardUserDefaults数据库

    
    WNamelistViewController * WNamelistV = [[WNamelistViewController alloc] init];
    [self.navigationController pushViewController:WNamelistV animated:YES];
}

-(void)hometeamB1:(UIButton *)but
{
    NSLog(@"visitingteamV hometeamB1");
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
     NSArray * array =[NSArray arrayWithObjects:[[defaults objectForKey:@"Modle"] objectAtIndex:3],[[defaults objectForKey:@"Modle"] objectAtIndex:4],[[defaults objectForKey:@"Modle"] objectAtIndex:7], nil];
    [defaults setObject:array forKey:@"Wlist"];
    [defaults synchronize];//用synchronize方法把数据持久化到standardUserDefaults数据库

    
    WNamelistViewController * WNamelistV = [[WNamelistViewController alloc] init];
    [self.navigationController pushViewController:WNamelistV animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    hometeamArray = [[NSMutableArray alloc] init];
    dogfallArray = [[NSMutableArray alloc] init];
    visitingteamArray = [[NSMutableArray alloc] init];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSLog(@"WModle =%@",[defaults objectForKey:@"Modle"]);
    NSString *time = [[defaults objectForKey:@"Modle"] objectAtIndex:5];
    
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MddHHmm"];
    
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSLog(@"currentDateStr =%@，time ＝%@,_Roomnumber = %@",currentDateStr,time,[defaults objectForKey:@"_Roomnumber"]);
    Open1Wend = NO;
    if(([time intValue] - [currentDateStr intValue]) < 10 || [[defaults objectForKey:@"_Roomnumber"] length] == 1)
    {
        NSLog(@"[time intValue] - [currentDateStr intValue] == ");
        Open1Wend = YES;
    }
    //WOpenend ＝
    
    _TitleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 26)];
    _TitleImage.backgroundColor = [UIColor clearColor];
    _TitleImage.image = [UIImage imageNamed:@"WorldCupzhu.PNG"];
    [self.view addSubview:_TitleImage];
    UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, 160, 26)];
    titleLable.text = [NSString stringWithFormat:@"%@ 时间：%@",[[defaults objectForKey:@"Modle"] objectAtIndex:10],[[defaults objectForKey:@"Modle"] objectAtIndex:8],nil];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = [UIColor grayColor];
    titleLable.backgroundColor = [UIColor clearColor];

    [_TitleImage addSubview:titleLable];
    
    _TeamImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, 320, 110)];
    _TeamImage.backgroundColor = [UIColor clearColor];
    _TeamImage.image = [UIImage imageNamed:@"WCellBG.PNG"];
    _TeamImage.userInteractionEnabled = YES;
    [self.view addSubview:_TeamImage];
    
    
    hometeamV = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"icon.png"]];
    hometeamV.frame = CGRectMake(45, 14, 45, 45);
    hometeamV.clipsToBounds = YES;
    hometeamV.userInteractionEnabled = YES;
    hometeamV.layer.cornerRadius = 22.5;
    [hometeamV.layer setBorderWidth:1.0]; //边框宽度
    [hometeamV.layer setBorderColor:[[UIColor blackColor] CGColor]];
    hometeamV.backgroundColor = [UIColor clearColor];
    
    UIButton * hometeamB = [UIButton buttonWithType:UIButtonTypeCustom];
    hometeamB.frame = CGRectMake(0,0, 45, 45);
    hometeamB.layer.cornerRadius = 22.5;
    hometeamB.backgroundColor = [UIColor clearColor];
    [hometeamB addTarget:self action:@selector(hometeamB:) forControlEvents:UIControlEventTouchUpInside];
    [hometeamV addSubview:hometeamB];
    
    
    hometeam = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 135, 20)];
    hometeam.text = [[defaults objectForKey:@"Modle"] objectAtIndex:1];
    hometeam.textAlignment = NSTextAlignmentCenter;
    hometeam.textColor = [UIColor grayColor];
    hometeam.font = [UIFont systemFontOfSize:14];
    hometeam.backgroundColor = [UIColor clearColor];
    
    
    visitingteamV = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"icon.png"]];
    visitingteamV.frame = CGRectMake(230, 14, 45, 45);
    visitingteamV.layer.cornerRadius = 22.5;
    visitingteamV.clipsToBounds = YES;
    visitingteamV.userInteractionEnabled = YES;
    [visitingteamV.layer setBorderWidth:1.0]; //边框宽度
    [visitingteamV.layer setBorderColor:[[UIColor blackColor] CGColor]];
    visitingteamV.backgroundColor = [UIColor clearColor];
    
    UIButton * hometeamB1 = [UIButton buttonWithType:UIButtonTypeCustom];
    hometeamB1.frame = CGRectMake(0,0, 45, 45);
    hometeamB1.layer.cornerRadius = 22.5;
    hometeamB1.backgroundColor = [UIColor clearColor];
    [hometeamB1 addTarget:self action:@selector(hometeamB1:) forControlEvents:UIControlEventTouchUpInside];
    [visitingteamV addSubview:hometeamB1];
    
    visitingteam = [[UILabel alloc] initWithFrame:CGRectMake(185, 60, 135, 20)];
    visitingteam.text = [[defaults objectForKey:@"Modle"] objectAtIndex:3];
    visitingteam.textAlignment = NSTextAlignmentCenter;
    visitingteam.textColor = [UIColor grayColor];
    visitingteam.backgroundColor = [UIColor clearColor];
    visitingteam.font = [UIFont systemFontOfSize:14];
    
    
   // UIImageView * ResultV = [[UIImageView  alloc] initWithFrame:CGRectMake(105, 5, 110, 35)];
   // ResultV.image = [UIImage imageNamed:@"WBG.png"];
   // ResultV.backgroundColor = [UIColor clearColor];
    
    Result = [[UILabel alloc] initWithFrame:CGRectMake(105, 5, 110, 35)];
    Result.textAlignment = NSTextAlignmentCenter;
    Result.textColor = [UIColor grayColor];
    Result.backgroundColor = [UIColor clearColor];
    Result.font = [UIFont systemFontOfSize:20];
    //[ResultV addSubview:Result];

    
    hometeamV.imageURL = [NSURL URLWithString:[[defaults objectForKey:@"Modle"] objectAtIndex:2]];
    visitingteamV.imageURL = [NSURL URLWithString:[[defaults objectForKey:@"Modle"] objectAtIndex:4]];
    
    
    [_TeamImage addSubview:hometeamV];
    [_TeamImage addSubview:hometeam];
    [_TeamImage addSubview:visitingteamV];
    [_TeamImage addSubview:visitingteam];
    
    
    if([[defaults objectForKey:@"Modle"] count] > 11)
    {
        Result.text = [[defaults objectForKey:@"Modle"] objectAtIndex:11];
        [_TeamImage addSubview:Result];
    }else
    {
       // Result.text = [[defaults objectForKey:@"Modle"] objectAtIndex:8];
       // [_TeamImage addSubview:Result];
    }
    //else  Result.text = @"暂无";

    
    
    
    ident =  RQIdentifierForSenduseroutcome;
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SenduseroutcomeURL]];
    [upLoadRequest setPostValue:[defaults objectForKey:@"_Roomnumber"] forKey:@"homenum"];
    [upLoadRequest setPostValue:[[defaults objectForKey:@"Modle"] objectAtIndex:0] forKey:@"againstid"];
    [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)hometeamBut
{
    
    dogfallbut.alpha = 0.0;
    dogfallbut.userInteractionEnabled = NO;
    visitingteamBut.alpha = 0.0;
    visitingteamBut.userInteractionEnabled = NO;
    hometeamBut.userInteractionEnabled = NO;
    tab = 1;
    [self addQuizV];
}

-(void)dogfallbut
{
    //平
    dogfallbut.alpha = 0.0;
    dogfallbut.userInteractionEnabled = NO;
    visitingteamBut.alpha = 0.0;
    visitingteamBut.userInteractionEnabled = NO;
    hometeamBut.alpha = 0.0;
    hometeamBut.userInteractionEnabled = NO;
    

    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd,HH:mm"];
    
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSLog(@"%@",currentDateStr);

    
    //[self addTableView];
    ident =  RQIdentifierForGetuseroutcome;
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSLog(@"eee=%@",[[defaults objectForKey:@"Modle"] objectAtIndex:0]);
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:GetuseroutcomeURL]];
    [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
    [upLoadRequest setPostValue:[defaults objectForKey:@"_Roomnumber"] forKey:@"homenum"];
    [upLoadRequest setPostValue:nil forKey:@"useroutcome"];
    [upLoadRequest setPostValue:[[defaults objectForKey:@"Modle"] objectAtIndex:0] forKey:@"againstid"];
    [upLoadRequest setPostValue:@"0" forKey:@"teamid"];
    [upLoadRequest setPostValue:currentDateStr forKey:@"date"];
    
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];
    
    
   // [self addQuizV];
}

-(void)visitingteamBut
{
    dogfallbut.alpha = 0.0;
    dogfallbut.userInteractionEnabled = NO;
    hometeamBut.alpha = 0.0;
    hometeamBut.userInteractionEnabled = NO;
    visitingteamBut.userInteractionEnabled = NO;
    tab = 2;
    [self addQuizV];
    
    

}

-(void)JIA
{
    for(UILabel * lable in [QuizV subviews])
    {
        if(lable.tag == 10)
        {
            lable.text = [NSString stringWithFormat:@"%D",[lable.text intValue]+1];
        }
    }
}

-(void)Jian
{
    for(UILabel * lable in [QuizV subviews])
    {
        if(lable.tag == 10)
        {
            if([lable.text intValue] > 0)
            lable.text = [NSString stringWithFormat:@"%D",[lable.text intValue]-1];
        }
    }
}


-(void)addQuizV
{
    QuizV = [[UIView alloc] init];
    QuizV.frame = CGRectMake(0,180 , 320, 120);
    QuizV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:QuizV];
    
    UIImageView * BGView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 50)];
    BGView.image = [UIImage imageNamed:@"BGView.png"];
    BGView.backgroundColor = [UIColor clearColor];
    BGView.userInteractionEnabled = YES;
    [QuizV addSubview:BGView];
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 100, 15)];
    title.backgroundColor = [UIColor clearColor];
    title.text = @"选择净胜球";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:12];
    [BGView addSubview:title];
    
    UIImageView * xzbg = [[UIImageView alloc] initWithFrame:CGRectMake(137, 20, 25, 25)];
    xzbg.image = [UIImage imageNamed:@"xzbg.png"];
    xzbg.backgroundColor = [UIColor clearColor];
    [BGView addSubview:xzbg];
    UILabel * SHu = [[UILabel alloc] initWithFrame:CGRectMake(147, 30, 25, 25)];
    SHu.backgroundColor = [UIColor clearColor];
    SHu.tag = 10;
    SHu.text = @"1";
    SHu.textAlignment = NSTextAlignmentCenter;
    SHu.textColor = [UIColor whiteColor];
    SHu.font = [UIFont systemFontOfSize:12];
    [QuizV addSubview:SHu];
    
    UIButton * JIA = [UIButton buttonWithType:UIButtonTypeCustom];
    JIA.frame  = CGRectMake(185, 20, 25, 25);
    [JIA setTitle:@"+" forState:UIControlStateNormal];
    [JIA addTarget:self action:@selector(JIA) forControlEvents:UIControlEventTouchUpInside];
    [BGView addSubview:JIA];
    
    UIButton * Jian = [UIButton buttonWithType:UIButtonTypeCustom];
    Jian.frame  = CGRectMake(100, 20, 25, 25);
    [Jian setTitle:@"-" forState:UIControlStateNormal];
    [Jian addTarget:self action:@selector(Jian) forControlEvents:UIControlEventTouchUpInside];
    [BGView addSubview:Jian];


    
    UIButton * Ignore = [UIButton buttonWithType:UIButtonTypeCustom];
    Ignore.frame  = CGRectMake(41, 75,103, 33);
    //[Ignore setTitle:@"-" forState:UIControlStateNormal];
    [Ignore setImage:[UIImage imageNamed:@"WIgnore.png"] forState:UIControlStateNormal];
    [Ignore addTarget:self action:@selector(Ignore) forControlEvents:UIControlEventTouchUpInside];
    [QuizV addSubview:Ignore];
    
    UIButton * Determine = [UIButton buttonWithType:UIButtonTypeCustom];
    Determine.frame  = CGRectMake(176, 75,103, 33);
    [Determine setImage:[UIImage imageNamed:@"WDetermine.png"] forState:UIControlStateNormal];
    [Determine addTarget:self action:@selector(Determine) forControlEvents:UIControlEventTouchUpInside];
    [QuizV addSubview:Determine];
    
    
}


-(void)Ignore
{
    //忽略
    [QuizV removeFromSuperview];
    visitingteamBut.alpha = 0.0;
    dogfallbut.alpha = 0.0;
    dogfallbut.userInteractionEnabled = NO;
    hometeamBut.alpha = 0.0;
    hometeamBut.userInteractionEnabled = NO;
    visitingteamBut.userInteractionEnabled = NO;
    
    //[self addTableView];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd,HH:mm"];
    
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSLog(@"%@",currentDateStr);
    
    ident =  RQIdentifierForGetuseroutcome;
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
   // hometeamV.imageURL = [NSURL URLWithString:[[defaults objectForKey:@"Modle"] objectAtIndex:2]];
   // visitingteamV.imageURL = [NSURL URLWithString:[[defaults objectForKey:@"Modle"] objectAtIndex:4]];

    NSLog(@"eee=%@",[[defaults objectForKey:@"Modle"] objectAtIndex:0]);
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:GetuseroutcomeURL]];
    [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
    [upLoadRequest setPostValue:[defaults objectForKey:@"_Roomnumber"] forKey:@"homenum"];
    [upLoadRequest setPostValue:nil forKey:@"useroutcome"];
    [upLoadRequest setPostValue:[[defaults objectForKey:@"Modle"] objectAtIndex:0] forKey:@"againstid"];
    [upLoadRequest setPostValue:[NSString stringWithFormat:@"%D",tab] forKey:@"teamid"];
    [upLoadRequest setPostValue:currentDateStr forKey:@"date"];

    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];
    
}

-(void)Determine
{//确定
    
    NSString * RSHu ;
    for(UILabel * lable in [QuizV subviews])
    {
        if(lable.tag == 10)
        {
            RSHu = lable.text;
        }
    }
   [QuizV removeFromSuperview];
    visitingteamBut.alpha = 0.0;
    dogfallbut.alpha = 0.0;
    dogfallbut.userInteractionEnabled = NO;
    hometeamBut.alpha = 0.0;
    hometeamBut.userInteractionEnabled = NO;
    visitingteamBut.userInteractionEnabled = NO;
    
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd,HH:mm"];
    
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSLog(@"%@",currentDateStr);
    
    //[self addTableView];
    
    ident =  RQIdentifierForGetuseroutcome;
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSLog(@"eee=%@",[[defaults objectForKey:@"Modle"] objectAtIndex:0]);
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:GetuseroutcomeURL]];
    [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
    [upLoadRequest setPostValue:[defaults objectForKey:@"_Roomnumber"] forKey:@"homenum"];
    [upLoadRequest setPostValue:RSHu forKey:@"useroutcome"];
    [upLoadRequest setPostValue:[[defaults objectForKey:@"Modle"] objectAtIndex:0] forKey:@"againstid"];
    [upLoadRequest setPostValue:[NSString stringWithFormat:@"%D",tab] forKey:@"teamid"];
    [upLoadRequest setPostValue:currentDateStr forKey:@"date"];
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
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];

    switch (ident) {
        case RQIdentifierForGetuseroutcome:
        {
            //上传数据
            NSLog(@"上传数据 = %@",str);
            
            ident =  RQIdentifierForSenduseroutcome;
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SenduseroutcomeURL]];
            [upLoadRequest setPostValue:[defaults objectForKey:@"_Roomnumber"] forKey:@"homenum"];
            [upLoadRequest setPostValue:[[defaults objectForKey:@"Modle"] objectAtIndex:0] forKey:@"againstid"];
            [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
            [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
            upLoadRequest.delegate = self;
            [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
            
            [upLoadRequest startAsynchronous];
        }break;
        case RQIdentifierForUpdateuseroutcome:
        {
            NSLog(@"RQIdentifierForUpdateuseroutcome %@",str);//{"cerateresult":"删除成功"}
            if(!Open1Wend){
                
            hometeamBut = [UIButton buttonWithType:UIButtonTypeCustom];
            hometeamBut.frame = CGRectMake(53, 88, 29, 18);
            [hometeamBut setImage:[UIImage imageNamed:@"Yes.png"] forState:UIControlStateNormal];
            [hometeamBut addTarget:self action:@selector(hometeamBut) forControlEvents:UIControlEventTouchUpInside];
            [_TeamImage addSubview:hometeamBut];
            
            dogfallbut = [UIButton buttonWithType:UIButtonTypeCustom];
            dogfallbut.frame = CGRectMake(145, 88, 29, 18);
            [dogfallbut setImage:[UIImage imageNamed:@"dogfall.png"] forState:UIControlStateNormal];
            [dogfallbut addTarget:self action:@selector(dogfallbut) forControlEvents:UIControlEventTouchUpInside];
            [_TeamImage addSubview:dogfallbut];
            
            visitingteamBut = [UIButton buttonWithType:UIButtonTypeCustom];
            visitingteamBut.frame = CGRectMake(238, 88, 29, 18);
            [visitingteamBut setImage:[UIImage imageNamed:@"Yes.png"] forState:UIControlStateNormal];
            [visitingteamBut addTarget:self action:@selector(visitingteamBut) forControlEvents:UIControlEventTouchUpInside];
            [_TeamImage addSubview:visitingteamBut];
                
            }
            
        }break;
        case RQIdentifierForSenduseroutcome:
        {//下载数据
           NSLog(@"下载数据 = %@",str);
            if([str hasPrefix:@"["] == 1)
            {
                array = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
                
                [hometeamArray removeAllObjects];
                 [dogfallArray removeAllObjects];
                 [visitingteamArray removeAllObjects];
                
                for(NSDictionary *dict in array)
                {
                    //[hometeamArray addObject:dict];
                    switch ([[dict objectForKey:@"teamid"] intValue]) {
                        case 0:
                        {
                            [dogfallArray addObject:dict];
                            //[dogfallArray addObject:dict];
                        }break;
                        case 1:
                        {
                            [hometeamArray addObject:dict];

                        }break;
                        case 2:
                        {
                            [visitingteamArray addObject:dict];

                        }break;
                            
                        default:
                            break;
                    }
                }
                
                [self addTableView];
                [Namelist reloadData];
                
                
            }else if([str hasPrefix:@"{"] == 1)
            {
                dictionary = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
                if([[dictionary objectForKey:@"cerateresult"] intValue] == 0)
                {
                     //不加载数据
                    
                    if(!Open1Wend){
                        NSLog(@"不加载数据");
                    hometeamBut = [UIButton buttonWithType:UIButtonTypeCustom];
                    hometeamBut.frame = CGRectMake(53, 88, 29, 18);
                    [hometeamBut setImage:[UIImage imageNamed:@"Yes.png"] forState:UIControlStateNormal];
                    [hometeamBut addTarget:self action:@selector(hometeamBut) forControlEvents:UIControlEventTouchUpInside];
                    [_TeamImage addSubview:hometeamBut];
                    
                    dogfallbut = [UIButton buttonWithType:UIButtonTypeCustom];
                    dogfallbut.frame = CGRectMake(145, 88, 29, 18);
                    [dogfallbut setImage:[UIImage imageNamed:@"dogfall.png"] forState:UIControlStateNormal];
                    [dogfallbut addTarget:self action:@selector(dogfallbut) forControlEvents:UIControlEventTouchUpInside];
                    [_TeamImage addSubview:dogfallbut];
                    
                    visitingteamBut = [UIButton buttonWithType:UIButtonTypeCustom];
                    visitingteamBut.frame = CGRectMake(238, 88, 29, 18);
                    [visitingteamBut setImage:[UIImage imageNamed:@"Yes.png"] forState:UIControlStateNormal];
                    [visitingteamBut addTarget:self action:@selector(visitingteamBut) forControlEvents:UIControlEventTouchUpInside];
                    [_TeamImage addSubview:visitingteamBut];
                    }
                    //[_TeamImage addSubview:<#(UIView *)#>];
                    
                }
    
            }
        }
            
        default:
            break;
    }
    //NSLog(@"获取数据  = %@",str);
    
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

//返回section数量（没实现默认1）
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}

//自动调用后
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60.0f;
    
}


//返回每个section的元数个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0: return [hometeamArray count]; break;
        case 1: return [visitingteamArray count]; break;
        case 2: return [dogfallArray count]; break;
            
        default:
            break;
    }
    
    return 0;
}


//头部
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //返回指定的 section header 的view，如果没有，这个函数可以不返回view
     NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    UIImageView * backgroundV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    backgroundV.image = [UIImage imageNamed:@"BGView.png"];
    
    EGOImageView * homeV = [[EGOImageView alloc] initWithPlaceholderImage:hometeamV.image];
    homeV.frame = CGRectMake(30, 8, 24, 24);
    homeV.clipsToBounds = YES;
    homeV.layer.cornerRadius = 12;
    [homeV.layer setBorderWidth:1.0]; //边框宽度
    [homeV.layer setBorderColor:[[UIColor blackColor] CGColor]];
    homeV.backgroundColor = [UIColor clearColor];
    [backgroundV addSubview:homeV];
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(55, 10, 80, 20)];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor  grayColor];
    title.font = [UIFont systemFontOfSize:12];
    title.backgroundColor = [UIColor clearColor];
    [backgroundV addSubview:title];
    
    switch (section) {
        case 0:{
            //homeV.imageURL = [NSURL URLWithString:[[defaults objectForKey:@"Modle"] objectAtIndex:2]];
            title.text = [NSString stringWithFormat:@"支持%@",[[defaults objectForKey:@"Modle"] objectAtIndex:1]];
        }break;
        case 1:{
            homeV.image = visitingteamV.image;
            title.text = [NSString stringWithFormat:@"支持%@",[[defaults objectForKey:@"Modle"] objectAtIndex:3]];
        }break;
        case 2:{
            homeV.image = hometeamV.image;
            title.text = @"认为平局";
            
            EGOImageView * homeV1 = [[EGOImageView alloc] initWithPlaceholderImage:visitingteamV.image];
            homeV1.frame = CGRectMake(140, 8, 24, 24);
            homeV1.clipsToBounds = YES;
            homeV1.layer.cornerRadius = 12;
            [homeV1.layer setBorderWidth:1.0]; //边框宽度
            [homeV1.layer setBorderColor:[[UIColor blackColor] CGColor]];
            homeV1.backgroundColor = [UIColor clearColor];
            [backgroundV addSubview:homeV1];
            //homeV1.imageURL = [NSURL URLWithString:[[defaults objectForKey:@"Modle"] objectAtIndex:4]];
            
        }break;
            
        default:
            break;
    }
    

    return backgroundV;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSLog(@"heightForHeaderInSection-->%zi",section);
    //这个方法返回指定的 section的header view 的高度
    return 40;
}



//开辟存储数据的空间
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath.row = %D",indexPath.row);
    static NSString *CellIdentifier =@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString * title;
    
    switch (indexPath.section) {
        case 0:
        {
            NSLog(@"indexPath.row = %D",indexPath.row);
            if([hometeamArray count] > 0)
            {
                NSString * str;
                if([[[hometeamArray objectAtIndex:indexPath.row] objectForKey:@"useroutcome"] length] > 0)
                {
                    str = [NSString stringWithFormat:@"净胜球  %@",[[hometeamArray objectAtIndex:indexPath.row] objectForKey:@"useroutcome"]];
                } else str = @"";
                
                title = [NSString stringWithFormat:@"%@         %@",[[[hometeamArray objectAtIndex:indexPath.row] objectForKey:@"username"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding],str];
            }else title = nil;
            
        }break;
        case 1:
        {
            NSLog(@"indexPath.row = %D",indexPath.row);
            NSString * str;
            if([[[visitingteamArray objectAtIndex:indexPath.row] objectForKey:@"useroutcome"] length] > 0)
            {
                str = [NSString stringWithFormat:@"净胜球  %@",[[visitingteamArray objectAtIndex:indexPath.row] objectForKey:@"useroutcome"]];
            }else  str = @"";
            if([visitingteamArray count] > 0)
            {
                title = [NSString stringWithFormat:@"%@         %@",[[[visitingteamArray objectAtIndex:indexPath.row] objectForKey:@"username"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding],str];
            }else title = nil;
            
        }break;
        case 2:
        {
            NSLog(@"indexPath.row = %D",indexPath.row);
            if([dogfallArray count] > 0)
            {
                title = [NSString stringWithFormat:@"%@",[[[dogfallArray objectAtIndex:indexPath.row] objectForKey:@"username"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                
            }else title = nil;
            
        }break;
            
        default:
            break;
    }
    
    cell.textLabel.text = title;
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;//没有点击效果(可以点击)
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"dan ji");
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString * IDD = [defaults objectForKey:@"_userID"];
    NSLog(@"IDD%@",IDD);
    switch (indexPath.section) {
        case 0:{
            NSString * UIID = [[hometeamArray objectAtIndex:indexPath.row] objectForKey:@"id"];
            NSLog(@"UIID0 = %@",UIID);
            if([UIID intValue] == [IDD intValue])
            {
                NSLog(@"return YES;");
                return YES;
            }else{
                return NO;
            }
            //[hometeamArray removeObjectAtIndex:indexPath.row];
        }break;
        case 1:{
            NSString * UIID = [[visitingteamArray objectAtIndex:indexPath.row] objectForKey:@"id"];
            NSLog(@"UIID1 = %@",UIID);
            if([UIID intValue] == [IDD intValue])
            {
                NSLog(@"return YES1;");
                return YES;
            }else{
                return NO;
            }
            //[visitingteamArray removeObjectAtIndex:indexPath.row];
            
        }break;
        case 2:{
            NSString * UIID = [[dogfallArray objectAtIndex:indexPath.row] objectForKey:@"id"];
            NSLog(@"UIID2 = %@",UIID);

            if([UIID intValue] == [IDD intValue])
            {
                NSLog(@"return YES2;");
                return YES;
            }else{
                return NO;
            }
            
            //[dogfallArray removeObjectAtIndex:indexPath.row];
        }break;
            
        default:
            break;
    }
    return YES;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        switch (indexPath.section) {
            case 0:{
                [hometeamArray removeObjectAtIndex:indexPath.row];
            }break;
            case 1:{
                [visitingteamArray removeObjectAtIndex:indexPath.row];

            }break;
            case 2:{
                [dogfallArray removeObjectAtIndex:indexPath.row];
            }break;
                
            default:
                break;
        }

        // Delete the row from the data source.
        //[dogfallArray removeObjectAtIndex:indexPath.row];
        [Namelist deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [NamelistV removeFromSuperview];
        
        
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        ident =  RQIdentifierForUpdateuseroutcome;
        upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:UpdateuseroutcomeURL]];
        [upLoadRequest setPostValue:[defaults objectForKey:@"_Roomnumber"] forKey:@"homenum"];
        [upLoadRequest setPostValue:[[defaults objectForKey:@"Modle"] objectAtIndex:0] forKey:@"againstid"];
        [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
        [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
        upLoadRequest.delegate = self;
        [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
        
        [upLoadRequest startAsynchronous];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}



@end
