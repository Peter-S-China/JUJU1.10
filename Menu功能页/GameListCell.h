//
//  GameListCell.h
//  JUJU
//
//  Created by linchuanbin on 14-5-17.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameListCell : UIView
{
    UIButton * _GameTubiao;
    UIImageView * _GameTubiaoImage;
    UILabel * _GameName;
}
@property (nonatomic, retain)UIButton * GameTubiao;
@property (nonatomic, retain)UIImageView * GameTubiaoImage;
@property (nonatomic, retain)UILabel * GameName;

@end
