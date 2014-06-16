//
//  WNamelistViewController.m
//  JUJU
//
//  Created by linchuanbin on 14-6-5.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "WNamelistViewController.h"

@interface WNamelistViewController ()

@end

@implementation WNamelistViewController

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
    
    _TitleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 26)];
    _TitleImage.backgroundColor = [UIColor clearColor];
    _TitleImage.image = [UIImage imageNamed:@"WorldCupzhu.PNG"];
    [self.view addSubview:_TitleImage];
    _Image_view = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"icon.png"]];
    _Image_view.frame = CGRectMake(80, 3, 20, 20);
    _Image_view.clipsToBounds = YES;
    //_Image_view.userInteractionEnabled = YES;
    _Image_view.layer.cornerRadius = 10;
    //[_Image_view.layer setBorderWidth:1.0]; //边框宽度
    //[_Image_view.layer setBorderColor:[[UIColor blackColor] CGColor]];
    _Image_view.backgroundColor = [UIColor clearColor];
    [_TitleImage addSubview:_Image_view];
    
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSLog(@"Wlist = %@",[defaults objectForKey:@"Wlist"]);
    _Image_view.imageURL = [NSURL URLWithString:[[defaults objectForKey:@"Wlist"] objectAtIndex:1]];

    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(100, 3, 120, 20)];
    title.text = [NSString stringWithFormat:@"%@队名单",[[defaults objectForKey:@"Wlist"] objectAtIndex:0],nil];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor grayColor];
    title.backgroundColor = [UIColor clearColor];
    title.font = [UIFont systemFontOfSize:15.0];
    [_TitleImage addSubview:title];
    
    NSString * teamperson = [[defaults objectForKey:@"Wlist"] objectAtIndex:2];
    NSLog(@"teamperson = %@",teamperson);
    NSArray *array = [teamperson componentsSeparatedByString:@"."];
    NSLog(@"array:%@",array);
    
    
    int i = 0,H = 0;
    for(NSString * str in array)
    {
        NSArray * shuarray = [str componentsSeparatedByString:@","];
        UIImageView * GoalkeeperV = [[UIImageView alloc] initWithFrame:CGRectMake(15 , 80 + H + 30*i, 290, 20+ 15*([shuarray count]-1))];
        GoalkeeperV.layer.cornerRadius = 6.0;
        GoalkeeperV.backgroundColor = UIColorFromRGB(0x333333);
        [self.view addSubview:GoalkeeperV];
        
        for(int i = 0; i < [shuarray count]; i++)
        {
            [GoalkeeperV addSubview:[self addArray:[shuarray objectAtIndex:i] addTAB:i == 0?YES:NO addShu:i]];
        }
           H +=15*([shuarray count]-1);
        i++;
    }
    
    
    // Do any additional setup after loading the view.
}

-(UILabel *)addArray:(NSString *)Name  addTAB:(BOOL)TAb addShu:(int)N
{
    UILabel * Namet = [[UILabel alloc] init];
    if(TAb)
        Namet.frame = CGRectMake(10, 10, 80, 15);
    else
    {
        Namet.frame = CGRectMake(140,10 + (N - 1)*15,140, 15);
    }
    Namet.textColor = [UIColor whiteColor];
    Namet.textAlignment = NSTextAlignmentCenter;
    Namet.font = [UIFont systemFontOfSize:12.0];
    Namet.text = Name;
    
    return Namet;
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

@end
