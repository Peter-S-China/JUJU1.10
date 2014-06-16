//
//  LandViewController.h
//  JUJU
//
//  Created by linchuanbin on 14-4-24.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassImageDelegate.h"
#import "CaptureViewController.h"
#import "EGOImageView.h"


@interface LandViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,ASIHTTPRequestDelegate,ActivityViewDelegate,PassImageDelegate,UIActionSheetDelegate>
{
    UIImageView * _backImage;
    
    UITextField * _Username;
    UITextField * _Password;
    UIButton * _LoginBut;
    UIButton * _GainBut;
    
    ActivityView *activityView;
    ASIFormDataRequest *upLoadRequest;   // 上传请求
    //NSMutableDictionary * uoLoadList;//上传数据
    
    EGOImageView * addimageV;


}
@property (retain , nonatomic) UIImageView * BackImage;
@property (retain , nonatomic) UITextField * Username;
@property (retain , nonatomic) UITextField * Password;
@property (retain , nonatomic) UIButton * LoginBut;
@property (retain , nonatomic) UIButton * GainBut;

@end
