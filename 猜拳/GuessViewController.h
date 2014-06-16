//
//  GuessViewController.h
//  JUJU
//
//  Created by linchuanbin on 14-5-21.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuessViewController : UIViewController
{
    UIImageView * _BackImage;
    UIImageView * _BackdownImage;
    UIImageView * _BackCenterImage;
    
    UIButton * _Return;
    UIButton * _Share;
  
    
    
    UIButton * _QQ;
    UIButton * _Friend;
    UIButton * _Msm;
    UIButton * _Wb;
    
    UIImageView * BGImage[5];
    
    UIButton * MyButon[5];

}


@property (nonatomic, retain) UIImageView * BackImage;
@property (nonatomic, retain) UIImageView * BackCenterImage;
@property (nonatomic, retain)UIButton * Return;
@property (nonatomic, retain)UIButton * Share;

@property (nonatomic, retain)UIButton * QQ;
@property (nonatomic, retain)UIButton * Friend;
@property (nonatomic, retain)UIButton * Msm;
@property (nonatomic, retain)UIButton * Wb;
//@property (nonatomic, retain)UIButton * Single;
//@property (nonatomic, retain)UIButton * Online;
@end
