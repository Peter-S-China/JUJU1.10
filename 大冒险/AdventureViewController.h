//
//  AdventureViewController.h
//  JUJU
//
//  Created by linchuanbin on 14-5-19.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdventureViewController : UIViewController
{
    UIImageView * _BackImage;
    UIImageView * _DoorImage;
    

    UIButton * _Return;
    UIButton * _Share;
    UIButton * _Single;
    UIButton * _Online;
    
    
    UIButton * _QQ;
    UIButton * _Friend;
    UIButton * _Msm;
    UIButton * _Wb;
    UIImageView * imageM;
    UIImageView * imageM1;
    
    
    
}

@property (nonatomic, retain) UIImageView * BackImage;
@property (nonatomic, retain) UIImageView * DoorImage;
@property (nonatomic, retain)UIButton * Return;
@property (nonatomic, retain)UIButton * Share;

@property (nonatomic, retain)UIButton * QQ;
@property (nonatomic, retain)UIButton * Friend;
@property (nonatomic, retain)UIButton * Msm;
@property (nonatomic, retain)UIButton * Wb;
@property (nonatomic, retain)UIButton * Single;
@property (nonatomic, retain)UIButton * Online;


@end
