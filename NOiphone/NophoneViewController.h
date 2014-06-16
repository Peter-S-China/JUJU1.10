//
//  NophoneViewController.h
//  JUJU
//
//  Created by linchuanbin on 14-5-16.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NophoneViewController : UIViewController
{
    UIImageView * _BackImage;
    UIButton * _Return;
    UIButton * _Share;
    
    
    UIButton * _QQ;
    UIButton * _Friend;
    UIButton * _Msm;
    UIButton * _Wb;
    
    CALayer * _NavBackImage;//摇动的气球
    UIImageView * _GamebackImage;
    UIImageView * _GameopenImage;
    UIImageView * _GametimeImage;
    
    int time[6];
    UIView * _TimeView;
    
    NSTimer * GameNavtime;
    float                     angle;
    float                   timeInter;
}

@property (retain , nonatomic) UIImageView * BackImage;
@property (nonatomic, retain)UIButton * Return;
@property (nonatomic, retain)UIButton * Share;

@property (nonatomic, retain)UIButton * QQ;
@property (nonatomic, retain)UIButton * Friend;
@property (nonatomic, retain)UIButton * Msm;
@property (nonatomic, retain)UIButton * Wb;

@property (nonatomic, retain)UIImageView * GametimeImage;
@property (nonatomic, retain)UIImageView * GamebackImage;
@property (nonatomic, retain)UIImageView * GameopenImage;

@property (nonatomic, retain)UIView * TimeView;

@end
