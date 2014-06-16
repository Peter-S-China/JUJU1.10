//
//  OrganigerViewController.h
//  Dice
//
//  Created by linchuanbin on 14-4-30.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//  发起人

#import <UIKit/UIKit.h>



@interface OrganigerViewController : MyViewController<UIScrollViewDelegate,ASIHTTPRequestDelegate,ActivityViewDelegate,UIAlertViewDelegate,MyAlertVDelegate>
{
    UIImageView * _Number;
    UIImageView * _DiceBG;
    UIButton * _Confirm;
    UIButton * _Invitation;//邀请
    UIScrollView * _DiceNumber;
    
    
    
    
    UIImageView * _DiceImage[6];
    UIImageView * _Dicedong[6];
    CGPoint  pos[6];
    NSTimer * _chattime;//游戏时间计时器
    NSTimer * _SHUtime;//人数计时器。
    
    ActivityView *activityView;
    ASIFormDataRequest *upLoadRequest;   // 上传请求
    NSMutableArray * gameArray;//游戏结果
    NSMutableArray * InvitationArray;//邀请id
    

   
}




@end
