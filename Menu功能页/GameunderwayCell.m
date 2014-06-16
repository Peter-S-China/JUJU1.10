//
//  GameunderwayCell.m
//  JUJU
//
//  Created by linchuanbin on 14-5-17.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "GameunderwayCell.h"

@implementation GameunderwayCell

@synthesize GameTubiao = _GameTubiao, GameTubiaoImage = _GameTubiaoImage, GameName = _GameName,data = _data;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _GameTubiao = [[UIButton alloc] initWithFrame:CGRectMake(15,15, 50, 50)];
        //[_GameTubiao addTarget:self action:@selector(GameTab:) forControlEvents:UIControlEventTouchUpInside];
        _GameTubiao.layer.cornerRadius = 25;
        //[_GameTubiao.layer setBorderWidth:1.0]; //边框宽度
        //[_GameTubiao.layer setBorderColor:[[UIColor grayColor] CGColor]];
        //imageView.layer.masksToBounds = YES;
        _GameTubiao.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_GameTubiao];
        
        _GameTubiaoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _GameTubiaoImage.layer.cornerRadius = 25.0;
        //[_GameTubiaoImage.layer setBorderWidth:1.0]; //边框宽度
        //[_GameTubiaoImage.layer setBorderColor:[[UIColor grayColor] CGColor]];
        _GameTubiaoImage.layer.masksToBounds = YES;
        _GameTubiaoImage.contentMode = UIViewContentModeScaleAspectFill;
        _GameTubiaoImage.image = [UIImage imageNamed:@"icon.png"];
        [_GameTubiao addSubview:_GameTubiaoImage];
        
        
        _GameName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 15)];
        _GameName.backgroundColor = [UIColor clearColor];
        _GameName.font = [UIFont boldSystemFontOfSize:10.0];
        _GameName.text = @"开心游戏";
        _GameName.textAlignment = NSTextAlignmentCenter;
        _GameName.textColor = [UIColor whiteColor];
        [self addSubview:_GameName];
        _data = [[NSMutableDictionary alloc] init];
        
        // Initialization code
    }
    return self;
}

-(NSMutableDictionary *)data
{
    return _data;
}

-(void)setData:(NSMutableDictionary *)data
{
    if(_data != data)
    {
        _data = data;
        //ImageView.image = [UIImage imageNamed:@"defult.png"];
        NSLog(@"Game DAT1A = %@",_data);
    }
}


//-(void)gestureRecognizerHandle:(UILongPressGestureRecognizer *)longPress
//{
//    NSLog(@"tagqqqq = %d",_GameTubiao.tag);
//    NSLog(@"Game DATA = %@",_data);
//    
//
//    //ident =  RQIdentifierForExitgamehome;
//     NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
//    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:ExitgamehomeURL]];
//    [upLoadRequest setPostValue:[_data objectForKey:@"id"] forKey:@"id"];
//    [upLoadRequest setPostValue:[_data objectForKey:@"tablenum"]  forKey:@"gamehomenum"];
//    [upLoadRequest setPostValue:[[defaults objectForKey:@"Game_Name"] isEqualToString:[_data objectForKey:@"username"]]? @"1":@"0" forKey:@"gameuserid"];
//
//    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
//    upLoadRequest.delegate = self;
//    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
//    
//    [upLoadRequest startAsynchronous];
//    
//}

//-------------上传信息-------------

#pragma mark - ASIHttpDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    //反馈数据
    
    NSString *str = [request responseString];
    NSLog(@" 退出 游戏 = %@",str);
}

//上传失败
- (void)upLoadFailed:(ASIHTTPRequest *)request
{
    //[activityView hidden];
    //    MyAlertView *alert = [[MyAlertView alloc] initWithTitle:@"提示" contentText:@"加入游戏失败！" leftButtonTitle:nil rightButtonTitle:nil addkAlertHeight:100.0];
    //    [alert show];
    
    // [alert release];
    
    NSString *str = [request responseString];
    NSLog(@"str = %@",str);
}
//-(void)GameTab:(UIButton * )but
//{
//    NSLog(@"GameTab%d",but.tag);
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
