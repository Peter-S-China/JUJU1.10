//
//  LandViewController.m
//  JUJU
//
//  Created by linchuanbin on 14-4-24.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "LandViewController.h"
#import "MenuViewController.h"//主页

@interface LandViewController ()

@end

@implementation LandViewController

@synthesize  BackImage = _BackImage, Username = _Username, Password = _Password, LoginBut = _LoginBut, GainBut = _GainBut;

static RQIdflower ident;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
       
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:YES];
     NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    if([[defaults objectForKey:@"_Username"] intValue] == 1)
    {
        [self addVIEW];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [upLoadRequest clearDelegatesAndCancel];
    /*
     如果不想调用delegate方法，则设置：[ request clearDelegatesAndCancel];
     队列请求中需要注意的是，如果你取消了一个请求，队列会自动取消其它所有请求。如果只想取消一个请求，可以设置队列：[ queue setShouldCancelAllRequestsOnFailure:NO ]; 如果想明确取消所有请求：[ queue cancelAllOperations ];
     安全的内存回收建议
     */
    
    [super viewDidDisappear:animated];
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)imageViewbut
{
    NSLog(@"改变图片");
    UIActionSheet *chooseImageSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"返回" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    [chooseImageSheet showInView:self.view];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"LandviewDidLoad");
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
        
    {
        
        [self prefersStatusBarHidden];
        
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];//隐藏状态栏
        
    }
    
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"1" forKey:@"_GmaeName"];
    [defaults synchronize];
    NSLog(@"_Username = %@",[defaults objectForKey:@"_Username"]);
    if([[defaults objectForKey:@"_Username"] length] > 2)
    {
        NSLog(@"保持 ＝ ＝登录成功");
        MenuViewController * MenuV = [[MenuViewController alloc] init];
        [self.navigationController pushViewController:MenuV animated:YES];
        
    }else{
        [self addVIEW];
    }


    
    

    
    // Do any additional setup after loading the view.
}

-(void )addVIEW
{
    _BackImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _BackImage.image = [UIImage imageNamed:@"LandVBG.png"];
    _BackImage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_BackImage];
    
    
    UIButton * imageView = [[UIButton alloc] initWithFrame:CGRectMake(120,20, 80, 80)];
    addimageV = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"Radar.png"]];
    addimageV.frame = CGRectMake(0, 0, 80,80);
    addimageV.layer.cornerRadius = 40;
    [imageView addSubview:addimageV];
    
    //imageView.backgroundColor = [UIColor blackColor];
    //imageView.image = [UIImage imageNamed:@"Radar.png"];
    //[imageView setBackgroundImage:[UIImage imageNamed:@"Radar.png"] forState:UIControlStateNormal];
    [imageView addTarget:self action:@selector(imageViewbut) forControlEvents:UIControlEventTouchUpInside];
    imageView.layer.cornerRadius = 40;
    [imageView.layer setBorderWidth:1.0]; //边框宽度
    [imageView.layer setBorderColor:[[UIColor grayColor] CGColor]];
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
    _Username = [[UITextField alloc] initWithFrame:CGRectMake(62, 120, 196, 40)];
    _Username.backgroundColor = [UIColor clearColor];
    [_Username setBorderStyle:UITextBorderStyleNone];
    _Username.font = [UIFont fontWithName:@"Heiti SC" size:15];
    _Username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _Username.returnKeyType = UIReturnKeyDone;//键盘
    _Username.keyboardType = UIKeyboardTypeDefault;
    _Username.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [_Username setTextAlignment:NSTextAlignmentLeft];//水平居左
    _Username.clearButtonMode = UITextFieldViewModeWhileEditing;
    _Username.placeholder = @"用户名";
    //_Username.text = @"用户名";
    _Username.textColor =  TextColor;
    _Username.delegate = self;
    //[_Username setBackground:[UIImage imageNamed:@"long.PNG"]];
    [self.view addSubview:_Username];
    
    UIImageView * ImageV =[[UIImageView alloc] initWithFrame:CGRectMake(60, 120, 200, 42)];
    ImageV.image = [UIImage imageNamed:@"long.PNG"];
    [self.view addSubview:ImageV];
    
    _Password = [[UITextField alloc] initWithFrame:CGRectMake(62, 180,96, 40)];
    [_Password setBorderStyle:UITextBorderStyleNone];
    //UITextBorderStyleRoundedRect];
    _Password.placeholder = @"验证码";
    //_Password.text = @"密码";
    _Password.tag = 100;
    _Password.font = [UIFont fontWithName:@"Heiti SC" size:15];
    _Password.autocapitalizationType = UITextAutocapitalizationTypeNone;//首字母是否大写
    _Password.returnKeyType = UIReturnKeyDone;//键盘返回类型
    _Password.textAlignment = NSTextAlignmentLeft;//水平居中
    _Password.keyboardType = UIKeyboardTypeDefault;
    _Password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _Password.clearButtonMode = UITextFieldViewModeWhileEditing;//不为空，且在编辑状态时（及获得焦点）显示清空按钮
    _Password.textColor =  TextColor;
    _Password.delegate = self;
    [self.view addSubview:_Password];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:_Username.text forKey:@"_Username"];//手机名
    [defaults setObject:_Password.text forKey:@"_Password"];//验证码
    if([defaults objectForKey:@"_Username"] != nil)
    {
        _Username.text =[defaults objectForKey:@"_Username"];
        //_Password.text = [defaults objectForKey:@"_Password"];
    }
    
    
    
    UIImageView * ImageV1 =[[UIImageView alloc] initWithFrame:CGRectMake(60, 180, 100, 42)];
    ImageV1.image = [UIImage imageNamed:@"short.PNG"];
    [self.view addSubview:ImageV1];
    
    
    _GainBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _GainBut.frame = CGRectMake(170,183, 75, 35);
    //    [_GainBut setTitle:@"获取验证码" forState:UIControlStateNormal];
    //    [_GainBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [_GainBut setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    [_GainBut setBackgroundImage:[UIImage imageNamed:@"gain.PNG"] forState:UIControlStateNormal];
    [_GainBut addTarget:self action:@selector(Gain:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_GainBut];
    
    
    _LoginBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _LoginBut.frame = CGRectMake(95,240, 130, 33);
    // [_LoginBut setTitle:@"登陆" forState:UIControlStateNormal];
    // [_LoginBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // [_LoginBut setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    [_LoginBut setBackgroundImage:[UIImage imageNamed:@"login.PNG"] forState:UIControlStateNormal];
    [_LoginBut addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_LoginBut];
    
    
    activityView = [[ActivityView alloc] initWithFrame:self.view.bounds];
    
    [activityView hidden];
    activityView.delegate = self;
    
    [self.view addSubview:activityView];
    
    if([[defaults objectForKey:@"NameHead"] length] > 10)
    {
        addimageV.image = [UIImage imageWithData: [defaults objectForKey:@"NameHead"]];
        NSLog(@"name = %@",[defaults objectForKey:@"_Username"]);
        _Username.text = [defaults objectForKey:@"_Username"];
    }

}

//------------------

-(void)Gain:(UIButton *)GainBut
{
    NSLog(@"获取验证码");
    [activityView show];
    
    ident = RQIdentifierForSendnum;
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SendnumURL]];
    
    
    [upLoadRequest setPostValue:_Username.text forKey:@"username"];//用户手机号
    [upLoadRequest addData:UIImageJPEGRepresentation(addimageV.image, 0.5) withFileName:@"temp.jpg" andContentType:@"image/jpeg" forKey:_Username.text];
    [upLoadRequest setTimeOutSeconds:10.f];//设置超时秒
    
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];
   
    
}
-(void)Login:(UIButton *)LoginBut
{
    [self resignFirstResponder];  // 回收键盘
    NSLog(@"登陆");
    
    if(_Username.text.length > 0 && _Password.text.length > 0)
    {
        [activityView show];
    ident = RQIdentifierForLoginservlet;
    upLoadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:LoginservletURL]];
    
    
    [upLoadRequest setPostValue:_Username.text forKey:@"username"];//用户手机号
    [upLoadRequest setPostValue:_Password.text forKey:@"codenum"];//验证码
    [upLoadRequest setTimeOutSeconds:5.f];//设置超时秒
    
    upLoadRequest.delegate = self;
    [upLoadRequest setDidFailSelector:@selector(upLoadFailed:)];
    
    [upLoadRequest startAsynchronous];
    }else
    {
        MyAlertView *alert = [[MyAlertView alloc] initWithTitle:@"提示" contentText:@"信息不可以为空！" leftButtonTitle:nil rightButtonTitle:nil addkAlertHeight:100.0];
        [alert show];
    }
    
}

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
//----------------------------
#pragma mark -TextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //textField.text = @"";
    //if(textField.tag == 100)
    //_Password.secureTextEntry = YES;
    //当开始点击textField会调用的方法
    //lView.frame = CGRectMake(0, Device_height/2 - 40 -70, Device_width,Device_height/2 + 40 );
    
}



-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //当textField编辑结束时调用的方法
    [textField resignFirstResponder];
    //lView.frame = CGRectMake(0, Device_height/2 - 40 , Device_width,Device_height/2 + 40 );
    
}
-(BOOL)textField:(UITextField *)field shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"textField 操作");
    if([field.placeholder isEqualToString:@"用户名"])
    {
        if(field.text.length < 11)
        {
            NSLog(@"231");
            _Password.text = nil;
        }
    }
    
    return YES;
}




//按下Done按钮的调用方法，我们让键盘消失

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}
//----------------------

//------------------

#pragma mark -   activityView.delegate代理方法 加载试图
- (void)CancelTab:(BOOL)tab
{
    NSLog(@"=%@=",tab ? @"YES":@"NO");//YES是放弃加载 NO是加载完成
    if(tab) [upLoadRequest clearDelegatesAndCancel];
        //[upLoadRequest cancel];//[netWork checkSimple];//取消加载
}

//-------------上传信息-------------

#pragma mark - ASIHttpDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    //反馈数据
    [activityView hidden];
    NSString *str = [request responseString];
    NSLog(@"return  = %@",str);
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    switch (ident) {
        case RQIdentifierForSendnum:
        {
            //获取验证码
            _Password.text = [dictionary objectForKey:@"result"];
            
        }
            break;
        case RQIdentifierForLoginservlet:
        {
            //登陆
            if(1 == [[dictionary objectForKey:@"loginresult"] intValue])
            {
                 NSLog(@"登录成功");
                
                NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                [defaults setObject:_Username.text forKey:@"_Username"];//手机名
                [defaults setObject:_Password.text forKey:@"_Password"];//验证码
                [defaults setObject:[dictionary objectForKey:@"id"] forKey:@"_userID"];
                [defaults setObject:UIImagePNGRepresentation(addimageV.image) forKey:@"NameHead"];
                [defaults synchronize];//用synchronize方法把数据持久化到standardUserDefaults数据库
                NSLog(@"_Usernameqewqe = %@ ",[defaults objectForKey:@"_Username"]);
                MenuViewController * MenuV = [[MenuViewController alloc] init];
                [self.navigationController pushViewController:MenuV animated:YES];

            }
        }
            break;
        default:
            break;
    }
        
    
    
NSLog(@"dictionary = %@  ,%@",dictionary,[dictionary objectForKey:@"error"]);
    
}

//上传失败
- (void)upLoadFailed:(ASIHTTPRequest *)request
{
    [activityView hidden];
    MyAlertView *alert = [[MyAlertView alloc] initWithTitle:@"提示" contentText:@"获取验证码失败！" leftButtonTitle:nil rightButtonTitle:nil addkAlertHeight:100.0];
    [alert show];

   // [alert release];
    
    NSString *str = [request responseString];
    NSLog(@"str = %@",str);
}



//-=--------------------------


//-------------------------------------

#pragma mark UIActionSheetDelegate Method
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
   
        switch (buttonIndex) {
            case 0://Take picture
                
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    
                }else{
                    NSLog(@"模拟器无法打开相机");
                }
                // [self presentModalViewController:picker animated:YES];
                [self presentViewController:picker animated:YES completion:nil];
                break;
                
            case 1://From album
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                //[self presentModalViewController:picker animated:YES];
                [self presentViewController:picker animated:YES completion:nil];
                break;
                
            default:
                
                break;
        }

}

#pragma 拍照选择照片协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    //路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSData *data;
    
    if ([mediaType isEqualToString:@"public.image"]){
        
        //切忌不可直接使用originImage，因为这是没有经过格式化的图片数据，可能会导致选择的图片颠倒或是失真等现象的发生，从UIImagePickerControllerOriginalImage中的Origin可以看出，很原始，哈哈
        UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        NSString *imageFile = [documentsDirectory stringByAppendingPathComponent:@"temp.jpg"];
        NSLog(@"%@",imageFile);
        
        [[PublicDictionary shareDictionary] setValue:imageFile forKey:@"imagePath"];//保存图片
        
        success = [fileManager fileExistsAtPath:imageFile];
        if(success) {
            success = [fileManager removeItemAtPath:imageFile error:&error];
        }
        
        // 将图片保存到本地
        [UIImageJPEGRepresentation(originImage, 1.0f) writeToFile:imageFile atomically:YES];
        
        // 将图片保存到相册
        //UIImageWriteToSavedPhotosAlbum([UIImage imageWithContentsOfFile:imageFile], nil, nil, nil);
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            UIImageWriteToSavedPhotosAlbum(originImage, nil, nil, nil);
        }
        
        
        //图片压缩，因为原图都是很大的，不必要传原图
        UIImage *scaleImage = [self scaleImage:originImage toScale:0.3];
        
        //以下这两步都是比较耗时的操作，最好开一个HUD提示用户，这样体验会好些，不至于阻塞界面
        if (UIImagePNGRepresentation(scaleImage) == nil) {
            //将图片转换为JPG格式的二进制数据
            NSLog(@"将图片转换为JPG格式的二进制数据");
            data = UIImageJPEGRepresentation(scaleImage, 1);
        } else {
            //将图片转换为PNG格式的二进制数据
             NSLog(@"将图片转换为PNG格式的二进制数据");
            data = UIImagePNGRepresentation(scaleImage);
        }
        
        
        
        
        //将二进制数据生成UIImage
        UIImage *image = [UIImage imageWithData:data];
        
        //将图片传递给截取界面进行截取并设置回调方法（协议）
        CaptureViewController *captureView = [[CaptureViewController alloc] init];
        captureView.delegate = self;
        captureView.image = image;
        //隐藏UIImagePickerController本身的导航栏
        picker.navigationBar.hidden = YES;
        [picker pushViewController:captureView animated:YES];
        
    }
}


#pragma mark - 图片回传协议方法
-(void)passImage:(UIImage *)image
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    addimageV.image = image;
    
   // NSLog(@"y = %f,h = %f",backV.bounds.origin.y,backV.bounds.size.height);
    
}

#pragma mark- 缩放图片
-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}



@end
