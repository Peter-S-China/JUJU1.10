//
//  NophoneViewController.m
//  JUJU
//
//  Created by linchuanbin on 14-5-16.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "NophoneViewController.h"
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

@interface NophoneViewController ()

@end

@implementation NophoneViewController
@synthesize BackImage = _BackImage, Return = _Return, Share = _Share, GametimeImage = _GametimeImage, GamebackImage = _GamebackImage, GameopenImage = _GameopenImage, TimeView = _TimeView;
static bool NTAB = NO;
static bool GameTAB = NO;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
            
        {
            
            [self prefersStatusBarHidden];
            [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];//隐藏状态栏
            
        }
    }
    return self;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置默认参数
    angle =0.0;
    timeInter = 0.15;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[ [ UIApplication sharedApplication] setIdleTimerDisabled:YES ] ;//保持屏幕常亮
    
    _BackImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _BackImage.image = [UIImage imageNamed:@"NBG.PNG"];
    [self.view addSubview:_BackImage];
    
    _Return = [[UIButton alloc] initWithFrame:CGRectMake(15,18,41.5, 26)];
    [_Return setBackgroundImage:[UIImage imageNamed:@"Nreturn.PNG"] forState:UIControlStateNormal];
    [_Return addTarget:self action:@selector(ReturnBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Return];
    
    
    
    _Share = [[UIButton alloc] initWithFrame:CGRectMake(266.5,18,38.5, 37)];
    [_Share setBackgroundImage:[UIImage imageNamed:@"Nshare.PNG"] forState:UIControlStateNormal];
    [_Share addTarget:self action:@selector(ShareBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Share];
    
    _NavBackImage = [CALayer layer];
   // _NavBackImage.frame = CGRectMake(67.5,0, 185, 136.5);
    _NavBackImage.bounds = CGRectMake(0, -10, 185, 136.5);
    _NavBackImage.position = CGPointMake(160, -10);
    _NavBackImage.anchorPoint = CGPointMake(0.5, 0.0);//以这点为支点
    _NavBackImage.contents = (id)[UIImage imageNamed:@"nophone.PNG"].CGImage;
    
    //_NavBackImage.anchorPoint = CGPointMake(0.5, 1.0);
    [self.view.layer addSublayer:_NavBackImage];
    
    //倒计时
    _GametimeImage = [[UIImageView alloc] initWithFrame:CGRectMake(143.5, 310, 33, 48)];
    _GametimeImage.image = [UIImage imageNamed:@"NGameTime.PNG"];
    _GametimeImage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_GametimeImage];
    
    //倒计时间
    _TimeView = [[ UIView alloc] initWithFrame:CGRectMake(115, 365, 90, 16)];
    _TimeView.backgroundColor = [UIColor clearColor];
    _TimeView.clipsToBounds = YES;
    [self.view addSubview:_TimeView];
    for(int i = 0; i < 8;i++)
    {
        int p = 0;
        if(i > 2 )p = -5;
        if(i > 5) p = -10;
        
        if(i == 2 || i == 5)
        {
            UIImageView * MHimage = [[UIImageView alloc] initWithFrame:CGRectMake(i == 2? 25: 57.5,2, 7.5,12)];
            MHimage.image = [UIImage imageNamed:@"NMHBG.PNG"];
            MHimage.tag = i*10;
            MHimage.backgroundColor = [UIColor clearColor];
            [_TimeView addSubview:MHimage];
        }else{
//        for(int N = 0; N < 2; N++)
//        {
            UIImageView * Hours = [[UIImageView alloc] initWithFrame:CGRectMake(i*12.5+p,0, 12.5, 16)];
            Hours.image = [UIImage imageNamed:@"0.PNG"];
            Hours.tag = i*10;
            [_TimeView addSubview:Hours];
       // }
        }
    }
    

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
    
    _GamebackImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _GamebackImage.image = [UIImage imageNamed:@"00000.PNG"];
    _GamebackImage.animationImages = myImages1;
    _GamebackImage.animationDuration = 3;
    [_GamebackImage startAnimating];
    _GamebackImage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_GamebackImage];
    
    
    _GameopenImage = [[UIImageView alloc] initWithFrame:CGRectMake(22.7,self.view.bounds.size.height - 81.5, 274.5, 81.5)];
    _GameopenImage.image = [UIImage imageNamed:@"NopenBG.PNG"];
    _GameopenImage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_GameopenImage];
    
    
    GameNavtime = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(gogame)userInfo:nil repeats:NO];
    
    // Do any additional setup after loading the view.
}
-(void)gogame
{
    NSLog(@"gogame");
    //左右摇摆时间是定义的时间的2倍
    [NSTimer scheduledTimerWithTimeInterval:timeInter*2
                                     target:self
                                   selector:@selector(ballAnmation:)
                                   userInfo:nil
                                    repeats:YES];
}

-(void)ballAnmation:(NSTimer *)theTimer
{
    NSLog(@"香蕉左右摇摆");
    //设置左右摇摆
    if(angle < 10 && !GameTAB)
    {
        angle=-angle;
        if (angle > 0) {
            angle++;
        }else{
            angle--;
        }

    }
    else if(angle == 10 || GameTAB){
        GameTAB = YES;
    angle=-angle;
//    if (angle > 0) {
//        angle--;
//    }else{
//        angle++;
//    }
//        if(angle == 0)GameTAB = NO;
    }
    
    
    
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:(DEGREES_TO_RADIANS(angle))];
    rotationAnimation.duration = timeInter;
    rotationAnimation.autoreverses = YES; // Very convenient CA feature for an animation like this
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_NavBackImage addAnimation:rotationAnimation forKey:@"shakeAnimation"];
//    if (angle == 30) {
//        [theTimer invalidate];
//        //动画完毕操作
//        //动画完毕操作
//        angle =30.0;
//        timeInter = 0.15;
//    }
    
}


-(void)ReturnBut
{
    NSLog(@"ReturnBut");
//    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: ([self.navigationController.viewControllers count] -2)] animated:YES];
//    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
//    [defaults setObject:@"1" forKey:@"NOphoneEND"];

}
-(void)ShareBut
{
    NSLog(@"MyShareBut");
    if(!NTAB)
    {
        _QQ = [[UIButton alloc] initWithFrame:CGRectMake(135, -50, 50, 50)];
        [_QQ setBackgroundImage:[UIImage imageNamed:@"QQ.PNG"] forState:UIControlStateNormal];
        [_QQ addTarget:self action:@selector(QQBut) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_QQ];
        
        _Friend = [[UIButton alloc] initWithFrame:CGRectMake(135, -50, 50, 50)];
        [_Friend setBackgroundImage:[UIImage imageNamed:@"Friend.PNG"] forState:UIControlStateNormal];
        [_Friend addTarget:self action:@selector(FriendBut) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_Friend];
        
        _Msm = [[UIButton alloc] initWithFrame:CGRectMake(135, -50, 50, 50)];
        [_Msm setBackgroundImage:[UIImage imageNamed:@"Msm.PNG"] forState:UIControlStateNormal];
        [_Msm addTarget:self action:@selector(MsmBut) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_Msm];
        
        _Wb = [[UIButton alloc] initWithFrame:CGRectMake(135, -50, 50, 50)];
        [_Wb setBackgroundImage:[UIImage imageNamed:@"Wb.PNG"] forState:UIControlStateNormal];
        [_Wb addTarget:self action:@selector(WbBut) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_Wb];
        
        
        [UIView animateWithDuration:0.5 animations:^{
            _QQ.frame = CGRectMake(135,150, 50, 50);
            _Friend.frame = CGRectMake(35,250, 50, 50);
            _Msm.frame = CGRectMake(235, 250, 50, 50);
            _Wb.frame = CGRectMake(135, 350, 50, 50);
        }];
        
        NTAB = YES;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _QQ.frame = CGRectMake(135, -50, 50, 50);
            _Friend.frame = CGRectMake(135, -50, 50, 50);
            _Msm.frame = CGRectMake(135, -50, 50, 50);
            _Wb.frame = CGRectMake(135, -50, 50, 50);
        }completion:^(BOOL finished){[self removeBut];}];
        
    }
    
    
}
//----------------------

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

//--------------------------

-(void)QQBut
{
    NSLog(@"MYQQBut");
    [self removeBut];
}

-(void)FriendBut
{
    NSLog(@"MyFriendBut");
    [self removeBut];
}

-(void)MsmBut
{
    NSLog(@"MyMsmBut");
    [self removeBut];
}

-(void)WbBut
{
    NSLog(@"MyWbBut");
    [self removeBut];
}
-(void)removeBut
{
    [_QQ removeFromSuperview];
    [_Friend removeFromSuperview];
    [_Msm removeFromSuperview];
    [_Wb removeFromSuperview];
    NTAB = NO;
}
//------------------------


@end
