//
//  ActivityView.m
//  LoginFrame
//
//  Created by liuxuxing on 14-2-24.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "ActivityView.h"

@implementation ActivityView




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       self.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.5];
        CGSize size = self.bounds.size;
        activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0,5, 30, 40)];
        activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        UILabel  * label = [[UILabel alloc] initWithFrame:CGRectMake(30, 5,70, 40)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"正在加载";
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        UIImageView * backVV = [[UIImageView alloc] initWithFrame:CGRectMake(100, 0, 1, 50)];
        backVV.backgroundColor = [UIColor colorWithHue:1 saturation:0 brightness:1 alpha:0.7];
        
        UIButton * endButton = [UIButton buttonWithType:UIButtonTypeCustom];
        endButton.frame = CGRectMake(105, 5, 40, 40);
        [endButton addTarget:self action:@selector(endButton) forControlEvents:UIControlEventTouchUpInside];
        [endButton setBackgroundImage:[UIImage imageNamed:@"btn_close_normal"] forState:UIControlStateNormal];
        [endButton setBackgroundImage:[UIImage imageNamed:@"btn_close_selected"] forState:UIControlStateHighlighted];
        
        UIView * backView =[[UIView alloc] initWithFrame:CGRectMake((size.width-150)/2,(size.height-60)/2, 150, 50)];
        backView.backgroundColor = [UIColor colorWithHue:0 saturation:1 brightness:0 alpha:0.7];
        [backView addSubview:activityView];
        [backView addSubview:label];
        [backView addSubview:endButton];
        [backView addSubview:backVV];
        [self addSubview:backView];
        
    }
    return self;
}

-(void)endButton
{
    self.alpha = 0.0;
    [activityView stopAnimating];
    [self.delegate CancelTab:YES];

}

- (void)show
{
    self.alpha = 1.0;
    [activityView startAnimating];
    [self.delegate CancelTab:NO];
}

- (void)hidden
{
    self.alpha = 0.0;
    [activityView stopAnimating];
    [self.delegate CancelTab:NO];
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

