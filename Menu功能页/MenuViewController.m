//
//  MenuViewController.m
//  JUJU
//
//  Created by linchuanbin on 14-5-17.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "MenuViewController.h"
#import "GameListCell.h"
#import "GameunderwayCell.h"
#import "MyPageControl.h"
#import "ListCell.h"
#import "ListModel.h"

#import "OrganigerViewController.h"
#import "ParticipantViewController.h"

#import "ForganigerViewController.h"
#import "FJionViewController.h"
#import "WJionViewController.h"
#import "NOrganigerViewController.h"


#import "AdventViewController.h"



#import "GorganigerViewController.h"
#import "GJionViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController
@synthesize BackImage = _BackImage, ChatImage = _ChatImage, GameTitleImage = _GameTitleImage, GamebackImage = _GamebackImage, Namelist = _Namelist, Gameunderway = _Gameunderway, GameList = _GameList, HomeV = _HomeV, Roomnumber = _Roomnumber;


//static long MessageID = 0;
static RQIdflower ident;
static BOOL TAA = YES;
static long buttontag = 0;
static bool ChatTAB = YES;
static bool Bbut = YES;
static bool PressTAB  = YES;
static bool YQTAB = YES;//邀请
static bool OPenBUT = NO;//是否建房
static bool sxnamelistTab = YES;

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
            
        {
            [self prefersStatusBarHidden];
            
            [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];//隐藏状态栏
        }

               // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    //[Chatdatatime setFireDate:[NSDate date]];//继续;
    [self.navigationController setNavigationBarHidden:YES];
    
 NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
 NSLog(@"viewWillAppear %@",[defaults objectForKey:@"_GmaeName"]);
    YQTAB = YES;
    //[Chatdatatime setFireDate:[NSDate date]];//继续;
//    
//    if(OPenBUT)
//    {
//        NSLog(@"OPenBUT");
//        [_GameunderwayData removeAllObjects];
//        [self addGameunderwayData];
//    }
    
    if(OPenBUT)
    {
        NSLog(@"OPenBUT");
    //[activityView show];
    ident =  RQIdentifierForGameinfolist;
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:GameinfolistURL]];
    [upLoadRequest setPostValue:[defaults objectForKey:@"_GmaeName"] forKey:@"gamename"];
    [upLoadRequest setPostValue:[defaults objectForKey:@"_Roomnumber"] forKey:@"homenum"];
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];
    }
    

}



-(void)endBut
{
    NSLog(@"退出");
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"1" forKey:@"_Roomnumber"];
    //[defaults synchronize];
  
    for(GameunderwayCell * MCell in [_Gameunderway subviews])
    {
        [MCell removeFromSuperview];
    }
    
    [_GameunderwayData removeAllObjects];
    [self addGameunderwayData];
    
    [_Chatdata removeAllObjects];
    [_Chatdata addObject:@"欢迎来到聚聚平台！"];
    //[_Chatdata addObject:@"输入局号码直接进入！"];
    //[_Chatdata addObject:@"输入您的游戏昵称！"];
    [ChatTab reloadData];

    
    [UIView animateWithDuration:0.5 animations:^{
        _Namelist.frame = CGRectMake(0,- self.view.bounds.size.height, 320, self.view.bounds.size.height);
    }completion:^(BOOL finished){
        
        //[_GameunderwayData removeAllObjects];
        //[self addGameunderwayData];
        
        NameBG.alpha = 0.0;
        [activityView show];
        ident =  RQIdentifierForExithome;
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:ExithomeURL]];
        [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
        [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
        upLoadRequest.delegate = self;
        [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
        
        [upLoadRequest startAsynchronous];
    }];
    
    //[_chattime setFireDate:[NSDate distantFuture]];//暂停
    //[_chattime setFireDate:[NSDate date]];//继续
}



-(void)handlePanGesture:(UIPanGestureRecognizer*)sender
{
    
    
     NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    Title1.text = [NSString stringWithFormat:@"房间号：%@",[defaults objectForKey:@"_Roomnumber"]];
    
    CGPoint translation=[(UIPanGestureRecognizer*)sender translationInView:_Namelist];
    NSLog(@"yy = %f",translation.y);
    if(translation.y < 0)
    {
         [Chatdatatime setFireDate:[NSDate date]];//继续;
        _Namelist.frame = CGRectMake(0,_Namelist.bounds.origin.y + translation.y , 320, self.view.bounds.size.height);
        if(translation.y < -50)
            [UIView animateWithDuration:0.5 animations:^{
                _Namelist.frame = CGRectMake(0, 35 - self.view.bounds.size.height, 320, self.view.bounds.size.height);
                NameBG.alpha = 0.0;
                [NBut setBackgroundImage:[UIImage imageNamed:@"x.PNG"] forState:UIControlStateNormal];
                sxnamelistTab = YES;
            }];
        
    }
    else
    {
        [Chatdatatime setFireDate:[NSDate distantFuture]];
        
        _Namelist.frame = CGRectMake(0,35 - self.view.bounds.size.height + translation.y, 320, self.view.bounds.size.height);
        if(translation.y > 50)
            //animateWithDuration:animations:completion: 时间  开始 结束
            [UIView animateWithDuration:0.5 animations:^
        {
            _Namelist.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
            sxnamelistTab = NO;
            
            } completion:^(BOOL finished){
                if(finished)NameBG.alpha = 1.0;
                [NBut setBackgroundImage:[UIImage imageNamed:@"s.PNG"] forState:UIControlStateNormal];
                NSLog(@" 下拉结束");
                
                
               
                
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
                
            }];
        
    }
    
    //    CGPoint curPoint = [sender locationInView:self.view];
    //    [_namelist setCenter:curPoint];
}


-(void)Tapclick
{
    [Chatdatatime setFireDate:[NSDate distantFuture]];
    NSLog(@"点击");
    
    [NBut setBackgroundImage:[UIImage imageNamed:@"s.PNG"] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 animations:^{
        _Namelist.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
        sxnamelistTab = NO;
        
    }completion:^(BOOL finished){
        NameBG.alpha = 1.0;
        [activityView show];
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        Title1.text = [NSString stringWithFormat:@"房间号：%@",[defaults objectForKey:@"_Roomnumber"]];
        ident =  RQIdentifierForSendUserinfo;
        upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SendUserinfoURL]];
        
        [upLoadRequest setPostValue:[defaults objectForKey:@"_Roomnumber"] forKey:@"homenumber"];//房间号
        
        [upLoadRequest setTimeOutSeconds:30.f];//设置超时秒
        
        upLoadRequest.delegate = self;
        [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
        
        [upLoadRequest startAsynchronous];

    }];
    
}

//________加入房间______________
-(void)endButton
{
    [self resignFirstResponder];  // 回收键盘
    [UIView animateWithDuration:0.5 animations:^{
        gameNaV.bounds = CGRectMake(0, 0, 0, 0);
    }completion:^(BOOL finished){[gameNaV removeFromSuperview];
        [_Chatdata removeAllObjects];
        [_Chatdata addObject:@"欢迎来到聚聚平台。"];
        //[_Chatdata addObject:@"输入局号码直接进入。"];
       // [_Chatdata addObject:@"输入您的游戏昵称。"];
    }];
    
}

-(void)chatButton
{
    NSLog(@"加入");
    [self resignFirstResponder];  // 回收键盘
   
    
    NSString * namestr;
    for(UITextField * chattext in  [gameNaV subviews])
    {
        if(chattext.tag == 100)
        {
            namestr = chattext.text;
        }
    }
    NSLog(@"_Roomnumber.text = %@",_Roomnumber.text);

    //创建房间 和加入房间
    [activityView show];
    ident =  RQIdentifierForCreatehome;
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    //[defaults setObject:_Roomnumber.text forKey:@"_Roomnumber"];//房间号
    [defaults setObject:namestr forKey:@"Game_Name"];
    [defaults synchronize];//用synchronize方法把数据持久化到standardUserDefaults数据库
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:CreatehomeURL]];
    [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
    [upLoadRequest setPostValue:[namestr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]forKey:@"name"];//名
    [upLoadRequest setPostValue:_Roomnumber.text forKey:@"homenum"];//房间号
    [upLoadRequest setPostValue:ChatTAB ? @"1":@"0" forKey:@"userid"];//创建1 还是 加入0
    
    
     NSLog(@"UTF8 ＝ %@，中文 ＝%@",[namestr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[namestr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    
    [upLoadRequest setTimeOutSeconds:30.f];//设置超时秒
    
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];
    
    [UIView animateWithDuration:0.5 animations:^{
        gameNaV.bounds = CGRectMake(0, 0, 0, 0);
    }completion:^(BOOL finished){[gameNaV removeFromSuperview];}];
    

}

-(void)JiaRoom1
{
    [_Roomnumber resignFirstResponder];  // 回收键盘

    if(_Roomnumber.text.length == 0)
    {
        ChatTAB = YES;
        for(UIImageView * imageV in [JiaRoom subviews])
        {
            if(imageV.tag == 500)
            [imageV removeFromSuperview];
        }
        
        [JiaRoom setBackgroundImage:[UIImage imageNamed:@"ADD12.PNG"] forState:UIControlStateNormal];
        [JiaRoom setTitle:@"创建" forState:UIControlStateNormal];
        NSLog(@"获取房间号");
        NSString *strurl = [NSString stringWithFormat:SendHomeURL,nil];
        [netWork requestWithStrURL:strurl withIdentifier:RQIdentifierForSendHome];
        [activityView show];
        rqIdentifier = RQIdentifierForSendHome;
        
    }else{
        
//        if(ChatTAB){
//            //[JiaRoom setBackgroundImage:[UIImage imageNamed:@"ADD.png"] forState:UIControlStateNormal];
//            //[JiaRoom setTitle:@"创建" forState:UIControlStateNormal];
//            
//        }else{
//             ChatTAB = NO;
//            [JiaRoom setBackgroundImage:[UIImage imageNamed:@"ADD.png"] forState:UIControlStateNormal];
//            [JiaRoom setTitle:@"加入" forState:UIControlStateNormal];
//        }
        
        
       
        gameNaV = [[UIView alloc] init];
        gameNaV.backgroundColor = [UIColor blackColor];
        gameNaV.center = self.view.center;
        gameNaV.clipsToBounds = YES;
        gameNaV.bounds = CGRectMake(0, 0, 0, 0);
        
        UIImageView * BG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ChatBG.PNG"]];
        BG.center = gameNaV.center;
        BG.bounds = CGRectMake(0, 0, 320, 110);
        [gameNaV addSubview:BG];
        
        UIImageView * chatTextV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"long.PNG"]];
        chatTextV.center = CGPointMake(160, gameNaV.center.y - 20);
        chatTextV.bounds = CGRectMake(0, 0, 200, 30);
        [gameNaV addSubview:chatTextV];
       
        
        UITextField * chatText = [[UITextField alloc] init];
        //WithFrame:CGRectMake(15, 5, 200, 40)
        chatText.center = CGPointMake(160, gameNaV.center.y - 20);
        chatText.bounds = CGRectMake(0, 0, 196, 30);
        chatText.backgroundColor = [UIColor clearColor];
        chatText.tag = 100;
        //chatText.placeholder = @"输入昵称";
        UIColor *color = [UIColor whiteColor];
        chatText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入昵称" attributes:@{NSForegroundColorAttributeName: color}];
        chatText.textColor = [UIColor whiteColor];
        chatText.textAlignment = NSTextAlignmentLeft;
        chatText.delegate = self;
        chatText.keyboardType =  UIKeyboardTypeDefault;
        [gameNaV addSubview:chatText];
        
        
        UIButton *xButton = [UIButton buttonWithType:UIButtonTypeCustom];
        // [xButton setImage:[UIImage imageNamed:@"btn_close_normal.png"] forState:UIControlStateNormal];
        // [xButton setImage:[UIImage imageNamed:@"btn_close_selected.png"] forState:UIControlStateHighlighted];
        xButton.center = CGPointMake(95, gameNaV.center.y + 25);
        xButton.bounds = CGRectMake(0, 0, 75,32);
        [xButton setImage:[UIImage imageNamed:@"退出.PNG"] forState:UIControlStateNormal];
        //xButton.frame = CGRectMake( 240,5,60,40);
        //[xButton setTitle:@"退出" forState:UIControlStateNormal];
        //[xButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        [gameNaV addSubview:xButton];
        [xButton addTarget:self action:@selector(endButton) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *chatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //[chatButton setTitle:@"加入" forState:UIControlStateNormal];
        //[chatButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        //[chatButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [chatButton setImage:[UIImage imageNamed:@"加入.PNG"] forState:UIControlStateNormal];
        chatButton.center = CGPointMake(220, gameNaV.center.y + 25);
        chatButton.bounds = CGRectMake(0, 0, 75,32);
        [chatButton addTarget:self action:@selector(chatButton) forControlEvents:UIControlEventTouchUpInside];
        [gameNaV addSubview:chatButton];
        
        [self.view addSubview:gameNaV];
        [UIView animateWithDuration:0.5 animations:^{
            gameNaV.bounds = self.view.bounds;
            gameNaV.alpha = 1;
        }];

    
       // NSLog(@"UTF8 ＝ %@，中文 ＝%@",[namestr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[namestr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    }
}


-(void)chatBut1
{
    Bbut = YES;
    PressTAB = YES;
    [PopChatV removeFromSuperview];
}


-(void)BOOLbut:(UIButton * )but
{
    Bbut = !Bbut;
    if(Bbut)
    {
        [but setImage:[UIImage imageNamed:@"Mchecked.PNG"] forState:UIControlStateNormal];
    }else{
        [but setImage:[UIImage imageNamed:@"Munchecked.PNG"] forState:UIControlStateNormal];
    }
}

-(void)BOOLbut
{
    //
    NSLog(@"tuichu ");
}

//-(void)ChatTapclick:(UIGestureRecognizer*)
//-(void)ChatTapclick:(UILongPressGestureRecognizer*)sender

-(void)ADDimageVlick:(UIGestureRecognizer*)sender
{
    NSLog(@"单机触发");
    [ADDimageV removeFromSuperview];
    
}
-(void)ChatTapclick:(UIGestureRecognizer*)sender
{
    
    if(PressTAB && OPenBUT)
    {
        PressTAB = NO;
     NSLog(@"双击触发");
    
    PopChatV= [[UIView alloc] initWithFrame:self.view.bounds];
    PopChatV.backgroundColor = [UIColor whiteColor];
    PopChatV.alpha = 1.0;
    [self.view addSubview:PopChatV];
        
    UIImageView * Nav = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 44)];
    Nav.image = [UIImage imageNamed:@"MenuTitle.PNG"];
        Nav.userInteractionEnabled = YES;
    [PopChatV addSubview:Nav];
        
        
        UIButton * BOOlbut1 = [UIButton buttonWithType:UIButtonTypeCustom];
        BOOlbut1.frame = CGRectMake(280, 2, 40, 40);
        UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(12.5, 14, 15, 12)];
        imageV.image = [UIImage imageNamed:@"BOOlbut.PNG"];
        [BOOlbut1 addSubview:imageV];
        //BOOlbut1.frame = CGRectMake(280,16, 15, 12);
        //BOOlbut1 setImage:[UIImage imageNamed:@"BOOlbut.PNG"] forState:UIControlStateNormal];
        [BOOlbut1 addTarget:self action:@selector(chatBut) forControlEvents:UIControlEventTouchUpInside];
        [Nav addSubview:BOOlbut1];
       

        
    UIButton * chatBut1 = [UIButton buttonWithType:UIButtonTypeCustom];
    //[chatBut1 setTitle:@"退出" forState:UIControlStateNormal];
    //[chatBut1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[chatBut1 setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        
        chatBut1.frame = CGRectMake(0, 2, 40, 40);
        UIImageView * imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 13, 10, 14)];
        imageV1.image = [UIImage imageNamed:@"chatBut1.PNG"];
        [chatBut1 addSubview:imageV1];
    //[chatBut1 setImage:[UIImage imageNamed:@"chatBut1.PNG"] forState:UIControlStateNormal];
    //chatBut1.frame = CGRectMake(0,15, 10,14);
    [chatBut1 addTarget:self action:@selector(chatBut1) forControlEvents:UIControlEventTouchUpInside];
    [Nav addSubview:chatBut1];
        
//    UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(100, 7, 100, 30)];
//    lable.text = @"匿名白榜";
//    lable.textAlignment = NSTextAlignmentCenter;
//    lable.textColor = [UIColor whiteColor];
//    lable.backgroundColor = [UIColor clearColor];
//    [Nav addSubview:lable];

        
    
    ChatV = [[UITableView alloc] initWithFrame:CGRectMake(0,140, 320, self.view.bounds.size.height - 140) style:UITableViewStylePlain];
    ChatV.separatorStyle = UITableViewCellSeparatorStyleNone;//去除边框
    //_tableV.backgroundColor = [UIColor clearColor];//UIColorFromRGB(0xe6e6e6);
    ChatV.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth;
    ChatV.tag = 201;
    ChatV.dataSource = self;
    ChatV.delegate = self;
    ChatV.showsVerticalScrollIndicator = NO;//垂直滚动条
    //ChatV.separatorStyle = UITableViewCellSeparatorStyleNone;//没有点击效果(可以点击)
    ChatV.backgroundColor = [UIColor clearColor];
    [PopChatV addSubview:ChatV];
        
        
    //UILabel * tlelt = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 120, 30)];
    //tlelt.text = @"说点什么吧!";
    //tlelt.textAlignment = NSTextAlignmentCenter;
    //tlelt.textColor = [UIColor whiteColor];
    //tlelt.backgroundColor = [UIColor clearColor];
   // [PopChatV addSubview:tlelt];
        
//    UIImageView * ChatTextBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 40, 320, 40)];
//        ChatTextBG.tag = 103;
//        ChatTextBG.image = [UIImage imageNamed:@"BGView.png"];
//        [PopChatV addSubview:ChatTextBG];
        
        
        UIImageView * chatTextBG = [[UIImageView alloc] initWithFrame:CGRectMake(25, 86, 270, 5)];
        chatTextBG.image = [UIImage imageNamed:@"MenuX.PNG"];
        chatTextBG.backgroundColor = [UIColor clearColor];
        [PopChatV addSubview:chatTextBG];

    
    UITextField * chatText = [[UITextField alloc] init];
    //WithFrame:CGRectMake(15, 5, 200, 40)
    chatText.frame = CGRectMake(26,50, 268, 40);
    chatText.backgroundColor = [UIColor whiteColor];
    chatText.tag = 101;
    //chatText.placeholder = @"说点什么吧！";
        
        UIColor *color = [UIColor blackColor];
        chatText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"说点什么吧！" attributes:@{NSForegroundColorAttributeName: color}];
    
    chatText.textColor = [UIColor blackColor];
    chatText.textAlignment = NSTextAlignmentLeft;
    chatText.delegate = self;
    [PopChatV addSubview:chatText];
        
        
    UILabel * MR = [[UILabel alloc] initWithFrame:CGRectMake(220,100, 60, 30)];
    MR.text = @"匿名";
    MR.textAlignment = NSTextAlignmentCenter;
    MR.textColor = [UIColor blackColor];
    MR.backgroundColor = [UIColor clearColor];
   [PopChatV addSubview:MR];
        
     UIButton * BOOlbut = [UIButton buttonWithType:UIButtonTypeCustom];
     BOOlbut.frame = CGRectMake(280,100, 30, 30);
     [BOOlbut setImage:[UIImage imageNamed:@"Mchecked.PNG"] forState:UIControlStateNormal];
    [BOOlbut addTarget:self action:@selector(BOOLbut:) forControlEvents:UIControlEventTouchUpInside];
    [PopChatV addSubview:BOOlbut];
        
        
    

    
//    UIButton * chatBut = [UIButton buttonWithType:UIButtonTypeCustom];
//    [chatBut setTitle:@"发布" forState:UIControlStateNormal];
//    chatBut.tag = 102;
//    [chatBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [chatBut setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
//    chatBut.frame = CGRectMake(250,self.view.bounds.size.height - 35, 60,30);
//    [chatBut addTarget:self action:@selector(chatBut) forControlEvents:UIControlEventTouchUpInside];
//    [PopChatV addSubview:chatBut];
        
       
    }
}

-(void)chatBut
{
    
    [self resignFirstResponder];
   // Bbut = YES;
    PressTAB = YES;
    for(UITextField * Text in [PopChatV subviews])
    {
        if(Text.tag == 101)
        {
            if(Text.text.length == 0)
            {
                NSLog(@"发布失败");
                UIAlertView* a=[[UIAlertView alloc]init];
                
                a=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您没有输入发表的话!" delegate:nil cancelButtonTitle:nil otherButtonTitles: @"确定",nil];
                
                [a show];
                 
            }else{
                NSString * str = Text.text;//没UTF8
                [UIView animateWithDuration:0.5 animations:^{ PopChatV.frame = CGRectMake(0, 0, 0, 0);} completion:^(BOOL finished){
                    [PopChatV removeFromSuperview];
                }];
                [activityView show];
                //聊天数据上传
                ident =  RQIdentifierForGetMessage;
                NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:GetMessageURL]];
                [upLoadRequest setPostValue:[defaults objectForKey:@"_Roomnumber"] forKey:@"homenum"];
                [upLoadRequest setPostValue:str forKey:@"message"];
                [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
                [upLoadRequest setPostValue:Bbut ? @"0":@"1" forKey:@"flag"];//0是匿名，1是实名
                [upLoadRequest setPostValue:nil forKey:@"gamehomenum"];
                [upLoadRequest setPostValue:nil forKey:@"gamename"];
                
                [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
                upLoadRequest.delegate = self;
                [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
                
                [upLoadRequest startAsynchronous];
                Bbut = YES;
            }
        }
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    if([[defaults objectForKey:@"Opengame"] intValue] != 1)
    {
        [defaults setObject:@"1" forKey:@"Opengame"];//游戏名
        [defaults synchronize];//用synchronize方法把数据持久化到standardUserDefaults数据库
        UIScrollView * OpenT  = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        OpenT.backgroundColor = [UIColor clearColor];
        OpenT.pagingEnabled = YES;
        OpenT.tag = 4000;
        OpenT.contentSize = CGSizeMake(320*3, 568);
        for(int TT = 0; TT< 3; TT++)
        {
            UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(320*TT, 0, 320, 568)];
            image.image = [UIImage imageNamed:[NSString stringWithFormat:@"one%d.png",TT+1]];
            [OpenT addSubview:image];
            
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(320*TT, 0, 320, 568)];
            button.tag = TT+1;
            [button addTarget:self action:@selector(addJIEM:) forControlEvents:UIControlEventTouchUpInside];
            [OpenT addSubview:button];
            

            
        }
        OpenT.showsHorizontalScrollIndicator = NO;//滚动的时候是否有水平的滚动条，默认是有的
        OpenT.delegate = self;
        
        [self.view addSubview:OpenT];
        
    }else{
    
        [self addJIEM];
    }
    
    
//    NSString *strurl = [NSString stringWithFormat:SendHomeURL,nil];
//    [netWork requestWithStrURL:strurl withIdentifier:RQIdentifierForSendHome];
//    [activityView show];
//    rqIdentifier = RQIdentifierForSendHome;
//    Do any additional setup after loading the view.
    
    
}

-(void)addJIEM:(UIButton *)but
{
    switch (but.tag) {
        case 1:
        {
            for(UIScrollView * ScrlV  in [self.view subviews])
            {
                if(ScrlV.tag == 4000)
                {
                    [ScrlV setContentOffset:CGPointMake(320, 0) animated:YES];
                }
            }
            
        }break;
        case 2:
        {
            for(UIScrollView * ScrlV  in [self.view subviews])
            {
                if(ScrlV.tag == 4000)
                {
                    [ScrlV setContentOffset:CGPointMake(640, 0) animated:YES];
                }
            }
            
        }break;
        case 3:
        {
            [self addJIEM];
        }break;
            
        default:
            break;
    }
}
-(void)MenuOpen
{
    //返回上级 退到登入页。
     NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"1" forKey:@"_Username"];
    
    //[self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: ([self.navigationController.viewControllers count] -1)] animated:YES];
    [self.navigationController popViewControllerAnimated:YES];//返回上级
}

-(void)Refresh
{
    //刷新
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

-(void)addJIEM
{
    
      NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    _Chatdata =  [[NSMutableArray alloc] init];
    
    [_Chatdata addObject:@"欢迎来到聚聚平台。"];
    //[_Chatdata addObject:@"输入局号码直接进入。"];
    //[_Chatdata addObject:@"输入您的游戏昵称。"];
    
    _BackImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _BackImage.image = [UIImage imageNamed:@"BackBG.PNG"];
    [self.view addSubview:_BackImage];
    
    _ChatImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 320, 110)];
    _ChatImage.image = [UIImage imageNamed:@"ChatBG.PNG"];
    _ChatImage.backgroundColor = [UIColor clearColor];
    _ChatImage.userInteractionEnabled = YES;
    [self.view addSubview:_ChatImage];
    
    
    ChatTab = [[UITableView alloc]initWithFrame:CGRectMake(25, 10, 250, 90)];
    ChatTab.separatorStyle = UITableViewCellSeparatorStyleNone;//去除边框
    ChatTab.tag = 202;
    ChatTab.dataSource = self;
    ChatTab.delegate = self;
    ChatTab.showsVerticalScrollIndicator = NO;//垂直滚动条
    ChatTab.backgroundColor = [UIColor clearColor];
    [_ChatImage addSubview:ChatTab];
    // NSIndexPath *lastRow = [NSIndexPath indexPathForRow:([_Chatdata count] - 1) inSection:0];
   // [ChatTab scrollToRowAtIndexPath:lastRow atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    [ChatTab setContentOffset:CGPointMake(0, ChatTab.contentSize.height -ChatTab.bounds.size.height) animated:YES];
    
//    _ChatText = [[UITextField alloc] initWithFrame:CGRectMake(50,20,220, 70)];
//    _ChatText.backgroundColor = [UIColor clearColor];
//    _ChatText.placeholder = @"欢迎来到聚聚游戏平台！";
//    _ChatText.textColor = [UIColor blackColor];
//    _ChatText.textAlignment = NSTextAlignmentLeft;
//    _ChatText.userInteractionEnabled = NO;//不可编辑
//    _ChatText.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    _ChatText.delegate = self;
//    [_ChatImage addSubview:_ChatText];
    
    UITapGestureRecognizer * ChatTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ChatTapclick:)];
    ChatTap.numberOfTapsRequired = 2;//单击
    [_ChatImage addGestureRecognizer:ChatTap];
    
//    UILongPressGestureRecognizer *longPressReger = [[UILongPressGestureRecognizer alloc]
//                                                    
//                                                    initWithTarget:self action:@selector(ChatTapclick:)];
//
//    longPressReger.minimumPressDuration = 1.0;
//    
//    [_ChatImage addGestureRecognizer:longPressReger];
//    
    
    
    
    _GamebackImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 160, 320, 118)];
    _GamebackImage.image = [UIImage imageNamed:@"GameBG.PNG"];
    _GamebackImage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_GamebackImage];
    
    _GameTitleImage = [[UIImageView alloc] initWithFrame:CGRectMake(115, 162,90, 18)];
    _GameTitleImage.image = [UIImage imageNamed:@"GameTitle.PNG"];
    _GameTitleImage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_GameTitleImage];
    
    _HomeV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 37.5)];
    _HomeV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_HomeV];
    UIImageView * homeBG = [[UIImageView alloc] initWithFrame:_HomeV.bounds];
    homeBG.backgroundColor = [UIColor clearColor];
    homeBG.image = [UIImage imageNamed:@"homeBG.png"];
    [_HomeV addSubview:homeBG];
    
    imageheadView = [[UIButton alloc] initWithFrame:CGRectMake(10,1, 30, 30)];
    //addimageV = [[EGOImageView alloc] initWithPlaceholderImage: [UIImage imageWithData: [defaults objectForKey:@"NameHead"]]];
    //addimageV.frame = CGRectMake(0, 0, 30,30);
    //addimageV.layer.cornerRadius = 15;
    //[imageView addSubview:addimageV];
    
    //imageView.backgroundColor = [UIColor blackColor];
    //imageView.image = [UIImage imageNamed:@"Radar.png"];
    [imageheadView setBackgroundImage:[UIImage imageWithData: [defaults objectForKey:@"NameHead"]] forState:UIControlStateNormal];
    [imageheadView addTarget:self action:@selector(imageViewbut) forControlEvents:UIControlEventTouchUpInside];
    imageheadView.layer.cornerRadius = 15;
    [imageheadView.layer setBorderWidth:2.0]; //边框宽度
    [imageheadView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    imageheadView.layer.masksToBounds = YES;
    imageheadView.contentMode = UIViewContentModeScaleAspectFill;
    [_HomeV addSubview:imageheadView];

    
    _Roomnumber = [[UITextField alloc] initWithFrame:CGRectMake(118, 5, 75, 25)];
    _Roomnumber.backgroundColor = [UIColor clearColor];
   // _Roomnumber.placeholder = @"房间号";
    
    UIColor *color = [UIColor whiteColor];
    _Roomnumber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"房间号" attributes:@{NSForegroundColorAttributeName: color}];
    
    _Roomnumber.tag = 104;
    _Roomnumber.textColor = [UIColor blackColor];
    _Roomnumber.textAlignment = NSTextAlignmentLeft;
    _Roomnumber.delegate = self;
    _Roomnumber.keyboardType =  UIKeyboardTypeNumberPad;
    [_HomeV addSubview:_Roomnumber];
    
    JiaRoom = [UIButton buttonWithType:UIButtonTypeCustom];
    JiaRoom.frame = CGRectMake(210,5, 45, 25);
//[JiaRoom setBackgroundImage:[UIImage imageNamed:@"ADD1.png"] forState:UIControlStateNormal];
//    [JiaRoom setTitle:@"加入" forState:UIControlStateNormal];
    JiaRoom.titleLabel.font = [UIFont systemFontOfSize:12.0];
    UIImageView * JiaBG = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5, 15, 15)];
    JiaBG.tag = 500;
    JiaBG.backgroundColor = [UIColor clearColor];
    JiaBG.image = [UIImage imageNamed:@"ADD1.png"];
    [JiaRoom addSubview:JiaBG];
    // [_LoginBut setTitle:@"登陆" forState:UIControlStateNormal];
    // [_LoginBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // [_LoginBut setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    //[JiaRoom setBackgroundImage:[UIImage imageNamed:@"ADD.png"] forState:UIControlStateNormal];
    [JiaRoom addTarget:self action:@selector(JiaRoom1) forControlEvents:UIControlEventTouchUpInside];
    [_HomeV addSubview:JiaRoom];
    
    _GameunderwayData = [[NSMutableArray alloc] init];
    _GameListData = [[NSMutableArray alloc] init];
    
    _GameListData = [NSMutableArray arrayWithObjects:@"摇骰子",@"击鼓传花",@"世界杯",@"NO PHONE",@"谁是卧底",@"大冒险",@"猜拳",@"知否",@"杀人游戏", nil];
    
    [self addGameListView];
    [self addGameunderwayView];
    [self addGameunderwayData];
    
    
    _Namelist = [[UIView alloc] initWithFrame:CGRectMake(0,- self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:_Namelist];
    
    NameBG = [[UIImageView alloc] initWithFrame:_Namelist.bounds];
    NameBG.image = [UIImage imageNamed:@"BackBG.PNG"];
    NameBG.alpha = 0.0;
    [_Namelist addSubview:NameBG];
    
    UIImageView * NameLBG = [[UIImageView alloc] initWithFrame:_Namelist.bounds];
    NameLBG.image = [UIImage imageNamed:@"NameLBG.PNG"];
    [_Namelist addSubview:NameLBG];
    NBut = [UIButton buttonWithType:UIButtonTypeCustom];
    NBut.frame  = CGRectMake(143, self.view.bounds.size.height- 25,24, 12);
    //[NBut setTitle:@"房间口令：1233 人数：7" forState:UIControlStateNormal];
    //[NBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [NBut setBackgroundImage:[UIImage imageNamed:@"s.PNG"] forState:UIControlStateNormal];
    [NBut setBackgroundImage:[UIImage imageNamed:@"x.PNG"] forState:UIControlStateHighlighted];
    [NBut addTarget:self action:@selector(Tapclick) forControlEvents:UIControlEventTouchUpInside];
    [_Namelist addSubview:NBut];
    
    UIPanGestureRecognizer *panGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
    [_Namelist addGestureRecognizer:panGesture];
    
    
    UIButton * Open = [[UIButton alloc] initWithFrame:CGRectMake(20,10,25, 25)];
    [Open setBackgroundImage:[UIImage imageNamed:@"Menuend.PNG"] forState:UIControlStateNormal];
    [Open addTarget:self action:@selector(endBut) forControlEvents:UIControlEventTouchUpInside];
    [_Namelist addSubview:Open];

    
    
    
    UIButton * endB = [UIButton buttonWithType:UIButtonTypeCustom];
    endB.frame  = CGRectMake(120 ,self.view.bounds.size.height - 140, 80, 80);
    endB.backgroundColor = [UIColor clearColor];
    endB.layer.cornerRadius = 40;//设置那个圆角的有多圆
    // endB.layer.borderWidth = 2;//设置边框的宽度，当然可以不要
    //endB.layer.borderColor = [[UIColor blackColor] CGColor];//设置边框的颜色
    endB.layer.masksToBounds = YES;//设为NO去试试
    
    [endB setTitle:@"退出" forState:UIControlStateNormal];
    [endB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [endB setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    //[endB setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [endB addTarget:self action:@selector(MenuOpen) forControlEvents:UIControlEventTouchUpInside];
    //[_Namelist addSubview:endB];
    
    //NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    Title1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 120, 30)];
    Title1.text = [NSString stringWithFormat:@"房间号：%@",[defaults objectForKey:@"_Roomnumber"]];
    Title1.textAlignment = NSTextAlignmentCenter;
    Title1.textColor = [UIColor whiteColor];
    Title1.backgroundColor = [UIColor clearColor];
    [_Namelist addSubview:Title1];
    
    UIButton * Refresh = [UIButton buttonWithType:UIButtonTypeCustom];
    Refresh.frame = CGRectMake(265,10, 25, 25);
    Refresh.backgroundColor = [UIColor clearColor];
    [Refresh setImage:[UIImage imageNamed:@"Menuxx.PNG"] forState:UIControlStateNormal];
    //[Refresh setTitle:@"刷新" forState:UIControlStateNormal];
    [Refresh setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Refresh setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    [Refresh addTarget:self action:@selector(Refresh) forControlEvents:UIControlEventTouchUpInside];
    [_Namelist addSubview:Refresh];
    
    
    
    _NametableV = [[UITableView alloc] initWithFrame:CGRectMake(20,50, 280, 360) style:UITableViewStylePlain];
    _NametableV.separatorStyle = UITableViewCellSeparatorStyleNone;//去除边框
    //_tableV.backgroundColor = [UIColor clearColor];//UIColorFromRGB(0xe6e6e6);
    _NametableV.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth;
    _NametableV.tag = 200;
    //_tableV.rowHeight = 40.0;
    _NametableV.dataSource = self;
    _NametableV.delegate = self;
    _NametableV.showsVerticalScrollIndicator = NO;//垂直滚动条
    _NametableV.backgroundColor = [UIColor clearColor];
    [_Namelist addSubview:_NametableV];
    
    _tableVdata = [[NSMutableArray alloc] init];
    
    
    
    //初始化NetWork
    netWork = [[NetWork alloc] init];
    netWork.delegate = self;
    
    activityView = [[ActivityView alloc] initWithFrame:self.view.bounds];
    
    [activityView hidden];
    activityView.delegate = self;
    
    [self.view addSubview:activityView];
    
    
    //Chatdatatime = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(Chatdatatime)userInfo:nil repeats:YES];

}

-(void)Chatdatatime
{
    
    if(_Roomnumber.text.length != 0)
    {
    //聊天数据下载接口
    //[activityView show];
    ident =  RQIdentifierForSendMessage;
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SendMessageURL]];
    [upLoadRequest setPostValue:[defaults objectForKey:@"_Roomnumber"] forKey:@"homenum"];
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];
        
    }
    if(YQTAB)
    {
      [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(YQbut)userInfo:nil repeats:NO];
    }
}

-(void)YQbut
{
    //邀请
    
    if(sxnamelistTab)
    {
        
    
    ident =  RQIdentifierForSendjoin;
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SendjoinURL]];
    [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)addGameunderwayView
{
    _Gameunderway = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 185, 320, 70)];
    _Gameunderway.backgroundColor = [UIColor clearColor];
    _Gameunderway.tag = 1000;
    //_Gameunderway.contentSize = CGSizeMake(320*(([_GameunderwayData count]-1)/4 + 1), 70);
    _Gameunderway.showsHorizontalScrollIndicator = NO;//滚动的时候是否有水平的滚动条，默认是有的
    _Gameunderway.delegate = self;
    
    [self.view addSubview:_Gameunderway];
}

-(void)addGameListView
{
    _GameList = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 263, 320, 305)];
    _GameList.backgroundColor = [UIColor clearColor];
    _GameList.tag = 2000;
    _GameList.contentSize = CGSizeMake(320*(([_GameListData count]-1)/9 + 1), 305);    // 设置内容大小
    _GameList.delegate = self;
    _GameList.pagingEnabled = YES;
    _GameList.showsHorizontalScrollIndicator = NO;//滚动的时候是否有水平的滚动条，默认是有的
    
    [self addGameListData];
    
    [self.view addSubview:_GameList];
    
    _GamepageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height - 15,320,10)];
    _GamepageControl.backgroundColor = [UIColor clearColor];
    _GamepageControl.numberOfPages = (([_GameListData count]-1)/9 + 1);//页数（几个圆圈）
    _GamepageControl.currentPage = 0;
    //[_GamepageControl setImagePageStateNormal:[UIImage imageNamed:@"icon.png"]];
    //[_GamepageControl setImagePageStateHighlighted:[UIImage imageNamed:@"icon.png"]];
    
    [self.view addSubview:_GamepageControl];

}


//滚动视图的代理方法－ scrollview 减速停止
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    switch (scrollView.tag) {
        case 1000:
        {
            
        }
            break;
        case 2000:
        {
            int current = scrollView.contentOffset.x/300;
            NSLog(@"current:%d",current);
            _GamepageControl.currentPage = current;
        }
            break;
        case 3000:
        {
            NSLog(@"scrollView.contentOffset.x = %f",scrollView.contentOffset.x);
//            if(scrollView.contentOffset.x == 640)
//            {
//            [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(addJIEM)userInfo:nil repeats:NO];
//            }
        }break;
            
        default:
            break;
    }
    
    
}

//--------------------------
-(void)addGameListData
{
    //加载数据
    for(int i = 0; i < [_GameListData count];i++)
    {
        GameListCell * GameCell = [[GameListCell alloc] initWithFrame:CGRectMake(10 + i/3*100,i%3*95, 100, 90)];
        [GameCell.GameTubiao addTarget:self action:@selector(GameTab:) forControlEvents:UIControlEventTouchUpInside];
        GameCell.GameTubiao.tag = 2001 +i;
        GameCell.GameTubiaoImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[_GameListData objectAtIndex:i]]];
        
        GameCell.GameName.text = [_GameListData objectAtIndex:i];
        [_GameList addSubview:GameCell];
    }
}

-(void)GameTab:(UIButton * )but
{
    NSLog(@"MYGameTab %d",but.tag);
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];

    
    if(!OPenBUT ||but.tag == 2003)
    {
        NSLog(@"单机游戏");
        if(but.tag == 2003)
        {
            WJionViewController * WjionV = [[WJionViewController alloc]init];
            [self.navigationController pushViewController:WjionV animated:YES];
        }else{
            UIAlertView* a=[[UIAlertView alloc]init];
            
            a=[[UIAlertView alloc] initWithTitle:@"提示" message:@"游戏需要创建房间，请先创建房间!" delegate:nil cancelButtonTitle:nil otherButtonTitles: @"确定",nil];
            
            [a show];
        }
        
    }else{
        
        
        if(but.tag == 2001||but.tag == 2002||but.tag == 2004||but.tag == 2006 || but.tag == 2007)
        {
        NSLog(@"创建游戏");
            [Chatdatatime setFireDate:[NSDate distantFuture]];
            NSString *strurl = [NSString stringWithFormat:SendGameNumURL,nil];
        [netWork requestWithStrURL:strurl withIdentifier:RQIdentifierForSendGameNum];
        [activityView show];
        rqIdentifier = RQIdentifierForSendGameNum;
            
        [defaults setObject:[_GameListData objectAtIndex:(but.tag%10 -1)] forKey:@"_GmaeName"];//游戏名
        [defaults synchronize];//用synchronize方法把数据持久化到standardUserDefaults数据库
        }
        else{
        
        UIAlertView* a=[[UIAlertView alloc]init];
    
        a=[[UIAlertView alloc] initWithTitle:@"提示" message:@"游戏还在开发中，请选择其他游戏!" delegate:nil cancelButtonTitle:@"确定"otherButtonTitles: @"取消",nil];
        
        [a show];
        }
       
    }
    
}
//--------------------------

-(void)addGameunderwayData
{
    NSLog(@"addGameunderwayData");
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    //加载数据
    for(int i = 0; i < [_GameunderwayData count];i++)
    {
        GameunderwayCell * GameCell = [[GameunderwayCell alloc] initWithFrame:CGRectMake(i*80,0, 80, 70)];
        [GameCell.GameTubiao addTarget:self action:@selector(GameunderTab:) forControlEvents:UIControlEventTouchUpInside];
        GameCell.GameTubiao.tag = 1001 +i;
        GameCell.GameTubiaoImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[defaults objectForKey:@"_GmaeName"]]];
        
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] init];
        [longPressGestureRecognizer addTarget:self action:@selector(gestureRecognizerHandle:)];
        [longPressGestureRecognizer setMinimumPressDuration:1.0f];
        [longPressGestureRecognizer setAllowableMovement:50.0];
        [GameCell.GameTubiao addGestureRecognizer:longPressGestureRecognizer];
        
       // if(i == 0)
       // GameCell.GameName.text = [_GameunderwayData objectAtIndex:i];
       // else
            GameCell.GameName.text = [NSString stringWithFormat:@"%@的%@",[[[_GameunderwayData objectAtIndex:i] objectForKey:@"username"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[defaults objectForKey:@"_GmaeName"]];
        GameCell.data = [_GameunderwayData objectAtIndex:i];
        // GameCell.data = [_GameunderwayData objectAtIndex:i];
        //[[[_GameunderwayData objectAtIndex:i] objectForKey:@"username"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [_Gameunderway addSubview:GameCell];
    }
    
    
}

-(void)GameunderTab:(UIButton * )but
{
    NSLog(@"MYGameunderTab %ld",but.tag);
    if(!OPenBUT)
    {
        NSLog(@"热门游戏");
    }else{
    
            NSLog(@"加入游戏");
            [Chatdatatime setFireDate:[NSDate distantFuture]];
        
            [activityView show];
            ident =  RQIdentifierForGameUserinfo;
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            [defaults setObject:[[_GameunderwayData objectAtIndex:(but.tag%100-1)] objectForKey:@"tablenum"] forKey:@"usergamehomenum"];//桌号
             [defaults synchronize];
        
            [defaults setObject:@"0"  forKey:@"userID"];//游戏标示 1创建 0 加入
            upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:GameUserinfoURL]];
            [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
            [upLoadRequest setPostValue:@"0" forKey:@"gameuserid"];
            [upLoadRequest setPostValue:[[_GameunderwayData objectAtIndex:(but.tag%100-1)] objectForKey:@"tablenum"] forKey:@"gamehomenum"];//桌号
            [upLoadRequest setPostValue:[defaults objectForKey:@"_GmaeName"] forKey:@"gamename"];
            [upLoadRequest setPostValue:[defaults objectForKey:@"_Roomnumber"] forKey:@"homenum"];
            [upLoadRequest setPostValue:@"0" forKey:@"isgameover"];
            [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
            upLoadRequest.delegate = self;
            [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
            
            [upLoadRequest startAsynchronous];

        
    }
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

#pragma mark -TextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing");
    
//    
//    if(textField.tag == 101)
//    {
//        textField.frame = CGRectMake(0,self.view.bounds.size.height - 295, 240, 30);
////        for(UIView * BUt in [PopChatV subviews])
////        {
////            if(BUt.tag == 102)
////            {
////                BUt.frame = CGRectMake(250,self.view.bounds.size.height - 295, 60, 30);
////            }else if(BUt.tag == 103)
////                BUt.frame = CGRectMake(0,self.view.bounds.size.height - 300, 320, 40);
////                
////        }
//    }else
        if (textField.tag == 104)
    {
        for(UIImageView * imageV in [JiaRoom subviews])
        {
            if(imageV.tag == 500)
            [imageV removeFromSuperview];
        }
        [JiaRoom setBackgroundImage:[UIImage imageNamed:@"ADD12.PNG"] forState:UIControlStateNormal];
        [JiaRoom setTitle:@"加入" forState:UIControlStateNormal];
        ChatTAB = NO;
        
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //结束时调用的方法
    NSLog(@"结束时调用的方法textField");
//    
//    if(textField.tag == 101)
//    {
//        textField.frame = CGRectMake(0,self.view.bounds.size.height - 35, 240, 30);
////        for(UIView * BUt in [PopChatV subviews])
////        {
////            if(BUt.tag == 102)
////            {
////                BUt.frame = CGRectMake(250,self.view.bounds.size.height - 35, 60, 30);
////            }else if(BUt.tag == 103)
////                BUt.frame = CGRectMake(0,self.view.bounds.size.height - 40, 320, 40);
////            
////        }
//        
//        
//    }

    [textField resignFirstResponder];
    
}

-(BOOL)textField:(UITextField *)field shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"当textField编辑结束时调用的方法");
//    if(field.text.length == 0)
//    {
//        [JiaRoom setBackgroundImage:[UIImage imageNamed:@"ADD1.png"] forState:UIControlStateNormal];
//        [JiaRoom setTitle:nil forState:UIControlStateNormal];
//    }
    
    return YES;
}




//按下Done按钮的调用方法，我们让键盘消失

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}
//----------------------
//------------------

#pragma mark -   activityView.delegate代理方法 加载试图
- (void)CancelTab:(BOOL)tab
{
    NSLog(@"=%@=",tab ? @"放弃加载":@"加载完成");//YES是放弃加载 NO是加载完成
    if(tab) {[netWork checkSimple];[upLoadRequest clearDelegatesAndCancel];}//取消加载
}

//------------------------------

#pragma mark - NetWork代理方法
// 获取房间号
- (void)finishRequestWithSendHome:(NSDictionary *)SendHome
{
    [activityView hidden];
    NSLog(@"SendHome = %@",SendHome);
    
    NSLog(@"获取房间号");
    _Roomnumber.text = [SendHome objectForKey:@"homenum"];
    //        MyAlertView *alert = [[MyAlertView alloc] initWithTitle:@"提示" contentText:[SendHome objectForKey:@"homenum"] leftButtonTitle:nil rightButtonTitle:nil addkAlertHeight:100.0];
    //        [alert show];
    
    
    
    
}

// 获取桌号
- (void)finishRequestWithSendGameNum:(NSDictionary *)SendGameNum
{
    
        [activityView show];
        ident =  RQIdentifierForGameUserinfo;
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        [defaults setObject:@"1"  forKey:@"userID"];//游戏标示 1创建 0 加入
        [defaults setObject:[SendGameNum objectForKey:@"gameresult"] forKey:@"usergamehomenum"];//桌号
       // [defaults setObject:[SendGameNum objectForKey:@"id"] forKey:@"FuserID"];
        [defaults synchronize];
    
        upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:GameUserinfoURL]];
        [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
        [upLoadRequest setPostValue:@"1" forKey:@"gameuserid"];
        [upLoadRequest setPostValue:[SendGameNum objectForKey:@"gameresult"] forKey:@"gamehomenum"];//桌号
         [upLoadRequest setPostValue:[defaults objectForKey:@"_GmaeName"] forKey:@"gamename"];
        [upLoadRequest setPostValue:[defaults objectForKey:@"_Roomnumber"] forKey:@"homenum"];
        [upLoadRequest setPostValue:@"0" forKey:@"isgameover"];
        [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
        upLoadRequest.delegate = self;
        [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];

        [upLoadRequest startAsynchronous];
}



- (void)requestFailed:(NSError *)error
{
    [activityView hidden];
    
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    //NSLog(@"网 ＝ %d",[reach currentReachabilityStatus]);
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
        {
            
            NSLog(@"notReachable");
            MyAlertView *alert = [[MyAlertView alloc] initWithTitle:@"提示" contentText:@"当前网络不可用，请检查网络连接！" leftButtonTitle:nil rightButtonTitle:nil addkAlertHeight:100.0];
            [alert show];
        }
            break;
    }
    
    //请求失败
    NSLog(@"error = %@",[error localizedFailureReason]);
    
    
}

//------------------------------


//-------------上传信息-------------

#pragma mark - ASIHttpDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    //反馈数据
    [activityView hidden];
    
    NSString *str = [request responseString];
    switch (ident) {
        case RQIdentifierForCreatehome:
        {
            
            NSLog(@"返回房间是否存在  = %@",str);
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            if(1 == [[dictionary objectForKey:@"cerateresult"]intValue])
            {
                [_HomeV removeFromSuperview];
                _Namelist.frame = CGRectMake(0, 35 - self.view.bounds.size.height, 320, self.view.bounds.size.height);
                NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                [defaults setObject:_Roomnumber.text forKey:@"_Roomnumber"];//房间号
                //[defaults setObject:namestr forKey:@"Game_Name"];
                [defaults synchronize];//用synchronize方法把数据持久化到standardUserDefaults数据库
                
                Chatdatatime = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(Chatdatatime)userInfo:nil repeats:YES];
                OPenBUT = YES;
            }
        }
            break;
        case RQIdentifierForExithome:
        {
            NSLog(@"退出房间  = %@",str);
            //NSDictionary * dictionary = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            _Roomnumber.text = nil;
            [self.view addSubview:_HomeV];
            [JiaRoom setBackgroundImage:nil forState:UIControlStateNormal];
            [JiaRoom setTitle:nil forState:UIControlStateNormal];
            UIImageView * JiaBG = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5, 15, 15)];
            JiaBG.tag = 500;
            JiaBG.backgroundColor = [UIColor clearColor];
            JiaBG.image = [UIImage imageNamed:@"ADD1.png"];
            [JiaRoom addSubview:JiaBG];
            
            OPenBUT = NO;
            //[self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: ([self.navigationController.viewControllers count]-1)] animated:YES];
            //[self.navigationController popViewControllerAnimated:YES];
        }break;
        case RQIdentifierForSendUserinfo:
        {
            NSLog(@"房间里的用户list  = %@",str);
            NSArray * array = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            [_tableVdata removeAllObjects];
            for(NSDictionary * dict in array)
            {
                [_tableVdata addObject:dict];
            }
            [_NametableV reloadData];
            NSLog(@"array = %@",array);
            
        }break;
            
        case RQIdentifierForGameinfolist:
        {
            NSLog(@"游戏list  = %@",str);
             NSArray * array = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        
            //[_Gameunderway removeFromSuperview];
            for(GameunderwayCell * MCell in [_Gameunderway subviews])
            {
                [MCell removeFromSuperview];
            }
            
            [_GameunderwayData removeAllObjects];
            // NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            //[_GameunderwayData addObject:[NSString stringWithFormat:@"创建%@",[defaults objectForKey:@"_GmaeName"]]];
            for(NSDictionary *dict in array)
            {
                [_GameunderwayData addObject:dict];
            }
            
            //_GameunderwayData = [NSMutableArray arrayWithObjects:@"Radar",@"摇骰子",@"击鼓传花",@"世界杯",@"NO PHONE",@"谁是卧底",@"大冒险",@"猜拳", nil];
            //[self addGameunderwayView];
            _Gameunderway.contentSize = CGSizeMake(320*(([_GameunderwayData count]-1)/4 + 1), 70);
            [self addGameunderwayData];
            [Chatdatatime setFireDate:[NSDate date]];//继续;
            
            //[Chatdatatime setFireDate:[NSDate date]];//继续;
            

        }break;
        case RQIdentifierForGameUserinfo:
        {
            NSLog(@"创建游戏，加入游戏= %@ ",str);
            
            
            //[Chatdatatime setFireDate:[NSDate distantFuture]];
            [activityView show];
            ident =  RQIdentifierForGameinfolist;
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            
            upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:GameinfolistURL]];
            [upLoadRequest setPostValue:[defaults objectForKey:@"_GmaeName"] forKey:@"gamename"];
            [upLoadRequest setPostValue:[defaults objectForKey:@"_Roomnumber"] forKey:@"homenum"];
            [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
            upLoadRequest.delegate = self;
            [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
            
            [upLoadRequest startAsynchronous];
            
            NSLog(@"_GmaeName = %@",[defaults objectForKey:@"_GmaeName"]);
            if([[defaults objectForKey:@"userID"] intValue] == 1)
            {
                if([[defaults objectForKey:@"_GmaeName"] isEqualToString:@"击鼓传花"])
                {
                    ForganigerViewController * forganigerV = [[ForganigerViewController alloc] init];
                    [self.navigationController pushViewController:forganigerV animated:YES];
                }else
                if([[defaults objectForKey:@"_GmaeName"] isEqualToString:@"摇骰子"])
                {
                    OrganigerViewController * OrganigerV = [[OrganigerViewController alloc] init];
                    [self.navigationController pushViewController:OrganigerV animated:YES];
                }else
                if([[defaults objectForKey:@"_GmaeName"] isEqualToString:@"NO PHONE"])
                {
                    NOrganigerViewController * nophoneV =[[NOrganigerViewController alloc] init];
                    [self.navigationController pushViewController:nophoneV animated:YES];
                }else
                 if([[defaults objectForKey:@"_GmaeName"] isEqualToString:@"大冒险"])
                 {
                     AdventViewController * AdventureV = [[AdventViewController alloc] init];
                     [self.navigationController pushViewController:AdventureV animated:YES];
                 }else
                if([[defaults objectForKey:@"_GmaeName"] isEqualToString:@"猜拳"])
                {
                    GorganigerViewController * GorganigerV = [[GorganigerViewController alloc] init];
                    [self.navigationController pushViewController:GorganigerV animated:YES];
                }
                
            }else{
                if([[defaults objectForKey:@"_GmaeName"] isEqualToString:@"击鼓传花"])
                {
                    FJionViewController * FJionV = [[FJionViewController alloc] init];
                    [self.navigationController pushViewController:FJionV animated:YES];
                }else
                if([[defaults objectForKey:@"_GmaeName"] isEqualToString:@"摇骰子"])
                {
                    ParticipantViewController * ParticipantV = [[ParticipantViewController alloc] init];
                    [self.navigationController pushViewController:ParticipantV animated:YES];
                }else
                if([[defaults objectForKey:@"_GmaeName"] isEqualToString:@"NO PHONE"])
                {
                    NOrganigerViewController * nophoneV =[[NOrganigerViewController alloc] init];
                    [self.navigationController pushViewController:nophoneV animated:YES];
                }else
                if([[defaults objectForKey:@"_GmaeName"] isEqualToString:@"大冒险"])
                {
                    AdventViewController * AdventureV = [[AdventViewController alloc] init];
                    [self.navigationController pushViewController:AdventureV animated:YES];
                }else
                if([[defaults objectForKey:@"_GmaeName"] isEqualToString:@"猜拳"])
                {
                    GJionViewController * GJionV= [[GJionViewController alloc] init];
                    [self.navigationController pushViewController:GJionV animated:YES];
                }
                
            }
        
        }break;
        case RQIdentifierForSendMessage:
        {
             NSLog(@"接收聊天数据  = %@",str);
            NSArray * array = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            [_Chatdata removeAllObjects];
            //NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            //NSString  * Gmae_NAme = [defaults objectForKey:@"Game_Name"];
            for(NSDictionary *dict in array)
            {
                NSString * message = [dict objectForKey:@"message"];
                NSString * Name = [dict objectForKey:@"username"];
                [_Chatdata addObject:[NSString stringWithFormat:@"%@%@",[Name stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding],message]];
            }
            [ChatV reloadData];
            [ChatTab reloadData];
            
//            for(NSDictionary *dict in array)
//            {
//                 if(MessageID < [[dict objectForKey:@"id"] intValue])
//                 {
//                     NSString * message = [dict objectForKey:@"message"];
//                     //NSString * Name = [dict objectForKey:@"gamename"];
//                     _ChatText.text = [NSString stringWithFormat:@"XXX说：%@",message];
//                     MessageID = [[dict objectForKey:@"id"] intValue];
//                     NSLog(@"_ChatText.text = %@",_ChatText.text);
//                     break;
//                 }
//                     
//            }
           
            
            
        }break;
        case RQIdentifierForGetMessage:
        {
            NSLog(@"上传聊天数据结果  = %@",str);
            
            [activityView show];
            ident =  RQIdentifierForSendMessage;
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SendMessageURL]];
            [upLoadRequest setPostValue:[defaults objectForKey:@"_Roomnumber"] forKey:@"homenum"];
            [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
            upLoadRequest.delegate = self;
            [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
            
            [upLoadRequest startAsynchronous];
            
        }break;
        case RQIdentifierForExitgamehome:
        {
            NSLog(@"删除游戏 = %@",str);
        }break;
        case RQIdentifierForSendjoin:
        {
            //邀请
             NSLog(@"邀请游戏 = %@",str);
            if(str.length > 10)
            {
            YQTAB = NO;
            NSDictionary * dictionary = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
                
            NSString * str = [NSString stringWithFormat:@"%@邀请您加入%@",[[dictionary objectForKey:@"username"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[dictionary objectForKey:@"gamename"]];
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"同意" otherButtonTitles:@"拒绝", nil];
            alertView.tag = 309;
            [alertView show];
                
                NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                [defaults setObject:[dictionary  objectForKey:@"gamehomenum"] forKey:@"usergamehomenum"];//桌号
                [defaults setObject:[dictionary  objectForKey:@"gamename"] forKey:@"_GmaeName"];//桌号
             
                [defaults synchronize];

                

            }
        }break;
        case RQIdentifierForExitjoin:
        {
            //邀请拒绝
        }break;
        case RQIdentifierForChangeimg:
        {
            [imageheadView setBackgroundImage:addimageV.image forState:UIControlStateNormal];
            
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            [defaults setObject:UIImagePNGRepresentation(addimageV.image) forKey:@"NameHead"];
            //[defaults synchronize];//用synchronize方法把数据持久化到standardUserDefaults数据库
            //改头像
        }
        default:
            break;
    }
  
    
    
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

//--------------------------
//---------------------------------------------
#pragma mark - View lifecycle

//自动调用后
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 200)
    return 60.0f;
   if(tableView.tag == 201)
   {
       if([[_Chatdata objectAtIndex:indexPath.row] length]>=15)
           return 60.0f;
       else return 40.0f;
   }
    if(tableView.tag == 202)
        return 30.0f;
    
    return 0.0;
}


//返回每个section的元数个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == 200)
        return [_tableVdata count];
    
    if(tableView.tag == 201 || tableView.tag == 202)
        return [_Chatdata count];
    return 0;
}


//开辟存储数据的空间
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 200)
    {
    static NSString *CellIdentifier = @"Cell";
    ListCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[ListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //CelltableV = [[[UITableView alloc] init]autorelease];
        
    }
    ListModel * model = [[ListModel alloc] init];
    model.Name = [NSString stringWithFormat:@"%@",[[[_tableVdata objectAtIndex:indexPath.row] objectForKey:@"username"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    model.NameHead = [NSString stringWithFormat:@"%@",[[_tableVdata objectAtIndex:indexPath.row] objectForKey:@"imgpath"]];
    [cell setData:model];
    cell.backgroundColor = [UIColor clearColor];
    //cell.NameLabel.text = @"ads";
    cell.userInteractionEnabled = NO;
    
    return cell;
    }else if(tableView.tag == 201)
    {
        static NSString *CellIdentifier =@"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = [_Chatdata objectAtIndex:indexPath.row];//没UTF8
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        //cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.numberOfLines = 2;
        cell.backgroundColor = [UIColor clearColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//没有点击效果(可以点击)
        
        return cell;
        
    }else if(tableView.tag == 202)
    {
        static NSString *CellIdentifier =@"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = [_Chatdata objectAtIndex:[_Chatdata count]-indexPath.row-1];//没UTF8
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//没有点击效果(可以点击)
        
        return cell;
        
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"dan ji");
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

//-----------
-(void)gestureRecognizerHandle:(UILongPressGestureRecognizer *)longPress
{
    if(TAA)
    {
        TAA = NO;
     UIButton *btn = (UIButton*)longPress.view;NSLog(@"%ld",btn.tag);
    buttontag =btn.tag;
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择游戏删除还是返回！" delegate:self cancelButtonTitle:@"删除" otherButtonTitles:@"返回", nil];
    [alertView show];
    }
    
    
   
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(alertView.tag == 309)
    {
        if(buttonIndex == 0)
        {
            
            [activityView show];
            ident =  RQIdentifierForGameUserinfo;
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
           
            
            [defaults setObject:@"0"  forKey:@"userID"];//游戏标示 1创建 0 加入
            upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:GameUserinfoURL]];
            [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
            [upLoadRequest setPostValue:@"0" forKey:@"gameuserid"];
            [upLoadRequest setPostValue:[defaults objectForKey:@"usergamehomenum"] forKey:@"gamehomenum"];//桌号
            [upLoadRequest setPostValue:[defaults objectForKey:@"_GmaeName"] forKey:@"gamename"];
            [upLoadRequest setPostValue:[defaults objectForKey:@"_Roomnumber"] forKey:@"homenum"];
            [upLoadRequest setPostValue:@"0" forKey:@"isgameover"];
            [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
            upLoadRequest.delegate = self;
            [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
            
            [upLoadRequest startAsynchronous];
            
            //同意
        }else{
            //不同意
            YQTAB = YES;
            
            
            [activityView show];
            ident =  RQIdentifierForExitjoin;
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:ExitjoinURL]];
            [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
            [upLoadRequest setPostValue:[defaults objectForKey:@"usergamehomenum"] forKey:@"gamehomenum"];//桌号
            [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
            upLoadRequest.delegate = self;
            [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
            
            [upLoadRequest startAsynchronous];
        }
        
    }else
    {
    if(buttonIndex == 0)
    {
        
            
            ident =  RQIdentifierForExitgamehome;
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:ExitgamehomeURL]];
            [upLoadRequest setPostValue:[defaults objectForKey:@"_userID "] forKey:@"id"];
            [upLoadRequest setPostValue:[[_GameunderwayData objectAtIndex:(buttontag-1)%100] objectForKey:@"tablenum"]  forKey:@"gamehomenum"];
            [upLoadRequest setPostValue:[[_GameunderwayData objectAtIndex:(buttontag-1)%100] objectForKey:@"username"]? @"1":@"0" forKey:@"gameuserid"];
            
            [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
            upLoadRequest.delegate = self;
            [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
            
            [upLoadRequest startAsynchronous];
            
            for(GameunderwayCell * MCell in [_Gameunderway subviews])
            {
                [MCell removeFromSuperview];
            }
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for(int i = 0; i< [_GameunderwayData count]; i++)
            {
                if((buttontag-1)%100 != i )
                {
                    [array addObject:[_GameunderwayData objectAtIndex:i]];
                }
            }
            [_GameunderwayData removeAllObjects];
            for(NSDictionary * dict in array)
            {
                [_GameunderwayData addObject:dict];
            }
            
            [self addGameunderwayData];

    }
    
    TAA = YES;
    }
    
}


-(void)imageViewbut
{//改变照片
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    ADDimageV = [[UIView alloc] initWithFrame:self.view.bounds];
    ADDimageV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    //ADDimageV.alpha = 0.8;
    [self.view addSubview:ADDimageV];
    
    UITapGestureRecognizer * ChatTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ADDimageVlick:)];
    ChatTap.numberOfTapsRequired = 1;//单击
    [ADDimageV addGestureRecognizer:ChatTap];
    
    UIImageView * AddimageVBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AddimageVBG.PNG"]];
    AddimageVBG.center = ADDimageV.center;
    AddimageVBG.bounds = CGRectMake(0, 0, 250, 135);
    AddimageVBG.userInteractionEnabled = YES;
    [ADDimageV addSubview:AddimageVBG];
    
    
    UIButton * imageView = [[UIButton alloc] initWithFrame:CGRectMake(85,5, 80, 80)];
    addimageV = [[EGOImageView alloc] initWithPlaceholderImage: [UIImage imageWithData: [defaults objectForKey:@"NameHead"]]];
    addimageV.frame = CGRectMake(0, 0,80,80);
    addimageV.layer.cornerRadius = 40;
    [imageView addSubview:addimageV];
    
    //imageView.backgroundColor = [UIColor blackColor];
    //imageView.image = [UIImage imageNamed:@"Radar.png"];
    //[imageView setBackgroundImage:[UIImage imageWithData: [defaults objectForKey:@"NameHead"]] forState:UIControlStateNormal];
    [imageView addTarget:self action:@selector(imageViewbut1) forControlEvents:UIControlEventTouchUpInside];
    imageView.layer.cornerRadius = 40;
    [imageView.layer setBorderWidth:1.0]; //边框宽度
    [imageView.layer setBorderColor:[[UIColor grayColor] CGColor]];
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [AddimageVBG addSubview:imageView];
    
    UIButton * EnsureB = [[UIButton alloc] initWithFrame:CGRectMake(85, 100, 80, 30)];
    [EnsureB setTitle:@"退出登录" forState:UIControlStateNormal];
    [EnsureB addTarget:self action:@selector(MenuOpen) forControlEvents:UIControlEventTouchUpInside];
    [AddimageVBG addSubview:EnsureB];
    
    //Ensureb
    
    
    
//    
//    NSLog(@"改变图片");
//    UIActionSheet *chooseImageSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
//    [chooseImageSheet showInView:self.view];
    
}
-(void)imageViewbut1
{
    NSLog(@"改变图片");
    UIActionSheet *chooseImageSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"返回" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    [chooseImageSheet showInView:self.view];
}
-(void)Ensureb
{
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    ident =  RQIdentifierForChangeimg;
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:ChangeimgURL]];
    
     [upLoadRequest addData:UIImageJPEGRepresentation(addimageV.image, 0.5) withFileName:@"temp.jpg" andContentType:@"image/jpeg" forKey:[defaults objectForKey:@"_userID"]];
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];
    
    //[ADDimageV removeFromSuperview];
    
}


//-------------------------------------

#pragma mark UIActionSheetDelegate Method
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    switch (buttonIndex) {
        case 0://Take picture
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
            }else{
                NSLog(@"模拟器无法打开相机");
            }
            // [self presentModalViewController:picker animated:YES];
            [self presentViewController:picker animated:YES completion:nil];
            break;
            
        case 1://From album
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //[self presentModalViewController:picker animated:YES];
            [self presentViewController:picker animated:YES completion:nil];
            break;
            
        default:
            
            break;
    }
    
}

#pragma 拍照选择照片协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    //路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSData *data;
    
    if ([mediaType isEqualToString:@"public.image"]){
        
        //切忌不可直接使用originImage，因为这是没有经过格式化的图片数据，可能会导致选择的图片颠倒或是失真等现象的发生，从UIImagePickerControllerOriginalImage中的Origin可以看出，很原始，哈哈
        UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        NSString *imageFile = [documentsDirectory stringByAppendingPathComponent:@"temp.jpg"];
        NSLog(@"%@",imageFile);
        
        [[PublicDictionary shareDictionary] setValue:imageFile forKey:@"imagePath"];//保存图片
        
        success = [fileManager fileExistsAtPath:imageFile];
        if(success) {
            success = [fileManager removeItemAtPath:imageFile error:&error];
        }
        
        // 将图片保存到本地
        [UIImageJPEGRepresentation(originImage, 1.0f) writeToFile:imageFile atomically:YES];
        
        // 将图片保存到相册
        //UIImageWriteToSavedPhotosAlbum([UIImage imageWithContentsOfFile:imageFile], nil, nil, nil);
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            UIImageWriteToSavedPhotosAlbum(originImage, nil, nil, nil);
        }
        
        
        //图片压缩，因为原图都是很大的，不必要传原图
        UIImage *scaleImage = [self scaleImage:originImage toScale:0.3];
        
        //以下这两步都是比较耗时的操作，最好开一个HUD提示用户，这样体验会好些，不至于阻塞界面
        if (UIImagePNGRepresentation(scaleImage) == nil) {
            //将图片转换为JPG格式的二进制数据
            NSLog(@"将图片转换为JPG格式的二进制数据");
            data = UIImageJPEGRepresentation(scaleImage, 1);
        } else {
            //将图片转换为PNG格式的二进制数据
            NSLog(@"将图片转换为PNG格式的二进制数据");
            data = UIImagePNGRepresentation(scaleImage);
        }
        
        
        
        
        //将二进制数据生成UIImage
        UIImage *image = [UIImage imageWithData:data];
        
        //将图片传递给截取界面进行截取并设置回调方法（协议）
        CaptureViewController *captureView = [[CaptureViewController alloc] init];
        captureView.delegate = self;
        captureView.image = image;
        //隐藏UIImagePickerController本身的导航栏
        picker.navigationBar.hidden = YES;
        [picker pushViewController:captureView animated:YES];
        
    }
}


#pragma mark - 图片回传协议方法
-(void)passImage:(UIImage *)image
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    addimageV.image = image;
    [self Ensureb];
    
    // NSLog(@"y = %f,h = %f",backV.bounds.origin.y,backV.bounds.size.height);
    
}

#pragma mark- 缩放图片
-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}




@end
