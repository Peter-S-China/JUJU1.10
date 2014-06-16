//
//  ParticipantViewController.h
//  Dice
//
//  Created by linchuanbin on 14-4-30.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//  参与者

#import <UIKit/UIKit.h>

@interface ParticipantViewController : MyViewController<UIAlertViewDelegate>
{
    UIImageView * _DiceImage[6];
    UIImageView * _Dicedong[6];
    CGPoint  pos[6];
    UILabel * _GameOpen;
    NSTimer * _chattime;
   // NSTimer * _SHUtime;//人数计时器。
    
    ActivityView *activityView;
    ASIFormDataRequest *upLoadRequest;   // 上传请求
    
    NSMutableArray * gameArray;

}

@end
