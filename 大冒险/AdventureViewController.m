//
//  AdventureViewController.m
//  JUJU
//
//  Created by linchuanbin on 14-5-19.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "AdventureViewController.h"

@interface AdventureViewController ()

@end

@implementation AdventureViewController

@synthesize BackImage = _BackImage, DoorImage = _DoorImage, Return = _Return, Share = _Share, Single = _Single, Online = _Online;

static bool ATAB = NO;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView * FDrum =  [[UIImageView alloc] initWithFrame:self.view.bounds];
    FDrum.image = [UIImage imageNamed:@"ADoorBG.png"];
    FDrum.backgroundColor = [UIColor clearColor];
    [self.view addSubview:FDrum];
    
    _DoorImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _DoorImage.image = [UIImage imageNamed:@"A1.PNG"];
    _DoorImage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_DoorImage];
    
    imageM = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"A2.PNG"]];
    imageM.frame = self.view.bounds;
    imageM1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"A3.PNG"]];
    imageM1.frame = self.view.bounds;
    
    [self.view addSubview:imageM];
    [self.view addSubview:imageM1];
    
    _BackImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _BackImage.image = [UIImage imageNamed:@"ADoor.png"];
    _BackImage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_BackImage];
    
    
    _Return = [[UIButton alloc] initWithFrame:CGRectMake(10,5,25, 27)];
    [_Return setBackgroundImage:[UIImage imageNamed:@"Areturn.PNG"] forState:UIControlStateNormal];
    [_Return addTarget:self action:@selector(ReturnBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Return];
    
    
    _Share = [[UIButton alloc] initWithFrame:CGRectMake(280,5, 31, 32)];
    [_Share setBackgroundImage:[UIImage imageNamed:@"Ashare.PNG"] forState:UIControlStateNormal];
    [_Share addTarget:self action:@selector(ShareBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Share];
    
    _Single = [[UIButton alloc] initWithFrame:CGRectMake(105,self.view.bounds.size.height - 100, 111, 40)];
    [_Single setBackgroundImage:[UIImage imageNamed:@"Aopen.png"] forState:UIControlStateNormal];
    [_Single addTarget:self action:@selector(SingleBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Single];
    
    
    _Online = [[UIButton alloc] initWithFrame:CGRectMake(184.5,self.view.bounds.size.height - 100, 111, 40)];
    [_Online setBackgroundImage:[UIImage imageNamed:@"AOnline.PNG"] forState:UIControlStateNormal];
    [_Online addTarget:self action:@selector(OnlineBut) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:_Online];
    
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)SingleBut
{
    NSLog(@"单机");
    
}

-(void)OnlineBut
{
    NSLog(@"联机");
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
    
    [UIView animateWithDuration:0.5 animations:^{
        _DoorImage.frame = CGRectMake(0,0,320,568);
        imageM.frame = CGRectMake(0,0,320,568);
        imageM1.frame = CGRectMake(0, 0,320,568);
    }completion:^(BOOL finished){
        [self.navigationController popViewControllerAnimated:YES];//返回上级
    }];
    
    //[_FcloudBGV removeFromSuperview];
    //[self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: ([self.navigationController.viewControllers count] -2)] animated:YES];
    
    // NSLog(@"count = %D",[self.navigationController.viewControllers count]);
    
}

-(void)ShareBut
{
    
    NSLog(@"MyShareBut");
    if(!ATAB)
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
        
        ATAB = YES;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _QQ.frame = CGRectMake(135, 0, 50, 50);
            _Friend.frame = CGRectMake(135, 0, 50, 50);
            _Msm.frame = CGRectMake(135, 0, 50, 50);
            _Wb.frame = CGRectMake(135, 0, 50, 50);
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
    ATAB = NO;
}
//-------------------------

@end
