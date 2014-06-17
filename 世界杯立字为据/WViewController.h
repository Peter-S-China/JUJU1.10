//
//  WViewController.h
//  JUJU
//
//  Created by linchuanbin on 14-5-12.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WViewController : UIViewController
{
    UIImageView * _BackImage;
    UIButton * _Return;
    UIButton * _Share;
    
    UIButton * _QQ;
    UIButton * _Friend;
    UIButton * _Msm;
    UIButton * _Wb;
    
   // enum WXScene _scene;
    
    UIImage * ShareImage;
}
@property (retain , nonatomic) UIImageView * BackImage;
@property (nonatomic, retain)UIButton * Return;
@property (nonatomic, retain)UIButton * Share;

@property (nonatomic, retain)UIButton * QQ;
@property (nonatomic, retain)UIButton * Friend;
@property (nonatomic, retain)UIButton * Msm;
@property (nonatomic, retain)UIButton * Wb;

@end
