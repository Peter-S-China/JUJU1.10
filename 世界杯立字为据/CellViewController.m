//
//  CellViewController.m
//  JUJU
//
//  Created by linchuanbin on 14-5-18.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "CellViewController.h"

@interface CellViewController ()

@end

@implementation CellViewController

@synthesize  hometeam = hometeam, visitingteam = visitingteam, hometeamV = hometeamV,visitingteamV = visitingteamV;

static bool CellTAB = YES;
static bool Help = YES;

static RQIdflower ident;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)endButton
{
    [tchuV removeFromSuperview];
    Help = YES;
}


-(void)HelpGame
{
    if(Help)
    {
        Help = NO;
    tchuV =[[UIView alloc] initWithFrame:self.view.bounds];
    tchuV.backgroundColor = [UIColor blackColor];
    tchuV.alpha = 1;
    [self.view addSubview:tchuV];
    
    
    UIView * TchuVV = [[UIView alloc] init];
    TchuVV.center = tchuV.center;
    TchuVV.backgroundColor = [UIColor whiteColor];
    TchuVV.bounds = CGRectMake(0, 0, 300, 400);
    [tchuV addSubview:TchuVV];
    
    UIButton * endButton = [UIButton buttonWithType:UIButtonTypeCustom];
    endButton.frame = CGRectMake(240, 5, 60, 60);
    [endButton addTarget:self action:@selector(endButton) forControlEvents:UIControlEventTouchUpInside];
    [endButton setBackgroundImage:[UIImage imageNamed:@"btn_close_normal"] forState:UIControlStateNormal];
    [endButton setBackgroundImage:[UIImage imageNamed:@"btn_close_selected"] forState:UIControlStateHighlighted];
    [TchuVV addSubview:endButton];
    
    UITextView * content = [[UITextView alloc] initWithFrame:CGRectMake(10, 80, 280,320)];
    content.font = [UIFont fontWithName:@"Arial" size:18.0];//设置字体名字和字体大小
    content.scrollEnabled = YES;//是否可以拖动
    content.backgroundColor = [UIColor clearColor];
    content.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    content.editable = NO;
    content.text = @"平手———双方平开，不让球\n平手/半球 ———打平输一半，净胜一球全赢\n半球 ———打平全输，净胜一球全赢\n半球/一球 ———净胜一球赢一半，净胜两球全赢\n一球 ———净胜两球全赢，净胜一球算平\n一球/球半 ———净胜一球输一半，净胜两球全赢\n球半 ———净胜一球全输，净胜两球全赢\n球半/两球 ———净胜两球赢一半，净胜三球全赢\n两球 ———净胜两球算平，净胜三球全赢\n两球/两球半 ———净胜两球输一半，净胜三球全赢\n*默认左边球队为主队，右边为客队\n如主队实力弱于客队，“让球”改为“受让”，即“被让球";
    [TchuVV addSubview:content];
    
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSLog(@"1111 =%@",[defaults objectForKey:@"Modle"]);
    
    _TitleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 26)];
    _TitleImage.backgroundColor = [UIColor clearColor];
    _TitleImage.image = [UIImage imageNamed:@"WorldCupzhu.PNG"];
    [self.view addSubview:_TitleImage];
    
    _TeamImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, 320, 88)];
    _TeamImage.backgroundColor = [UIColor clearColor];
    _TeamImage.image = [UIImage imageNamed:@"WCellBG.PNG"];
    _TeamImage.userInteractionEnabled = YES;
    [self.view addSubview:_TeamImage];
    
    
    hometeamV = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"icon.png"]];
    hometeamV.frame = CGRectMake(45, 14, 45, 45);
    hometeamV.clipsToBounds = YES;
    hometeamV.layer.cornerRadius = 22.5;
    [hometeamV.layer setBorderWidth:1.0]; //边框宽度
    [hometeamV.layer setBorderColor:[[UIColor blackColor] CGColor]];
    hometeamV.backgroundColor = [UIColor clearColor];
    
    hometeam = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 135, 20)];
    hometeam.text = [[defaults objectForKey:@"Modle"] objectAtIndex:1];
    hometeam.textAlignment = NSTextAlignmentCenter;
    hometeam.textColor = [UIColor grayColor];
    hometeam.backgroundColor = [UIColor clearColor];
    
    
    visitingteamV = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"icon.png"]];
    visitingteamV.frame = CGRectMake(230, 14, 45, 45);
    visitingteamV.layer.cornerRadius = 22.5;
    visitingteamV.clipsToBounds = YES;
    [visitingteamV.layer setBorderWidth:1.0]; //边框宽度
    [visitingteamV.layer setBorderColor:[[UIColor blackColor] CGColor]];
    visitingteamV.backgroundColor = [UIColor clearColor];
    
    visitingteam = [[UILabel alloc] initWithFrame:CGRectMake(185, 60, 135, 20)];
    visitingteam.text = [[defaults objectForKey:@"Modle"] objectAtIndex:3];
    visitingteam.textAlignment = NSTextAlignmentCenter;
    visitingteam.textColor = [UIColor grayColor];
    visitingteam.backgroundColor = [UIColor clearColor];
    
    hometeamV.imageURL = [NSURL URLWithString:[[defaults objectForKey:@"Modle"] objectAtIndex:2]];
    visitingteamV.imageURL = [NSURL URLWithString:[[defaults objectForKey:@"Modle"] objectAtIndex:4]];
    
    
    [_TeamImage addSubview:hometeamV];
    [_TeamImage addSubview:hometeam];
    [_TeamImage addSubview:visitingteamV];
    [_TeamImage addSubview:visitingteam];
    
   
    Tbutton = [[UIButton alloc] initWithFrame:CGRectMake(110,63,100, 25)];
    [Tbutton setBackgroundImage:[UIImage imageNamed:@"Tbutton.PNG"] forState:UIControlStateNormal];
    [Tbutton setTitle:@"平手" forState:UIControlStateNormal];
    [Tbutton addTarget:self action:@selector(Tbutton) forControlEvents:UIControlEventTouchUpInside];
    [_TeamImage addSubview:Tbutton];

    
    QArray = [[NSMutableArray alloc] init];
    
    UITableV = [[UIView alloc] initWithFrame:CGRectMake(0, 158, 320, self.view.bounds.size.height - 158)];
    UITableV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:UITableV];
    UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 120, 30)];
    lable.text = @"竟猜信息";
    lable.backgroundColor = [UIColor clearColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor grayColor];
    [UITableV addSubview:lable];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeInfoLight];
    button.frame = CGRectMake(260,5,20, 28);
    button.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [button addTarget:self action:@selector(HelpGame) forControlEvents:UIControlEventTouchUpInside];
    [UITableV addSubview:button];
    
    QtableV = [[UITableView alloc] initWithFrame:CGRectMake(0,30, 320, self.view.bounds.size.height - 188) style:UITableViewStylePlain];
    QtableV.separatorStyle = UITableViewCellSeparatorStyleNone;//去除边框
    //_tableV.backgroundColor = [UIColor clearColor];//UIColorFromRGB(0xe6e6e6);
    QtableV.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth;
    //_tableV.rowHeight = 40.0;
    QtableV.dataSource = self;
    QtableV.delegate = self;
    QtableV.showsVerticalScrollIndicator = NO;//垂直滚动条
    QtableV.backgroundColor = [UIColor clearColor];
    [UITableV addSubview:QtableV];
    
    ident =  RQIdentifierForSenduseroutcome;
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SenduseroutcomeURL]];
    [upLoadRequest setPostValue:[defaults objectForKey:@"_Roomnumber"] forKey:@"homenum"];
    [upLoadRequest setPostValue:[[defaults objectForKey:@"Modle"] objectAtIndex:0] forKey:@"againstid"];
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];
    
    
    

    
    // Do any additional setup after loading the view.
}

-(void)addChoiceScrollV
{
    NSArray * array = [NSArray arrayWithObjects:@"",@"受让七球",@"受让六球半",@"受让六球",@"受让五球半",@"受让五球",@"受让四球半",@"受让四球",@"受让三球半",@"受让三球",@"受让二球半",@"受让二球",@"受让一球半",@"受让一球",@"平手",@"让一球",@"让一球半",@"让二球",@"让二球半",@"让三球",@"让三球半",@"让四球",@"让四球半",@"让五球",@"让五球半",@"让六球",@"让六球半",@"让七球",@"", nil];
    for(int i = 0; i < 29;i++)
    {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15 + i*106.6 ,10 ,76.6, 30);
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [button addTarget:self action:@selector(gameBUT:) forControlEvents:UIControlEventTouchUpInside];
        [ChoiceScrollV addSubview:button];
        
        //UIButton * button = [UIButton alloc] initWithFrame:CGRectMake(20*, 10, 90, 30);
    }
    
    
}

-(void)gameBUT:(UIButton * )but
{
    [Tbutton setTitle:but.titleLabel.text forState:UIControlStateNormal];
    CellTAB = YES;
    [ChoiceScrollV removeFromSuperview];
    UITableV.frame = CGRectMake(0, 158, 320, self.view.bounds.size.height - 158);
    
    ident =  RQIdentifierForGetuseroutcome;
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSLog(@"eee=%@",[[defaults objectForKey:@"Modle"] objectAtIndex:0]);
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:GetuseroutcomeURL]];
    [upLoadRequest setPostValue:[defaults objectForKey:@"_userID"] forKey:@"id"];
    [upLoadRequest setPostValue:[defaults objectForKey:@"_Roomnumber"] forKey:@"homenum"];
    [upLoadRequest setPostValue:but.titleLabel.text forKey:@"useroutcome"];
    [upLoadRequest setPostValue:[[defaults objectForKey:@"Modle"] objectAtIndex:0] forKey:@"againstid"];
    [upLoadRequest setPostValue:@"0" forKey:@"teamid"];
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];
    
}

-(void)Tbutton
{
    NSLog(@"Tbutton");
    if(CellTAB)
    {
        CellTAB = NO;
            ChoiceScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 158, 320, 70)];
            ChoiceScrollV.backgroundColor = [UIColor clearColor];
            //ChoiceScrollV.tag = 1000;
            ChoiceScrollV.contentSize = CGSizeMake(320 * 10, 70);
            ChoiceScrollV.showsHorizontalScrollIndicator = NO;//滚动的时候是否有水平的滚动条，默认是有的
            ChoiceScrollV.delegate = self;
            CGPoint position = CGPointMake(1380, 0);
            [ChoiceScrollV setContentOffset:position animated:YES];
            [self.view addSubview:ChoiceScrollV];
        [self addChoiceScrollV];
        UITableV.frame = CGRectMake(0, 228, 320, self.view.bounds.size.height - 228);
        
    }else{
        CellTAB = YES;
        [ChoiceScrollV removeFromSuperview];
        UITableV.frame = CGRectMake(0, 158, 320, self.view.bounds.size.height - 158);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ReturnBut
{
    NSLog(@"CellVReturnBut");
    [self.navigationController popViewControllerAnimated:YES];//返回上级
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    if(!CellTAB)
    {
    NSLog(@"ContentOffset  x is  %f,yis %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    NSArray * array = [NSArray arrayWithObjects:@"",@"受让七球",@"受让六球半",@"受让六球",@"受让五球半",@"受让五球",@"受让四球半",@"受让四球",@"受让三球半",@"受让三球",@"受让二球半",@"受让二球",@"受让一球半",@"受让一球",@"平手",@"让一球",@"让一球半",@"让二球",@"让二球半",@"让三球",@"让三球半",@"让四球",@"让四球半",@"让五球",@"让五球半",@"让六球",@"让六球半",@"让七球",@"", nil];
     [Tbutton setTitle:[array objectAtIndex:(int)(scrollView.contentOffset.x/100)+1] forState:UIControlStateNormal];
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

//-------------上传信息-------------

#pragma mark - ASIHttpDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSString *str = [request responseString];
    switch (ident) {
        case RQIdentifierForGetuseroutcome:
        {
            NSLog(@"str = %@",str);
            
            ident =  RQIdentifierForSenduseroutcome;
             NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SenduseroutcomeURL]];
            [upLoadRequest setPostValue:[defaults objectForKey:@"_Roomnumber"] forKey:@"homenum"];
            [upLoadRequest setPostValue:[[defaults objectForKey:@"Modle"] objectAtIndex:0] forKey:@"againstid"];
            [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
            upLoadRequest.delegate = self;
            [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
            
            [upLoadRequest startAsynchronous];
        }
        break;
            case RQIdentifierForSenduseroutcome:
        {
            NSLog(@"数据 = %@",str);
            [QArray removeAllObjects];
            NSArray * array = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            for(NSDictionary * dict in array)
            {
                [QArray addObject:dict];
            }
            [QtableV reloadData];
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
    return [QArray count];
}


//开辟存储数据的空间
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier =@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@    %@",[[[QArray objectAtIndex:indexPath.row] objectForKey:@"username"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[QArray objectAtIndex:indexPath.row] objectForKey:@"useroutcome"]];
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
