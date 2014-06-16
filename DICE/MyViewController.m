//
//  MyViewController.m
//  Dice
//
//  Created by linchuanbin on 14-5-4.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

@synthesize Background = _Background, Return = _Return, Dice =_Dice, Share = _Share, Shake = _Shake, Adventure = _Adventure, QQ = _QQ, Friend = _Friend, Msm = _Msm, Wb = _Wb, Title12 = _Title12;

static bool MYTAB = NO;

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

    
    }
    return self;
}

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
    MYTAB = NO;
}
//-----------

-(void)ReturnBut
{
    NSLog(@"MyReturn");
    //[self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: ([self.navigationController.viewControllers count] -2)] animated:YES];
    //[self.navigationController popViewControllerAnimated:YES];//返回上级

}
-(void)DiceBut
{
    NSLog(@"MyDice");
}
-(void)ShareBut
{
    NSLog(@"MyShareBut");
    if(!MYTAB)
    {
    _QQ = [[UIButton alloc] initWithFrame:CGRectMake(214, 0, 50, 50)];
    [_QQ setBackgroundImage:[UIImage imageNamed:@"QQ.PNG"] forState:UIControlStateNormal];
    [_QQ addTarget:self action:@selector(QQBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_QQ];
    
    _Friend = [[UIButton alloc] initWithFrame:CGRectMake(214, 0, 50, 50)];
    [_Friend setBackgroundImage:[UIImage imageNamed:@"Friend.PNG"] forState:UIControlStateNormal];
    [_Friend addTarget:self action:@selector(FriendBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Friend];
    
    _Msm = [[UIButton alloc] initWithFrame:CGRectMake(214, 0, 50, 50)];
    [_Msm setBackgroundImage:[UIImage imageNamed:@"Msm.PNG"] forState:UIControlStateNormal];
    [_Msm addTarget:self action:@selector(MsmBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Msm];
    
    _Wb = [[UIButton alloc] initWithFrame:CGRectMake(214, 0, 50, 50)];
    [_Wb setBackgroundImage:[UIImage imageNamed:@"Wb.PNG"] forState:UIControlStateNormal];
    [_Wb addTarget:self action:@selector(WbBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Wb];
        
        
        [UIView animateWithDuration:0.5 animations:^{
            _QQ.frame = CGRectMake(135,150, 50, 50);
            _Friend.frame = CGRectMake(35,250, 50, 50);
            _Msm.frame = CGRectMake(235, 250, 50, 50);
            _Wb.frame = CGRectMake(135, 350, 50, 50);
        }];
        
        MYTAB = YES;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _QQ.frame = CGRectMake(214, 0, 50, 50);
            _Friend.frame = CGRectMake(214, 0, 50, 50);
            _Msm.frame = CGRectMake(214, 0, 50, 50);
            _Wb.frame = CGRectMake(214, 0, 50, 50);
        }completion:^(BOOL finished){[self removeBut];}];

        
    }
    
}

-(void)GameBut
{
    NSLog(@"MyGameBut");
}

-(void)ShakeBut
{
    NSLog(@"MyShakeBut");
    
}
-(void)AdventureBut
{
     NSLog(@"MyAdventureBut");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     [self.navigationController setNavigationBarHidden:YES];
    _Background = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _Background.image = [UIImage imageNamed:@"BG.PNG"];
    [self.view addSubview:_Background];
    
    _Return = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 106, 42)];
    [_Return setBackgroundImage:[UIImage imageNamed:@"Return.PNG"] forState:UIControlStateNormal];
    [_Return addTarget:self action:@selector(ReturnBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Return];
    
    _Dice = [[UIButton alloc] initWithFrame:CGRectMake(107, 0, 106, 32)];
    [_Dice setBackgroundImage:[UIImage imageNamed:@"Dice.PNG"] forState:UIControlStateNormal];
    [_Dice addTarget:self action:@selector(DiceBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Dice];
    
    _Share = [[UIButton alloc] initWithFrame:CGRectMake(214, 0, 106, 42)];
    [_Share setBackgroundImage:[UIImage imageNamed:@"Share.PNG"] forState:UIControlStateNormal];
    [_Share addTarget:self action:@selector(ShareBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Share];
    
    _Game = [[UIButton alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height - 42, 106, 42)];
    [_Game setBackgroundImage:[UIImage imageNamed:@"Game.PNG"] forState:UIControlStateNormal];
    [_Game addTarget:self action:@selector(GameBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Game];
    
    _Shake = [[UIButton alloc] initWithFrame:CGRectMake(107,self.view.bounds.size.height - 32, 106, 32)];
    [_Shake setBackgroundImage:[UIImage imageNamed:@"Shake.PNG"] forState:UIControlStateNormal];
    [_Shake addTarget:self action:@selector(ShakeBut) forControlEvents:UIControlEventTouchUpInside];
    //[_Shake setShowsTouchWhenHighlighted:YES];
    //[_Shake setUserInteractionEnabled:NO];
    [self.view addSubview:_Shake];
    
    
    
    _Adventure = [[UIButton alloc] initWithFrame:CGRectMake(214,self.view.bounds.size.height - 42, 106, 42)];
    [_Adventure setBackgroundImage:[UIImage imageNamed:@"Adventure.PNG"] forState:UIControlStateNormal];
    [_Adventure addTarget:self action:@selector(AdventureBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Adventure];
    
    _Title12 = [[UILabel alloc] initWithFrame:CGRectMake(100, 60, 120, 30)];
    _Title12.backgroundColor = [UIColor clearColor];
    _Title12.text = @"人数：1";
    _Title12.textAlignment = NSTextAlignmentCenter;
    _Title12.textColor = [UIColor whiteColor];
    [self.view addSubview:_Title12];

    // Do any additional setup after loading the view.
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

@end
