//
//  AdventViewController.m
//  JUJU
//
//  Created by linchuanbin on 14-5-20.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "AdventViewController.h"

@interface AdventViewController ()

@end

@implementation AdventViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)SingleBut
{
    NSLog(@"单机");
    [_Single removeFromSuperview];
    [_Online removeFromSuperview];

    
     AVAudioPlayer * player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Stone" ofType:@"mp3"]] error:nil];
    [player play];
    

    
    [self OpenBut];
    UIButton * Open = [[UIButton alloc] initWithFrame:CGRectMake(124,self.view.bounds.size.height - 100,72, 42)];
    [Open setBackgroundImage:[UIImage imageNamed:@"AopenA.PNG"] forState:UIControlStateNormal];
    [Open addTarget:self action:@selector(OpenBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Open];
}

-(void)OnlineBut
{
    NSLog(@"联机");
    [_Single removeFromSuperview];
    [_Online removeFromSuperview];
}
-(void)OpenBut
{
    static SystemSoundID soundIDTest = 0;
    
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"Door" ofType:@"wav"];//音频
    CFURLRef dropURL = (__bridge CFURLRef)[NSURL fileURLWithPath:path];
    //AudioServicesCreateSystemSoundID ((__bridge CFURLRef) alertSound, &soundFileObject);
    //或
    //AudioServicesCreateSystemSoundID ((CFURLRef) CFBridgingRetain(alertSound), &soundFileObject);
    // OSStatus status = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundIDTest); NSLog(@"AudioServicesCreateSystemSoundID status = %d", status);
    
    if (path) {
        AudioServicesCreateSystemSoundID(dropURL, &soundIDTest);
    }
    
    AudioServicesPlaySystemSound(soundIDTest);

    
    [UIView animateWithDuration:2 animations:^{
        _DoorImage.frame = CGRectMake(0,568,320,568);
        imageM.frame = CGRectMake(320,0,320,568);
        imageM1.frame = CGRectMake(-320, 0,320,568);
    }completion:^(BOOL finished){
        upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SingleadventureURL]];
        //[upLoadRequest setPostValue:usergamehomenum forKey:@"gamehomenum"];//桌名
        
        [upLoadRequest setTimeOutSeconds:10.f];//设置超时秒
        
        upLoadRequest.delegate = self;
        [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
        [upLoadRequest startAsynchronous];
    }];
    
}


//-------------上传信息-------------

#pragma mark - ASIHttpDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    //反馈数据
    //[activityView hidden];
    
    [title removeFromSuperview];
    [content removeFromSuperview];
    
    NSString *str = [request responseString];
    NSLog(@"用户信息 = %@",str);
     NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    title = [[UITextView alloc] initWithFrame:CGRectMake(80, 185, 160, 40)];
    title.font = [UIFont fontWithName:@"Arial" size:18.0];//设置字体名字和字体大小
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentCenter;
    //title.scrollEnabled = YES;//是否可以拖动
    title.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    title.editable = NO;
   content = [[UITextView alloc] initWithFrame:CGRectMake(80, 265, 160, 40)];
    content.font = [UIFont fontWithName:@"Arial" size:18.0];//设置字体名字和字体大小
    content.scrollEnabled = YES;//是否可以拖动
    content.backgroundColor = [UIColor clearColor];
    content.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    content.editable = NO;
    
    title.text = [dictionary objectForKey:@"title"];
    content.text = [dictionary objectForKey:@"content"];
    
    [self.view addSubview:title];
    [self.view addSubview:content];
    
   
}

//上传失败
- (void)upLoadFailed:(ASIHTTPRequest *)request
{
    //  [activityView hidden];
    //  MyAlertView *alert = [[MyAlertView alloc] initWithTitle:@"提示" contentText:@"加入游戏失败！" leftButtonTitle:nil rightButtonTitle:nil addkAlertHeight:100.0];
    //  [alert show];
    //
    //  [alert release];
    
    NSString *str = [request responseString];
    NSLog(@"加载dice结果str = %@",str);
}


-(void)ReturnBut
{
    NSLog(@"MyReturn");
    
    [UIView animateWithDuration:2 animations:^{
        [title removeFromSuperview];
        [content removeFromSuperview];
        _DoorImage.frame = CGRectMake(0,0,320,568);
        imageM.frame = CGRectMake(0,0,320,568);
        imageM1.frame = CGRectMake(0, 0,320,568);
    }completion:^(BOOL finished){
        [self.navigationController popViewControllerAnimated:YES];//返回上级
    }];
    
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
