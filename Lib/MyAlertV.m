//
//  MyAlertV.m
//  LoginFrame
//
//  Created by liuxuxing on 14-3-5.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "MyAlertV.h"
#import "PublishCell.h"

#import <QuartzCore/QuartzCore.h>



#define kAlertWidth 285.0f
#define kAlertHeight 350.0f

@interface MyAlertV ()
{
    BOOL _leftLeave;
    UITableView * tableV;
    NSMutableArray * array;
    NSMutableArray * InTdata;
    BOOL TABB;
}

@property (nonatomic, strong) UILabel *alertTitleLabel;
//@property (nonatomic, strong) UITextView *alertContentLabel;
//@property (nonatomic, strong) UITableView * tableV;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *backImageView;

@end

@implementation MyAlertV

+ (CGFloat)alertWidth
{
    return kAlertWidth;
}

+ (CGFloat)alertHeight
{
    return kAlertHeight;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//static int TABBB = 1000;
#define kTitleYOffset 15.0f
#define kTitleHeight 25.0f

#define kContentOffset 30.0f
#define kBetweenLabelOffset 20.0f

- (id)initWithTitle:(NSString *)title
        contentArray:(NSArray *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle
addTAB:(BOOL)MTAB
{
    //TABBB = tab;
    TABB = MTAB;
    array = [[NSMutableArray alloc] init];
    InTdata = [[NSMutableArray alloc] init];
    [array addObjectsFromArray:content];
    
    for(int i = 0;i < [array count];i++)
    {
        NSArray * ttArray = [array objectAtIndex:i];
        if([ttArray count] >2)
        {
        if([[ttArray objectAtIndex:2] isEqualToString:@"1"])
        {
            [InTdata addObject:[NSString stringWithFormat:@"%d",i]];
        }
        }
    }
    
    NSLog(@"array= %@",array);
    if (self = [super init]) {
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = [UIColor whiteColor];
        self.alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kTitleYOffset, kAlertWidth, kTitleHeight)];
        self.alertTitleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        self.alertTitleLabel.textColor = [UIColor colorWithRed:56.0/255.0 green:64.0/255.0 blue:71.0/255.0 alpha:1];
        [self addSubview:self.alertTitleLabel];
        
        CGFloat contentLabelWidth = kAlertWidth - 16;
        tableV = [[UITableView alloc]initWithFrame:CGRectMake((kAlertWidth - contentLabelWidth) * 0.5, CGRectGetMaxY(self.alertTitleLabel.frame), contentLabelWidth,kAlertHeight - kTitleHeight-80)];
        
        tableV.backgroundColor = [UIColor whiteColor];
        tableV.separatorStyle = UITableViewCellSeparatorStyleNone;//去除边框
        tableV.dataSource = self;
        tableV.delegate = self;
        [self addSubview:tableV];
        NSLog(@"addView");
   //     self.alertContentLabel = [[UITextView alloc] initWithFrame:CGRectMake((kAlertWidth - contentLabelWidth) * 0.5, CGRectGetMaxY(self.alertTitleLabel.frame), contentLabelWidth,70)];
        //[self.alertContentLabel addSubview:];
   //    self.alertContentLabel.editable = NO;
   //   self.alertContentLabel.scrollEnabled = NO;//禁止滚动
        //self.alertContentLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        //---------------------
        //        CGSize maxSize = CGSizeMake(contentLabelWidth, 60*3);
        //        CGSize labelSize = [content sizeWithFont:self.alertContentLabel.font constrainedToSize:maxSize lineBreakMode: UILineBreakModeTailTruncation];
        //
        //         self.alertContentLabel.frame = CGRectMake(self.alertContentLabel.frame.origin.x, self.alertContentLabel.frame.origin.y, labelSize.width, labelSize.height);
        //---------------------
        //self.alertContentLabel.numberOfLines = 0;
        
   //     self.alertContentLabel.textAlignment =  NSTextAlignmentLeft;
        self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
   //     self.alertContentLabel.textColor = [UIColor colorWithRed:56.0/255.0 green:64.0/255.0 blue:71.0/255.0 alpha:1];
        //[UIColor colorWithRed:127.0/255.0 green:127.0/255.0 blue:127.0/255.0 alpha:1];
   //     self.alertContentLabel.font = [UIFont systemFontOfSize:15.0f];
   //     [self addSubview:self.alertContentLabel];
        
        CGRect leftBtnFrame;
        CGRect rightBtnFrame;
#define kSingleButtonWidth 160.0f
#define kCoupleButtonWidth 107.0f
#define kButtonHeight 40.0f
#define kButtonBottomOffset 10.0f
        
        if(!leftTitle && !rigthTitle)
        {
            
        }else if (!leftTitle) {
            rightBtnFrame = CGRectMake((kAlertWidth - kSingleButtonWidth) * 0.5, kAlertHeight - kButtonBottomOffset - kButtonHeight, kSingleButtonWidth, kButtonHeight);
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightBtn.frame = rightBtnFrame;
            
        }else {
            leftBtnFrame = CGRectMake((kAlertWidth - 2 * kCoupleButtonWidth - kButtonBottomOffset) * 0.5, kAlertHeight - kButtonBottomOffset - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
            rightBtnFrame = CGRectMake(CGRectGetMaxX(leftBtnFrame) + kButtonBottomOffset, kAlertHeight - kButtonBottomOffset - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
            self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.leftBtn.frame = leftBtnFrame;
            self.rightBtn.frame = rightBtnFrame;
        }
        
        [self.rightBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x2792ff)] forState:UIControlStateNormal];
        [self.leftBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x2792ff)] forState:UIControlStateNormal];
        [self.rightBtn setTitle:rigthTitle forState:UIControlStateNormal];
        [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        self.leftBtn.titleLabel.font = self.rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.leftBtn.layer.masksToBounds = self.rightBtn.layer.masksToBounds = YES;
        self.leftBtn.layer.cornerRadius = self.rightBtn.layer.cornerRadius = 3.0;
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        
        self.alertTitleLabel.text = title;
  //      self.alertContentLabel.text = content;
  //      self.alertContentLabel.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
        
        /*
         在iPhone 3.0后就支持UIDataDetectorTypes来检测数字和链接。
         UIDataDetectorTypePhoneNumber
         UIDataDetectorTypeLink
         UIDataDetectorTypeNone
         UIDataDetectorTypeAll
         */
        
        
        
        UIButton *xButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [xButton setImage:[UIImage imageNamed:@"btn_close_normal.png"] forState:UIControlStateNormal];
        [xButton setImage:[UIImage imageNamed:@"btn_close_selected.png"] forState:UIControlStateHighlighted];
        xButton.frame = CGRectMake(kAlertWidth - 32, 0, 32, 32);
        [self addSubview:xButton];
        [xButton addTarget:self action:@selector(dismissAlert) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)leftBtnClicked:(id)sender
{
    [self.delegate MyAlertVTab:NO];
    [[PublicDictionary shareDictionary] removeObjectForKey:@"leftBtn"];
    [[PublicDictionary shareDictionary] setObject:@"leftBtn" forKey:@"leftBtn"];
    _leftLeave = YES;
    [self dismissAlert];
    if (self.leftBlock) {
        self.leftBlock();
    }
    
}

- (void)rightBtnClicked:(id)sender
{
    
    NSLog(@"oK");
    NSLog(@"INTArray= %@",InTdata);
    NSMutableArray * DAtA = [[NSMutableArray alloc] init];
    for(NSString * str in InTdata)
    {
        [DAtA addObject:[array objectAtIndex:[str intValue]]];
        //[DAtA addObject:[array objectAtIndex:[str intValue]]];
    }
   
    [[PublicDictionary shareDictionary] removeObjectForKey:@"MyAlertV"];
    [[PublicDictionary shareDictionary] setObject:DAtA forKey:@"MyAlertV"];
    NSLog(@"DAtA = %@",DAtA);
  
  
    _leftLeave = NO;
    [self dismissAlert];
    if (self.rightBlock) {
        self.rightBlock();
    }
    [self.delegate MyAlertVTab:YES];
}



- (void)show
{
    UIWindow *shareWindow = [UIApplication sharedApplication].keyWindow;
    self.frame = CGRectMake(333, (CGRectGetHeight(shareWindow.bounds) - kAlertHeight) * 0.5, kAlertWidth, kAlertHeight);
    [shareWindow addSubview:self];
}

- (void)dismissAlert
{
    [self.delegate MyAlertVTab:NO];
    [[PublicDictionary shareDictionary] removeObjectForKey:@"dismiss"];
    [[PublicDictionary shareDictionary] setObject:@"dismiss" forKey:@"dismiss"];
    [self removeFromSuperview];
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

- (void)removeFromSuperview
{
    
    
    [self.backImageView removeFromSuperview];
    self.backImageView = nil;
    UIWindow *shareWindow = [UIApplication sharedApplication].keyWindow;
    CGRect afterFrame = CGRectMake(333, (CGRectGetHeight(shareWindow.bounds) - kAlertHeight) * 0.5, kAlertWidth, kAlertHeight);
    
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = afterFrame;
        self.transform = CGAffineTransformMakeRotation(0);
//        if (_leftLeave) {
//            self.transform = CGAffineTransformMakeRotation(-M_1_PI / 1.5);
//        }else {
//            self.transform = CGAffineTransformMakeRotation(M_1_PI / 1.5);
//        }
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIWindow *shareWindow = [UIApplication sharedApplication].keyWindow;
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:shareWindow.bounds];
    }
    self.backImageView.backgroundColor = [UIColor blackColor];
    self.backImageView.alpha = 0.6f;
    [shareWindow addSubview:self.backImageView];
    self.transform = CGAffineTransformMakeRotation(0);// CGAffineTransformMakeRotation 实现旋转度
    CGRect afterFrame = CGRectMake((CGRectGetWidth(shareWindow.bounds) - kAlertWidth) * 0.5, (CGRectGetHeight(shareWindow.bounds) - kAlertHeight) * 0.5, kAlertWidth, kAlertHeight);
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
        self.frame = afterFrame;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
}



#pragma mark - TableViewdelegate&&TableViewdataSource

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    //这个方法返回 tableview 有多少个section
    //return [Xzdata count];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 10;
    //return [array count]/3;
    return [array count];
}

////自动调用后
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    return 40.0f;
//
//}

//开辟存储数据的空间
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"tableV = %@",array);
    static NSString *CellIdentifier = @"Cell";
    PublishCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //checked1 = YES;
    
    cell = [[[PublishCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier addTAB:TABB]autorelease];
    [cell setDAta:[[array objectAtIndex:indexPath.row] objectForKey:@"username"]];
    NSLog(@"indexPath.row = %d",indexPath.row);
    cell.BUtton.tag = indexPath.row;
    
    for(NSString * str1 in InTdata)
    {
        NSLog(@"str1 =  = %@,%d" ,str1,indexPath.row);
        if([[NSString stringWithFormat:@"%d",indexPath.row] isEqualToString:str1])
        {
            
            [cell addTab:YES];
            UIImage *checkImage = [UIImage imageNamed:@"Mchecked.PNG"];
            [cell.BUtton setImage:checkImage forState:UIControlStateNormal];
            
        }
        
        
    }
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //[cell setBackgroundColor:[UIColor whiteColor]];
    // UIColor *color = [[UIColor alloc]initWithRed:0.0 green:0.0 blue:0.0 alpha:1];//通过RGB来定义自己的颜色
    
    
//    UIView *backgrdView = [[UIView alloc] initWithFrame:cell.frame];
//    backgrdView.backgroundColor = [UIColor whiteColor];
//    UIView * Vback =  [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-2, cell.frame.size.width,2)];
//    Vback.backgroundColor = UIColorFromRGB(0x2792ff);
//    //[backgrdView addSubview:Vback];
//    [tableView setSeparatorColor:UIColorFromRGB(0x2792ff)];
//    cell.backgroundView = backgrdView;
//    
//    cell.selectedBackgroundView = [[[UIView alloc] initWithFrame:cell.frame] autorelease];
//    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0x2792ff);
    
    //cell.textLabel.highlightedTextColor = [UIColor xxxcolor];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
  // }

    cell.myTableDelegate=self;
   
    if(TABB)
    {
        //cell.userInteractionEnabled = NO;
        //cell.BUtton.userInteractionEnabled = YES;
        cell.selectedBackgroundView = [[[UIView alloc] initWithFrame:cell.frame] autorelease];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
                
    }

    //cell.textLabel.text = @"123";
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"dan ji.row=%d",indexPath.row);
    if(!TABB)
    {
        [InTdata removeAllObjects];
        [InTdata addObject:[NSString stringWithFormat:@"%d",indexPath.row]];
    }
   
    
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

#pragma mark TableDelegate
-(void)checkedButton:(UIButton *)sender checked:(BOOL)checked
{
    NSLog(@"checkedButton ＝%d",sender.tag);
    
    NSString *str = [NSString stringWithFormat:@"%d",sender.tag];
	if (checked) {
        NSLog(@"===%d",sender.tag);
        if([InTdata count] == 0)
            [InTdata addObject:str];
        else
        {
            NSLog(@"NONONO");
            [InTdata addObject:str];
        }
        NSLog(@"INtdata = %@",InTdata);
		//ok
		//[self.mylist addObject:[NSString stringWithFormat:@"%d",[sender tag]]];
	}else {
        
        // NSArray * array = InTdata;
        //NSLog(@"array = %@",array);
        NSMutableArray * ArraY = [[NSMutableArray alloc] init];
        
        for(NSString * str1 in InTdata)
        {
            if(![str isEqualToString:str1])
            {
                [ArraY addObject:str1];
            }
            
        }
        [InTdata removeAllObjects];
        for(NSString * str1 in ArraY)
        {
            [InTdata addObject:str1];
            
        }
		//no
		//[self.mylist removeObject:[NSString stringWithFormat:@"%d",[sender tag]]];
	}

}


@end

@implementation UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}





@end
