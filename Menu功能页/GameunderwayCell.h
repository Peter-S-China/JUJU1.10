//
//  GameunderwayCell.h
//  JUJU
//
//  Created by linchuanbin on 14-5-17.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameunderwayCell : UIView
{
    UIButton * _GameTubiao;
    UIImageView * _GameTubiaoImage;
    UILabel * _GameName;
    NSMutableDictionary * _data;
    ASIFormDataRequest *upLoadRequest;//RQIdentifierForExitgamehome
}
@property (nonatomic, retain)UIButton * GameTubiao;
@property (nonatomic, retain)UIImageView * GameTubiaoImage;
@property (nonatomic, retain)UILabel * GameName;
@property (nonatomic, retain)NSMutableDictionary * data;

@end
