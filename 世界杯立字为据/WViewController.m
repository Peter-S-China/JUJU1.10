//
//  WViewController.m
//  JUJU
//
//  Created by linchuanbin on 14-5-12.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "WViewController.h"

@interface WViewController ()

@end

@implementation WViewController

@synthesize BackImage = _BackImage, Return = _Return, Share = _Share;

static bool WViewTAB = NO;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
            
        {
            
            [self prefersStatusBarHidden];
            
            [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];//隐藏状态栏
            
        }
    }
    return self;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
     
    
    _BackImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _BackImage.image = [UIImage imageNamed:@"WBG.png"];
    [self.view addSubview:_BackImage];
    
    UIImageView * dhV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    dhV.image = [UIImage imageNamed:@"WdhBG.PNG"];
    [self.view addSubview:dhV];
    
    
    _Return = [[UIButton alloc] initWithFrame:CGRectMake(0,0.5,42.5, 42.5)];
    [_Return setBackgroundImage:[UIImage imageNamed:@"Wreturn.PNG"] forState:UIControlStateNormal];
    [_Return addTarget:self action:@selector(ReturnBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Return];
    
    
    
    _Share = [[UIButton alloc] initWithFrame:CGRectMake(277.5,0.5,42.5, 42.5)];
    [_Share setBackgroundImage:[UIImage imageNamed:@"Wshare.PNG"] forState:UIControlStateNormal];
    [_Share addTarget:self action:@selector(ShareBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Share];

    
    // Do any additional setup after loading the view.
}

//------------------------
-(void)ReturnBut
{
    NSLog(@"ReturnBut");
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: ([self.navigationController.viewControllers count] -2)] animated:YES];
}
-(void)ShareBut
{
    
    NSLog(@"MyShareBut");
    if(!WViewTAB)
    {
        _QQ = [[UIButton alloc] initWithFrame:CGRectMake(135, -50, 50, 50)];
        [_QQ setBackgroundImage:[UIImage imageNamed:@"QQ.PNG"] forState:UIControlStateNormal];
        [_QQ addTarget:self action:@selector(QQBut) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_QQ];
        
        _Friend = [[UIButton alloc] initWithFrame:CGRectMake(135, -50, 50, 50)];
        [_Friend setBackgroundImage:[UIImage imageNamed:@"Friend.PNG"] forState:UIControlStateNormal];
        [_Friend addTarget:self action:@selector(FriendBut) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_Friend];
        
        _Msm = [[UIButton alloc] initWithFrame:CGRectMake(135, -50, 50, 50)];
        [_Msm setBackgroundImage:[UIImage imageNamed:@"Msm.PNG"] forState:UIControlStateNormal];
        [_Msm addTarget:self action:@selector(MsmBut) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_Msm];
        
        _Wb = [[UIButton alloc] initWithFrame:CGRectMake(135, -50, 50, 50)];
        [_Wb setBackgroundImage:[UIImage imageNamed:@"Wb.PNG"] forState:UIControlStateNormal];
        [_Wb addTarget:self action:@selector(WbBut) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_Wb];
        
        
        [UIView animateWithDuration:0.5 animations:^{
            _QQ.frame = CGRectMake(135,150, 50, 50);
            _Friend.frame = CGRectMake(35,250, 50, 50);
            _Msm.frame = CGRectMake(235, 250, 50, 50);
            _Wb.frame = CGRectMake(135, 350, 50, 50);
        }];
        
        WViewTAB = YES;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _QQ.frame = CGRectMake(214, 0, 50, 50);
            _Friend.frame = CGRectMake(214, 0, 50, 50);
            _Msm.frame = CGRectMake(214, 0, 50, 50);
            _Wb.frame = CGRectMake(214, 0, 50, 50);
        }completion:^(BOOL finished){[self removeBut];}];
        
        
    }
    
    
}
//----------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//--------------------------

-(void)QQBut
{
    NSLog(@"MYQQBut");
    [self removeBut];
    
    UIGraphicsBeginImageContext(self.view.frame.size); //currentView 当前的view
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    ShareImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //viewImage就是获取的截图，如果要将图片存入相册，只需在后面调用
    UIImageWriteToSavedPhotosAlbum(ShareImage,nil,nil,nil);
    
    //[self sendImageContent];
}

-(void)FriendBut
{

    NSLog(@"MyFriendBut");
    [self removeBut];
    
    UIGraphicsBeginImageContext(self.view.frame.size); //currentView 当前的view
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    ShareImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //viewImage就是获取的截图，如果要将图片存入相册，只需在后面调用
    //UIImageWriteToSavedPhotosAlbum(ShareImage,nil,nil,nil);
}

-(void)MsmBut
{
    
    NSLog(@"MyMsmBut");
    [self removeBut];
    UIGraphicsBeginImageContext(self.view.frame.size); //currentView 当前的view
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    ShareImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //viewImage就是获取的截图，如果要将图片存入相册，只需在后面调用
    //UIImageWriteToSavedPhotosAlbum(ShareImage,nil,nil,nil);
    
    [self changeScene:WXSceneTimeline];
    [self sendImageContent];
}

-(void)WbBut
{
    
    NSLog(@"MyWbBut");
    [self removeBut];
    UIGraphicsBeginImageContext(self.view.frame.size); //currentView 当前的view
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    ShareImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //viewImage就是获取的截图，如果要将图片存入相册，只需在后面调用
    //UIImageWriteToSavedPhotosAlbum(ShareImage,nil,nil,nil);
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];

    WBMessageObject *message = [WBMessageObject message];
    //message.text = @"测试通过WeiboSDK发送文字到微博!";

//    WBImageObject *image = [WBImageObject object];
//    image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_1" ofType:@"jpg"]];
//    message.imageObject = image;

    
    WBProvideMessageForWeiboResponse *response = [WBProvideMessageForWeiboResponse responseWithMessage:message];
    
    if ([WeiboSDK sendResponse:response])
    {
        [self dismissModalViewControllerAnimated:YES];
    }

    
}
-(void)removeBut
{
    [_QQ removeFromSuperview];
    [_Friend removeFromSuperview];
    [_Msm removeFromSuperview];
    [_Wb removeFromSuperview];
    WViewTAB = NO;
}
//------------------------


-(void) changeScene:(NSInteger)scene
{
    _scene = scene;
}

- (void) sendImageContent
{
    WXMediaMessage *message = [WXMediaMessage message];
    
    [message setThumbImage:ShareImage];
    WXImageObject *ext = [WXImageObject object];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"WBG" ofType:@"png"];
    NSLog(@"filepath :%@",filePath);
    ext.imageData = [NSData dataWithContentsOfFile:filePath];
    
    //UIImage* image = [UIImage imageWithContentsOfFile:filePath];
    UIImage* image = [UIImage imageWithData:ext.imageData];
    ext.imageData = UIImagePNGRepresentation(ShareImage);
    
    
    //    UIImage* image = [UIImage imageNamed:@"res5thumb.png"];
    //    ext.imageData = UIImagePNGRepresentation(image);
    
    message.mediaObject = ext;
    //message.title = @"聚聚游戏平台";
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;
    
    [WXApi sendReq:req];
}


-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
}




@end
