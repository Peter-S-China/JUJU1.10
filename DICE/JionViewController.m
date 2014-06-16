//
//  JionViewController.m
//  Dice
//
//  Created by linchuanbin on 14-4-30.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "JionViewController.h"
#import "ParticipantViewController.h"
#import "List1Cell.h"
#import "List1Model.h"

#import "AdventViewController.h"

@interface JionViewController ()

@end

@implementation JionViewController

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
    
    //[self.Shake setUserInteractionEnabled:NO];
    //[self.Game setUserInteractionEnabled:NO];
    [self.Dice setUserInteractionEnabled:NO];
    _Title12.alpha = 0.0;
    self.Background.image = [UIImage imageNamed:@"JionBG.PNG"];
    
    UIImageView * jieguoV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jieguo.PNG"]];
    jieguoV.frame = CGRectMake(110, 80, 100, 12);
    [self.view addSubview:jieguoV];
    _Namelist = [[UITableView alloc] initWithFrame:CGRectMake(0,100, 320, 400) style:UITableViewStylePlain];
    _Namelist.separatorStyle = UITableViewCellSeparatorStyleNone;//去除边框
    //_Namelist.backgroundColor = [UIColor grayColor];//UIColorFromRGB(0xe6e6e6);
    _Namelist.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth;
    //_tableV.rowHeight = 40.0;
    _Namelist.dataSource = self;
    _Namelist.delegate = self;
    _Namelist.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_Namelist];
    
    _Namelietdata = [[NSMutableArray alloc] init];
    
     _chattime = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(scrollTimer)userInfo:nil repeats:YES];
    
    // Do any additional setup after loading the view.
}

-(void)scrollTimer
{
    NSLog(@"查筛游戏 桌号数目!");
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString * usergamehomenum = [defaults objectForKey:@"usergamehomenum"];//根据键值取出usergamehomenum桌号
    NSLog(@"游戏 桌号 =%@",usergamehomenum);
    //获取游戏结果list
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SendbosonsCoverURL]];
    [upLoadRequest setPostValue:usergamehomenum forKey:@"gamehomenum"];//桌名
    [upLoadRequest setPostValue:[defaults objectForKey:@"sum"] forKey:@"sum"];//人数

    
    
    [upLoadRequest setTimeOutSeconds:30.f];//设置超时秒
    
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    [upLoadRequest startAsynchronous];
}

//-(void)ReturnBut
//{
//    NSLog(@"Return");
//}

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
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString * userID = [defaults objectForKey:@"userID"];//根据键值取出userID
    
    switch ([userID intValue]) {
        case 1:{
            [self.navigationController popViewControllerAnimated:YES];//返回上级
            //从UIViewController返回上一个UIViewController
            //[self dismissViewControllerAnimated:true completion:^{}];
        }break;
        case 0:{
            //参与者
            [self.navigationController popViewControllerAnimated:YES];//返回上级
           //[self dismissViewControllerAnimated:true completion:^{}];
        }break;
        case 3:{
            //加入者
            ParticipantViewController * participantV = [[ParticipantViewController alloc] init];
            [self presentViewController:participantV animated:true completion:^{}];
        }break;
        default:
            break;
    }

}

-(void)ShakeBut
{
    NSLog(@"ShakeBut 摇起来");
    
}
-(void)AdventureBut
{
    NSLog(@"AdventureBut 大冒陷");
    AdventViewController * AdventV = [[AdventViewController alloc] init];
    [self.navigationController pushViewController:AdventV animated:YES];
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

//---------------------------------------------
#pragma mark - View lifecycle

//自动调用后
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}


//返回每个section的元数个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_Namelietdata count];
}


//-(ContactsCell *)ContactsCell
//{
//    return (ContactsCell *)[[UIApplication sharedApplication] delegate];
//}

//开辟存储数据的空间
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"Cell";
    List1Cell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[List1Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //CelltableV = [[[UITableView alloc] init]autorelease];
        
    }
    List1Model * model = [[List1Model alloc] init];
    model.Name = [NSString stringWithFormat:@"%@",[[[_Namelietdata objectAtIndex:indexPath.row] objectForKey:@"username"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    model.GameHead = [NSString stringWithFormat:@"%@",[[_Namelietdata objectAtIndex:indexPath.row] objectForKey:@"bosonscover"]];
    model.NameHead = [NSString stringWithFormat:@"%@",[[_Namelietdata objectAtIndex:indexPath.row] objectForKey:@"imgpath"]];
    [cell setData:model];
    
    NSLog(@"_Namelietdata");
    cell.backgroundColor = [UIColor clearColor];
    cell.userInteractionEnabled = NO;//不可选中
    
    return cell;

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"dan ji");
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//-------------上传信息-------------

#pragma mark - ASIHttpDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    //反馈数据
    //[activityView hidden];
    
    NSString *str = [request responseString];
    NSLog(@"用户信息 = %@",str);
    
    NSArray * array = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"array= %@",array);
    if(array != nil)
    {
        [_chattime setFireDate:[NSDate distantFuture]];//暂停
    [_Namelietdata removeAllObjects];
    for(NSDictionary * dict in array)
    {
        [_Namelietdata addObject:dict];
         NSLog(@"_Namelietdata = %@",_Namelietdata);
    }
    NSLog(@"_Namelietdata = %@",_Namelietdata);
    [_Namelist reloadData];
    }
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

-(void)ReturnBut
{
    NSLog(@"MyReturn");
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: ([self.navigationController.viewControllers count] -3)] animated:YES];
    //[self.navigationController popViewControllerAnimated:YES];//返回上级
    
}


@end
