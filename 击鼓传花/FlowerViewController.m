//
//  FlowerViewController.m
//  JUJU
//
//  Created by linchuanbin on 14-5-8.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "FlowerViewController.h"

@interface FlowerViewController ()

@end

@implementation FlowerViewController

static int MobileX = 0;

@synthesize BackImage = _BackImage, Return = _Return, Flower = _Flower, Share = _Share, Button = _Button, Adventure = _Adventure, flowerV = _flowerV, QQ = _QQ, Friend = _Friend, Msm = _Msm, Wb = _Wb;

static bool FTAB = NO;

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


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

-(void)FDrumBut
{
    //水波
    CATransition *animation = [CATransition animation];
    animation.type =@"rippleEffect";
    [animation setDuration:0.5];
    [animation setRepeatCount:3.0];
    [_BackImage.layer addAnimation:animation forKey:@"s rippleEffect"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView * FDrum =  [[UIImageView alloc] initWithFrame:self.view.bounds];
    FDrum.image = [UIImage imageNamed:@"FlowerVBG.png"];
    FDrum.backgroundColor = [UIColor clearColor];
    [self.view addSubview:FDrum];
    
    _FradiationBG = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _FradiationBG.image = [UIImage imageNamed:@"Fradiation.PNG"];
    _FradiationBG.backgroundColor = [UIColor clearColor];
    //[_FradiationBG startAnimating];
    _FradiationBG.contentMode = UIViewContentModeCenter;
    _FradiationBG.clipsToBounds = YES;
    [self.view addSubview:_FradiationBG];
    
    CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [spin setToValue:[NSNumber numberWithFloat:M_PI * 16.0]];
    [spin setDuration:3];
    spin.repeatCount = 1000;
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:spin,nil];
    animGroup.duration = 4;
    [animGroup setDelegate:self];
    [_FradiationBG.layer addAnimation:animGroup forKey:@"position"];
    
    
    _BackImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _BackImage.image = [UIImage imageNamed:@"FDrum.PNG"];
    _BackImage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_BackImage];
    
    UIButton * FDrumBut = [[UIButton alloc] initWithFrame:CGRectMake(50, 348, 220, 100)];
    FDrumBut.backgroundColor = [UIColor clearColor];
    [FDrumBut addTarget:self action:@selector(FDrumBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:FDrumBut];
    
    
    _FcloudBGV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,580, 568)];
    _FcloudBGV.image = [[UIImage imageNamed:@"FCloudBG.PNG"] scaleToSize:CGSizeMake(580, 675)];
    _FcloudBGV.contentMode =  UIViewContentModeCenter;
    //_FcloudBGV.center =  CGPointMake(30, 284);
    //_FcloudBGV.clipsToBounds  = YES;
    //_FcloudBGV.backgroundColor = [UIColor redColor];
    // _FcloudBGV.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_FcloudBGV];

    
    _Return = [[UIButton alloc] initWithFrame:CGRectMake(10,30, 30, 25)];
    [_Return setBackgroundImage:[UIImage imageNamed:@"Freturn.PNG"] forState:UIControlStateNormal];
    [_Return addTarget:self action:@selector(ReturnBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Return];
    
    _Flower = [[UIButton alloc] initWithFrame:CGRectMake(75, 0, 170, 100)];
    [_Flower setBackgroundImage:[UIImage imageNamed:@"Ftitle.PNG"] forState:UIControlStateNormal];
    [_Flower addTarget:self action:@selector(FlowerBut) forControlEvents:UIControlEventTouchUpInside];
    [_Flower setUserInteractionEnabled:NO];
    [self.view addSubview:_Flower];

    
    _Share = [[UIButton alloc] initWithFrame:CGRectMake(280,30, 30, 30)];
    [_Share setBackgroundImage:[UIImage imageNamed:@"Fshare.PNG"] forState:UIControlStateNormal];
    [_Share addTarget:self action:@selector(ShareBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Share];
    
    _Button = [[UIButton alloc] initWithFrame:CGRectMake(75, 480 , 140, 60)];
    [_Button setBackgroundImage:[UIImage imageNamed:@"Fopen.PNG"] forState:UIControlStateNormal];
    [_Button addTarget:self action:@selector(ButtonBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Button];
    
    _Adventure = [[UIButton alloc] initWithFrame:CGRectMake(75, -200, 170, 80)];
    [_Adventure setBackgroundImage:[UIImage imageNamed:@"Fadventure.PNG"] forState:UIControlStateNormal];
    [_Adventure addTarget:self action:@selector(AdventureBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Adventure];
    
    _flowerV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flower.PNG"]];
    //_flowerV.center = self.view.center;
    _flowerV.frame = CGRectMake(91.5,320, 135, 135);
    [self.view addSubview:_flowerV];

   // _FcloudBGV.center =  CGPointMake(240, 284);
    [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(scrollTimer11)userInfo:nil repeats:YES];
    NSLog(@"_FcloudBGV.center = %f",_FcloudBGV.center.x);
    [UIView animateWithDuration:10 animations:^{
        _FcloudBGV.frame = CGRectMake(-260, 0,580, 568);
    } completion:^(BOOL finished){
        [UIView animateWithDuration:10 animations:^{
            _FcloudBGV.frame = CGRectMake(0, 0,580, 568);
        }];
    }];
    
    
   
    // Do any additional setup after loading the view.
}

-(void)scrollTimer11
{
    NSLog(@"scrollTimer");
    [UIView animateWithDuration:10 animations:^{
         _FcloudBGV.frame = CGRectMake(-260, 0,580, 568);
    } completion:^(BOOL finished){
        [UIView animateWithDuration:10 animations:^{
            _FcloudBGV.frame = CGRectMake(0, 0,580, 568);
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
    
//    [_FcloudBGV removeFromSuperview];
//    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: ([self.navigationController.viewControllers count] -2)] animated:YES];
   // NSLog(@"count = %D",[self.navigationController.viewControllers count]);
    
}
-(void)FlowerBut
{
    
}

-(void)ShareBut
{
    
    NSLog(@"MyShareBut");
    if(!FTAB)
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
        
        FTAB = YES;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _QQ.frame = CGRectMake(214, 0, 50, 50);
            _Friend.frame = CGRectMake(214, 0, 50, 50);
            _Msm.frame = CGRectMake(214, 0, 50, 50);
            _Wb.frame = CGRectMake(214, 0, 50, 50);
        }completion:^(BOOL finished){[self removeBut];}];
        
        
    }

    
}

-(void)ButtonBut
{
    
}

-(void)AdventureBut
{
    
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
    FTAB = NO;
}
//-------------------------

@end
