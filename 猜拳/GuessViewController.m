//
//  GuessViewController.m
//  JUJU
//
//  Created by linchuanbin on 14-5-21.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "GuessViewController.h"

@interface GuessViewController ()

@end

@implementation GuessViewController

@synthesize BackImage = _BackImage, Return = _Return, Share = _Share, BackCenterImage = _BackCenterImage;

static bool GTAB = NO;

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation==UIInterfaceOrientationLandscapeRight);
//    
//}


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
        
          //[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
        
    }
    return self;
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    self.navigationController.view.transform = CGAffineTransformIdentity;
    self.navigationController.view.transform = CGAffineTransformMakeRotation(M_PI*(90)/180.0);
    self.navigationController.view.bounds = CGRectMake(0, 0, 568, 320);
    [UIView commitAnimations];
    [[UIApplication sharedApplication] setStatusBarOrientation: UIInterfaceOrientationLandscapeRight animated:YES];
}


-(void)MyButon:(UIButton *)but
{
    
    NSLog(@"MyButton");
//    if(but.tag == 1)
//    {
//        
//    }else{
//        
//    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView * GDrum =  [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 568, 225)];
    GDrum.image = [UIImage imageNamed:@"GBG.PNG"];
    GDrum.backgroundColor = [UIColor clearColor];
    [self.view addSubview:GDrum];
    
    UIImageView * GX = [[UIImageView alloc] initWithFrame:CGRectMake(0,225, 568, 95)];
    GX.image = [UIImage imageNamed:@"GX.PNG"];
    GX.backgroundColor = [UIColor clearColor];
    GX.userInteractionEnabled = YES;//可以出发GX上的点击事件
    [self.view addSubview:GX];
    
    
    _BackCenterImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GCenter.PNG"]];
    _BackCenterImage.center = CGPointMake(284, 135);
    _BackCenterImage.bounds = CGRectMake(0, 0, 86, 84);
    _BackCenterImage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_BackCenterImage];
    
    
    
    
    _BackImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _BackImage.image = [UIImage imageNamed:@"ADoor.png"];
    _BackImage.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:_BackImage];
    
   // _BackdownImage = [UIImageView alloc] initWithFrame:;
    
    
    _Return = [[UIButton alloc] initWithFrame:CGRectMake(10,5,36, 27)];
    [_Return setBackgroundImage:[UIImage imageNamed:@"Greturn.PNG"] forState:UIControlStateNormal];
    [_Return addTarget:self action:@selector(ReturnBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Return];
    
    
    _Share = [[UIButton alloc] initWithFrame:CGRectMake(525,5, 33, 32)];
    [_Share setBackgroundImage:[UIImage imageNamed:@"Gshare.PNG"] forState:UIControlStateNormal];
    [_Share addTarget:self action:@selector(ShareBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Share];
    
    MyButon[0] = [[UIButton alloc] initWithFrame:CGRectMake(10,40,134, 40)];
    MyButon[0].tag = 1;
    [MyButon[0] setBackgroundImage:[UIImage imageNamed:@"MyButton1.PNG"] forState:UIControlStateNormal];
    [MyButon[0] addTarget:self action:@selector(MyButon:) forControlEvents:UIControlEventTouchUpInside];
    [GX addSubview:MyButon[0]];
    
    MyButon[1] = [[UIButton alloc] initWithFrame:CGRectMake(424,40, 134, 40)];
    MyButon[1].tag = 2;
    [MyButon[1] setBackgroundImage:[UIImage imageNamed:@"MyButton2.PNG"] forState:UIControlStateNormal];
    [MyButon[1] addTarget:self action:@selector(MyButon:) forControlEvents:UIControlEventTouchUpInside];
    [GX addSubview:MyButon[1]];
    
    MyButon[2] = [[UIButton alloc] initWithFrame:CGRectMake(170, 10, 68, 67.5)];
    MyButon[2].tag = 3;
    [MyButon[2] setBackgroundImage:[UIImage imageNamed:@"MyButton3.PNG"] forState:UIControlStateNormal];
    [MyButon[2] addTarget:self action:@selector(MyButon:) forControlEvents:UIControlEventTouchUpInside];
    [GX addSubview:MyButon[2]];
    
    MyButon[3] = [[UIButton alloc] initWithFrame:CGRectMake( 263 ,10, 68, 67.5)];
    MyButon[3].tag = 4;
    [MyButon[3] setBackgroundImage:[UIImage imageNamed:@"MyButton4.PNG"] forState:UIControlStateNormal];
    [MyButon[3] addTarget:self action:@selector(MyButon:) forControlEvents:UIControlEventTouchUpInside];
    [GX addSubview:MyButon[3]];
    
    MyButon[4] = [[UIButton alloc] initWithFrame:CGRectMake(356,10, 68, 67.5)];
    MyButon[4].tag = 5;
    [MyButon[4] setBackgroundImage:[UIImage imageNamed:@"MyButton5.PNG"] forState:UIControlStateNormal];
    [MyButon[4] addTarget:self action:@selector(MyButon:) forControlEvents:UIControlEventTouchUpInside];
    [GX addSubview:MyButon[4]];
    
    
    BGImage[0] = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 305, 320)];
    //BGImage[0].tag = 1;
    BGImage[0].image = [UIImage imageNamed:@"GopenBG1.PNG"];
    BGImage[0].backgroundColor = [UIColor clearColor];
    [self.view addSubview:BGImage[0]];
    
    BGImage[1] = [[UIImageView alloc] initWithFrame:CGRectMake(283, 0, 285, 320)];
    //BGImage[1].tag = 2;
    BGImage[1].image = [UIImage imageNamed:@"GopenBG2.PNG"];
    BGImage[1].backgroundColor = [UIColor clearColor];
    [self.view addSubview:BGImage[1]];
    
    BGImage[2] = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 114.5, 320)];
    //BGImage[2].tag = 3;
    BGImage[2].image = [UIImage imageNamed:@"GopenBG3.PNG"];
    BGImage[2].backgroundColor = [UIColor clearColor];
    [self.view addSubview:BGImage[2]];
    
    BGImage[3] = [[UIImageView alloc] initWithFrame:CGRectMake(471, 0, 97, 316.5)];
    //BGImage[3].tag = 4;
    BGImage[3].image = [UIImage imageNamed:@"GopenBG4.PNG"];
    BGImage[3].backgroundColor = [UIColor clearColor];
    [self.view addSubview:BGImage[3]];
    
    BGImage[4] = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,568, 53.5)];
    //BGImage[4].tag = 5;
    BGImage[4].image = [UIImage imageNamed:@"GopenBG5.PNG"];
    BGImage[4].backgroundColor = [UIColor clearColor];
    [self.view addSubview:BGImage[4]];

    AVAudioPlayer * player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"readygo" ofType:@"mp3"]] error:nil];
    [player play];
    
    [self performSelector:@selector(Open) withObject:nil afterDelay:1];

    // Do any additional setup after loading the view.
}

-(void)Open
{
    [UIView animateWithDuration:2 animations:^{
        BGImage[0].frame = CGRectMake(-310, 0, 305, 320);
        BGImage[1].frame = CGRectMake(868, 0, 285, 320);
    }completion:^(BOOL finished){
        [UIView animateWithDuration:2 animations:^{
            BGImage[2].frame = CGRectMake(-120, 0, 114.5, 320);
            BGImage[3].frame = CGRectMake(668, 0, 97, 316.5);
            BGImage[4].frame = CGRectMake(0,-60,568, 53.5);
        }];
        
    }];
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

-(void)ReturnBut
{
    NSLog(@"MyReturn");
    
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    self.navigationController.view.transform = CGAffineTransformIdentity;
    self.navigationController.view.transform = CGAffineTransformMakeRotation(M_PI*(0)/180.0);
    self.navigationController.view.bounds = CGRectMake(0, 0, 320, 568);
    [UIView commitAnimations];
    //[[UIApplication sharedApplication] setStatusBarOrientation:UIDeviceOrientationPortrait  animated:YES];
    
     [self.navigationController popViewControllerAnimated:YES];//返回上级

    
}

-(void)ShareBut
{
    
    NSLog(@"MyShareBut");
    if(!GTAB)
    {
        _QQ = [[UIButton alloc] initWithFrame:CGRectMake(260, -50, 50, 50)];
        [_QQ setBackgroundImage:[UIImage imageNamed:@"QQ.PNG"] forState:UIControlStateNormal];
        [_QQ addTarget:self action:@selector(QQBut) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_QQ];
        
        _Friend = [[UIButton alloc] initWithFrame:CGRectMake(260, -50, 50, 50)];
        [_Friend setBackgroundImage:[UIImage imageNamed:@"Friend.PNG"] forState:UIControlStateNormal];
        [_Friend addTarget:self action:@selector(FriendBut) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_Friend];
        
        _Msm = [[UIButton alloc] initWithFrame:CGRectMake(260, -50, 50, 50)];
        [_Msm setBackgroundImage:[UIImage imageNamed:@"Msm.PNG"] forState:UIControlStateNormal];
        [_Msm addTarget:self action:@selector(MsmBut) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_Msm];
        
        _Wb = [[UIButton alloc] initWithFrame:CGRectMake(260, -50, 50, 50)];
        [_Wb setBackgroundImage:[UIImage imageNamed:@"Wb.PNG"] forState:UIControlStateNormal];
        [_Wb addTarget:self action:@selector(WbBut) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_Wb];
        
        
        [UIView animateWithDuration:0.5 animations:^{
            _QQ.frame = CGRectMake(260,50, 50, 50);
            _Friend.frame = CGRectMake(160,150, 50, 50);
            _Msm.frame = CGRectMake(360, 150, 50, 50);
            _Wb.frame = CGRectMake(260, 250, 50, 50);
        }];
        
        GTAB = YES;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _QQ.frame = CGRectMake(260, 0, 50, 50);
            _Friend.frame = CGRectMake(260, 0, 50, 50);
            _Msm.frame = CGRectMake(260, 0, 50, 50);
            _Wb.frame = CGRectMake(260, 0, 50, 50);
        }completion:^(BOOL finished){[self removeBut];}];
    }
    
    
}



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
    GTAB = NO;
}
//-------------------------

@end
