//
//  FlowerViewController.h
//  JUJU
//
//  Created by linchuanbin on 14-5-8.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlowerViewController : UIViewController
{
    UIImageView * _BackImage;
    UIButton * _Return;
    UIButton * _Flower;
    UIButton * _Share;
    UIButton * _Button;
    UIButton * _Adventure;
    
    UIButton * _QQ;
    UIButton * _Friend;
    UIButton * _Msm;
    UIButton * _Wb;
    
    UIImageView * _flowerV;
    
    UIImageView * _FcloudBGV;
    
    UIImageView * _FradiationBG;
}
@property (retain , nonatomic) UIImageView * BackImage;
@property (nonatomic, retain)UIButton * Return;
@property (nonatomic, retain)UIButton * Flower;
@property (nonatomic, retain)UIButton * Share;
@property (nonatomic, retain)UIButton * Button;
@property (nonatomic, retain)UIButton * Adventure;

@property (nonatomic, retain)UIButton * QQ;
@property (nonatomic, retain)UIButton * Friend;
@property (nonatomic, retain)UIButton * Msm;
@property (nonatomic, retain)UIButton * Wb;

@property (nonatomic, retain)UIImageView * flowerV;
@end
