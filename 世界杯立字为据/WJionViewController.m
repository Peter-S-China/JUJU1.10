//
//  WJionViewController.m
//  JUJU
//
//  Created by linchuanbin on 14-5-13.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "WJionViewController.h"
#import "WCell.h"
#import "WModle.h"
#import "WCellViewController.h"

@interface WJionViewController ()

@end

@implementation WJionViewController

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
    
    //初始化NetWork
    netWork = [[NetWork alloc] init];
    netWork.delegate = self;
    

    _WorldTU = [[NSMutableArray alloc] init];
    
    ModleDict = [[NSMutableDictionary alloc] init];
    
    [self addjiazai];
    
    
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"M月dd日"];
//    
//    
//    NSString *nowtimeStr = [formatter stringFromDate:[NSDate date]];
//    NSLog(@"%@",nowtimeStr);
    
    
    
    // Do any additional setup after loading the view.
}

-(void)ENDbut
{
    //退出
    [_WorldCupBG removeFromSuperview];
    
    [headlineBUt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [endBUt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [openBUt1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self openBut];
}

-(void)headlineBut
{
    NSLog(@"比赛赛程");
    [headlineBUt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [endBUt1 setTitleColor:UIColorFromRGB(0x575757) forState:UIControlStateNormal];
    [openBUt1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    _WorldCupBG = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _WorldCupBG.image = [UIImage imageNamed:@"WBG.png"];
    _WorldCupBG.userInteractionEnabled = YES;
    _WorldCupBG.alpha = 0.8;
    [self.view addSubview:_WorldCupBG];
    
    UIButton * ENDbut = [UIButton buttonWithType:UIButtonTypeCustom];
    ENDbut.backgroundColor = [UIColor clearColor];
    [ENDbut setImage:[UIImage imageNamed:@"btn_close_selected.png"] forState:UIControlStateNormal];
    [ENDbut setImage:[UIImage imageNamed:@"btn_close_normal.png"] forState:UIControlStateHighlighted];
    ENDbut.frame = CGRectMake(275, 5, 40, 40);
    [ENDbut addTarget:self action:@selector(ENDbut) forControlEvents:UIControlEventTouchUpInside];
    
    [_WorldCupBG addSubview:ENDbut];
    
    
    UIScrollView *scrollView   =[[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 60.0,self.view.frame.size.width, self.view.bounds.size.height - 70)];
    scrollView.contentSize =  CGSizeMake(0, [_WorldCupDATA count]*20 + 20);
    
    [_WorldCupBG addSubview:scrollView];
    
    for(int JJ = 0; JJ < [_WorldCupDATA count]; JJ++)
    {
        NSDictionary * dict = [_WorldCupDATA objectAtIndex:JJ];
        NSLog(@"dict = %@",dict);
        UIView * cellV = [[UIView alloc] initWithFrame:CGRectMake(0, 10 + JJ*20 , 320, 20)];
        if(JJ == 0){
            UIImageView * XV1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
            XV1.backgroundColor = [UIColor grayColor];
            [cellV addSubview:XV1];
        }
            
        UIImageView * XV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 19, 320, 1)];
        XV.backgroundColor = [UIColor grayColor];
        [cellV addSubview:XV];
        
        if(NO) {
            UIImageView * bg = [[UIImageView alloc] initWithFrame:cellV.bounds];
            bg.image = [UIImage imageNamed:@"WlistBG.PNG"];
            [cellV addSubview:bg];
        }
        
        for(int n = 0 ; n < 4; n++)
        {
            [cellV addSubview:[self ViewaddDict:dict addTAB:NO addshu:n]];
        }
        
        
        [scrollView addSubview:cellV];
    }

    
}

-(void)endBut
{
    //还没开始的比赛 已结束
    [headlineBUt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [endBUt1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [openBUt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    ident =  RQIdentifierForSendisbeginschedle;
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SendisbeginschedleURL]];
    [upLoadRequest setPostValue:@"0" forKey:@"isbegin"];
    
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];
}


-(void)openBut
{
    //结束的比赛 未结束
    
    [headlineBUt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [endBUt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [openBUt1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    ident =  RQIdentifierForSendisbeginschedle;
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SendisbeginschedleURL]];
   [upLoadRequest setPostValue:@"1" forKey:@"isbegin"];
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];
    
}

-(void)addjiazai
{
    UIView * headlineV = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, 26)];
    UIImageView * headlineBG = [[UIImageView alloc] initWithFrame:headlineV.bounds];
    headlineBG.image = [UIImage imageNamed:@"WorldCupzhu.PNG"];
    headlineBG.userInteractionEnabled = YES;
    headlineBG.backgroundColor = [UIColor clearColor];
    
    headlineBUt = [UIButton buttonWithType:UIButtonTypeCustom];
    headlineBUt.backgroundColor = [UIColor clearColor];
    //[headlineBUt setImage:[UIImage imageNamed:@"WorldCupzhu.PNG"] forState:UIControlStateNormal];
    [headlineBUt setTitle:@"比赛赛程" forState:UIControlStateNormal];
    //[headlineBUt setTitleColor:UIColorFromRGB(0x646464) forState:UIControlStateHighlighted];
    [headlineBUt setTitleColor:UIColorFromRGB(0x3c3c3c) forState:UIControlStateNormal];
    headlineBUt.titleLabel.font = [UIFont systemFontOfSize:14.0];
    headlineBUt.frame = CGRectMake(220,0, 100, 26);
    [headlineBUt addTarget:self action:@selector(headlineBut) forControlEvents:UIControlEventTouchUpInside];
    [headlineBG addSubview:headlineBUt];
    
    
    endBUt1 = [UIButton buttonWithType:UIButtonTypeCustom];
    endBUt1.backgroundColor = [UIColor clearColor];
    //[headlineBUt setImage:[UIImage imageNamed:@"WorldCupzhu.PNG"] forState:UIControlStateNormal];
    [endBUt1 setTitle:@"未结束" forState:UIControlStateNormal];
    [endBUt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [endBUt1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    endBUt1.titleLabel.font = [UIFont systemFontOfSize:14.0];
    endBUt1.frame = CGRectMake(0,0, 100, 26);
    [endBUt1 addTarget:self action:@selector(openBut) forControlEvents:UIControlEventTouchUpInside];
    [headlineBG addSubview:endBUt1];
    
    openBUt1 = [UIButton buttonWithType:UIButtonTypeCustom];
    openBUt1.backgroundColor = [UIColor clearColor];
    //[headlineBUt setImage:[UIImage imageNamed:@"WorldCupzhu.PNG"] forState:UIControlStateNormal];
    [openBUt1 setTitle:@"已结束" forState:UIControlStateNormal];
    [openBUt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [openBUt1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    openBUt1.titleLabel.font = [UIFont systemFontOfSize:14.0];
    openBUt1.frame = CGRectMake(110,0, 100, 26);
    [openBUt1 addTarget:self action:@selector(endBut) forControlEvents:UIControlEventTouchUpInside];
    [headlineBG addSubview:openBUt1];
    
    
    UILabel * headlinetext = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 26)];
    headlinetext.text = @"比赛赛程";
    headlinetext.backgroundColor = [UIColor clearColor];
    headlinetext.textAlignment = NSTextAlignmentCenter;
    headlinetext.textColor = [UIColor whiteColor];
    headlinetext.font = [UIFont systemFontOfSize:18.0];
    //[headlineBUt addSubview:headlinetext];
    
    [headlineV addSubview:headlineBG];
    //[headlineV addSubview:headlineBUt];
    [self.view addSubview:headlineV];
    
    
    
    
    activityView = [[ActivityView alloc] initWithFrame:self.view.bounds];
    
    [activityView hidden];
    activityView.delegate = self;
    
    [self.view addSubview:activityView];
    
     
    [netWork requestWithStrURL:SendschedleURL withIdentifier:RQIdentifierForSendschedle];
    [activityView show];
    rqIdentifier = RQIdentifierForSendschedle;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ViewaddDict:(NSArray *)Myarray addTAB:(BOOL)tab
{
    NSLog(@"shu = %d",(int)[Myarray count]);
    
    tableV = [[UIView alloc] initWithFrame:CGRectMake(0, 70, 320, self.view.bounds.size.height-70)];
    tableV.backgroundColor = [UIColor blackColor];
    [self.view addSubview:tableV];
    
    _WorldCuplist = [[UITableView alloc] initWithFrame:tableV.bounds];
    _WorldCuplist.backgroundColor = [UIColor blackColor];
    _WorldCuplist.delegate = self;
    _WorldCuplist.dataSource = self;
    _WorldCuplist.separatorStyle = UITableViewCellSeparatorStyleNone;//去除边框
    [tableV addSubview:_WorldCuplist];
   
}

-(UIView *)ViewaddDict:(NSDictionary *)Mydict addTAB:(BOOL)tab addshu:(int)section
{
    CGRect  Myfrme = CGRectMake(0, 0, 55, 20);
    NSString * str;
    switch (section) {
        case 0:{Myfrme = CGRectMake(0, 0, 70, 20); str = [[Mydict objectForKey:@"competitiondate"] substringWithRange:NSMakeRange(0, 5)];}break;
        case 1:{Myfrme = CGRectMake(70, 0, 50, 20); str = [Mydict objectForKey:@"competitiontime"];}break;
        case 2:{
            Myfrme = CGRectMake(120, 0,150, 20);
            NSLog(@"长度%d ＝",[[Mydict objectForKey:@"hometeam"] length]);
            if([[Mydict objectForKey:@"hometeam"] length] != 0)
            {
            str = [NSString stringWithFormat:@"%@ VS %@",[Mydict objectForKey:@"hometeam"],[Mydict objectForKey:@"visitingteam"]];
            }else
            str =nil;
        
        }break;
        case 3:{Myfrme = CGRectMake(270, 0, 50, 20); str = [Mydict objectForKey:@"events"];}break;
        default:
            break;
    }

    UILabel * timelable = [[UILabel alloc] initWithFrame:Myfrme];
    timelable.textColor = [UIColor whiteColor];
    timelable.textAlignment = NSTextAlignmentCenter;
    timelable.backgroundColor = [UIColor clearColor];
    timelable.font = [UIFont systemFontOfSize:12.0];
    timelable.text = str;
    if(section == 0)
    {
        UIImageView * xx = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1, 19)];
        xx.backgroundColor = [UIColor grayColor];
        [timelable addSubview:xx];

    }
    
        UIImageView * x = [[UIImageView alloc] initWithFrame:CGRectMake(timelable.bounds.size.width-1, 0, 1, 19)];
        x.backgroundColor = [UIColor grayColor];
        [timelable addSubview:x];
    
    return timelable;
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

#pragma mark - NetWork代理方法


- (void)finishRequestWithSendteamlogo:(NSArray *)Sendteamlogo
{
    NSLog(@"Sendteamlogo = %@",Sendteamlogo);
    [_WorldTU removeAllObjects];
    for(NSDictionary *dict in Sendteamlogo)
    {
        [_WorldTU addObject:dict];
    }
    [_WorldCuplist reloadData];
    [self openBut];
}

- (void)finishRequestWithSendschedle:(NSArray *)Sendschedle
{
    [activityView hidden];
    NSLog(@"世界杯数据Sendschedle = %@",Sendschedle);
   
    _WorldCupdata = [NSMutableArray arrayWithArray:Sendschedle];
    _WorldCupDATA = [NSMutableArray arrayWithArray:Sendschedle];
    
    [self ViewaddDict:Sendschedle addTAB:NO];
    
    [netWork requestWithStrURL:SendteamlogoURL withIdentifier:RQIdentifierForSendteamlogo];
    rqIdentifier = RQIdentifierForSendteamlogo;

}

- (void)requestFailed:(NSError *)error
{
    [activityView hidden];
    //请求失败
    NSLog(@"error = %@",[error localizedFailureReason]);
    
    
}


//------------------

#pragma mark -   activityView.delegate代理方法 加载试图
- (void)CancelTab:(BOOL)tab
{
    NSLog(@"=%@=",tab ? @"YES":@"NO");//YES是放弃加载 NO是加载完成
    if(tab) [netWork checkSimple];//[upLoadRequest clearDelegatesAndCancel];
    //[upLoadRequest cancel];//[netWork checkSimple];//取消加载
}

//------------------------------


#pragma mark - TableViewdelegate&&TableViewdataSource
#pragma mark - 数据源方法

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView;
//{
//    NSLog(@"tableView滚动9纵坐标%f",scrollView.contentOffset.y);
//    if(scrollView.contentOffset.y < -100)
//    {
//        tableV.frame = CGRectMake(0, 400, 320, self.view.bounds.size.height - 400);
//    }else if(scrollView.contentOffset.y > 0){
//        if((400 - scrollView.contentOffset.y) >= 44)
//        {
//        tableV.frame = CGRectMake(0, 400 - scrollView.contentOffset.y, 320, self.view.bounds.size.height - 400 + scrollView.contentOffset.y);
//        }
//    }
//}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    //这个方法返回 tableview 有多少个section
   
    int section1 = 0;
    for(int secti = 0 ;secti < [_WorldCupdata count]; secti++)
    {
        if([[_WorldCupdata objectAtIndex:secti] objectForKey:@"competitiondate"] != nil)section1++;
    }
    
    return section1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //这个方法返回   对应的section有多少个元素，也就是多少行
    int row[2];
    int NN = 0;
    //int tt = 0;
    for(int secti = 0 ;secti < [_WorldCupdata count]; secti++)
    {
        if([[_WorldCupdata objectAtIndex:secti] objectForKey:@"competitiondate"] != nil)
        {
            row[NN%2] = secti;
            NSLog(@"secti = %d",secti);
            if(section+1 == NN){ WorldData[section] = abs(row[0]-row[1]);return abs(row[0]-row[1]);}
            //if(row[0]>row[1])return row[0]-row[1];else return row[1]-row[0];
            NN++;
        }
    }
    int endshu;
    if(row[0] > row[1]){
       endshu =  [_WorldCupdata count] - row[0];
    }else if(row[0] < row[1]){
        endshu =  [_WorldCupdata count] - row[1];
    }
    NSLog(@"endshu = %d",endshu);
    if(endshu < 0)endshu = 1;
    
    WorldData[section] = endshu; return endshu;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"--->section-->%zi---row-->%zi",indexPath.section,indexPath.row);
    static NSString *cellIdentify=@"cell";
    WCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell==nil) {
        cell=[[WCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        
    }
    WModle * modle = [[WModle alloc] init];
    int sect=0;
    for(int i = 0; i < indexPath.section;i++)
    {
        sect += WorldData[i];
    }
    modle.Home_team = [[_WorldCupdata objectAtIndex:(sect+indexPath.row)] objectForKey:@"hometeam"];
    modle.Visiting_team = [[_WorldCupdata objectAtIndex:(sect+indexPath.row)] objectForKey:@"visitingteam"];
    modle.Result = [[_WorldCupdata objectAtIndex:(sect+indexPath.row)] objectForKey:@"gameoutcome"];//结果
    modle.TimeDate = [[_WorldCupdata objectAtIndex:(sect+indexPath.row)] objectForKey:@"datetime"];
    NSString * events =[[_WorldCupdata objectAtIndex:(sect+indexPath.row)] objectForKey:@"events"];
    //NSString * tamedate = [NSString stringWithFormat:@"%@%@",[[_WorldCupdata objectAtIndex:sect] objectForKey:@"competitiondate"],[[_WorldCupdata objectAtIndex:(sect+indexPath.row)] objectForKey:@"competitiontime"]];
    
   for(NSDictionary * dict in _WorldTU)
   {
       if([[dict objectForKey:@"teamname"] isEqualToString:modle.Home_team])
       {
           modle.HometeamURL = [dict objectForKey:@"teamelogo"];
           modle.Home_teamlist = [dict objectForKey:@"teamperson"];
//           NSLog(@"modle.HometeamURL = %@",modle.HometeamURL);
//           NSString * teamperson = [dict objectForKey:@"teamperson"];
//           NSLog(@"teamperson = %@",teamperson);
//           NSArray *array = [teamperson componentsSeparatedByString:@"."];
//           NSLog(@"array:%@",array);
//           for(NSString * strr in array)
//           {
//               NSLog(@"array == %@",[strr componentsSeparatedByString:@","]);
//               for(NSString * strrr in [strr componentsSeparatedByString:@","])
//               {
//                   NSLog(@"name = %@",strrr);
//               }
//           }
           
       }
       if([[dict objectForKey:@"teamname"] isEqualToString:modle.Visiting_team])
       {
           modle.VisitingURL = [dict objectForKey:@"teamelogo"];
           modle.Visiting_teamlist = [dict objectForKey:@"teamperson"];
       }

   }
    NSString * MoleID = [[_WorldCupdata objectAtIndex:(sect+indexPath.row)] objectForKey:@"againstid"];
    NSArray * Moalarray = [NSArray arrayWithObjects:MoleID,modle.Home_team,modle.HometeamURL,modle.Visiting_team,modle.VisitingURL,modle.TimeDate,modle.Home_teamlist,modle.Visiting_teamlist,[[_WorldCupdata objectAtIndex:(sect+indexPath.row)] objectForKey:@"competitiontime"],[[_WorldCupdata objectAtIndex:sect] objectForKey:@"competitiondate"],events,modle.Result, nil];
    
    //[ModleDict initWithObjects:Moalarray forKeys:@"1"];
    [ModleDict setObject:Moalarray forKey:[NSString stringWithFormat:@"%ld",sect+indexPath.row]];
   
    
    
    [cell setData:modle];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark -代理方法
//头部
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //返回指定的 section header 的view，如果没有，这个函数可以不返回view
    UIView * BGV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    BGV.backgroundColor = [UIColor clearColor];
    UIImageView * BGVback = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WorldCupzhu.PNG"]];
    BGVback.frame = CGRectMake(0, 0, 320, 30);
    [BGV addSubview:BGVback];
    
    int sect=0;
    for(int i = 0; i < section;i++)
    {
        sect += WorldData[i];
    }
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 80, 20)];
    lable.text = [[_WorldCupdata objectAtIndex:sect] objectForKey:@"gameevents"];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.font = [UIFont systemFontOfSize:11.0];
    lable.textColor = UIColorFromRGB(0x575757);
    [BGV addSubview:lable];
    
    UILabel * lable1 = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 160, 30)];
    lable1.text = [[_WorldCupdata objectAtIndex:sect] objectForKey:@"competitiondate"];
    lable1.textAlignment = NSTextAlignmentCenter;
    lable1.textColor = [UIColor whiteColor];
    lable1.font = [UIFont systemFontOfSize:18.0];
    [BGV addSubview:lable1];
    
    
    return BGV;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSLog(@"heightForHeaderInSection-->%zi",section);
    //这个方法返回指定的 section的header view 的高度
    return 30;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //这个方法返回指定的 row 的高度。
    NSLog(@"heightForRowAtIndexPath--->seciont-%zi--row---%zi",indexPath.section,indexPath.row);
    return 88;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //响应用户单击事件
    NSLog(@"点击事件 %D,%D",(int)indexPath.section,(int)indexPath.row);
    
    int sect=0;
    for(int i = 0; i < indexPath.section;i++)
    {
        sect += WorldData[i];
    }
    NSLog(@"shuju = %@", [ModleDict objectForKey:[NSString stringWithFormat:@"%ld",sect+indexPath.row]]);
   
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:[ModleDict objectForKey:[NSString stringWithFormat:@"%ld",sect+indexPath.row]] forKey:@"Modle"];
    [defaults synchronize];//用synchronize方法把数据持久化到standardUserDefaults数据库
    
    WCellViewController * WCellV = [[WCellViewController alloc] init];
    [self.navigationController pushViewController:WCellV animated:YES];
    
}



//-------------上传信息-------------

#pragma mark - ASIHttpDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSString *str = [request responseString];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    switch (ident) {
        case RQIdentifierForSendisbeginschedle:
        {
            
            array = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"array jieshu = %@",array);
            [_WorldCupdata removeAllObjects];
            _WorldCupdata = [NSMutableArray arrayWithArray:array];
            
            
            [_WorldCuplist reloadData];
            
        }break;
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



@end
