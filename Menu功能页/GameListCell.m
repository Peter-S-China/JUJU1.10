//
//  GameListCell.m
//  JUJU
//
//  Created by linchuanbin on 14-5-17.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "GameListCell.h"

@implementation GameListCell
@synthesize GameTubiao = _GameTubiao, GameTubiaoImage = _GameTubiaoImage, GameName = _GameName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _GameTubiao = [[UIButton alloc] initWithFrame:CGRectMake(15,0, 70, 70)];
        //[_GameTubiao addTarget:self action:@selector(GameTab:) forControlEvents:UIControlEventTouchUpInside];
        _GameTubiao.layer.cornerRadius = 35;
        //[_GameTubiao.layer setBorderWidth:1.0]; //边框宽度
        //[_GameTubiao.layer setBorderColor:[[UIColor grayColor] CGColor]];
        //imageView.layer.masksToBounds = YES;
        _GameTubiao.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_GameTubiao];
        
        _GameTubiaoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
        _GameTubiaoImage.layer.cornerRadius = 35.0;
        //[_GameTubiaoImage.layer setBorderWidth:1.0]; //边框宽度
        //[_GameTubiaoImage.layer setBorderColor:[[UIColor grayColor] CGColor]];
        _GameTubiaoImage.layer.masksToBounds = YES;
        _GameTubiaoImage.contentMode = UIViewContentModeScaleAspectFill;
        _GameTubiaoImage.image = [UIImage imageNamed:@"icon.png"];
        [_GameTubiao addSubview:_GameTubiaoImage];
        
        
        _GameName = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 100, 20)];
        _GameName.backgroundColor = [UIColor clearColor];
        _GameName.text = @"游戏名";
        _GameName.textAlignment = NSTextAlignmentCenter;
        _GameName.textColor = [UIColor grayColor];
        [self addSubview:_GameName];
        
        // Initialization code
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
