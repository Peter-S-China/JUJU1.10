//
//  PublishCell.m
//  LoginFrame
//
//  Created by liuxuxing on 14-2-25.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "PublishCell.h"

@implementation PublishCell
@synthesize myTableDelegate;
@synthesize BUtton;
//@synthesize checked;

-(UIView*)getCellView:(BOOL)Tab
{
    CGRect rect = CGRectMake(0, 0, 284, 40);
    UIView* bgView = [[UIView alloc]initWithFrame:rect];
    bgView.backgroundColor = [UIColor whiteColor];
    
    NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,5, rect.size.width-60, 30)];
    NameLabel.text = @"NameLabel";
    NameLabel.textAlignment = NSTextAlignmentLeft;
    NameLabel.textColor = [UIColor blackColor];
    NameLabel.backgroundColor = [UIColor clearColor];
    NameLabel.font = [UIFont systemFontOfSize:15];
    //NameLabel.adjustsFontSizeToFitWidth =
    
    
    BUtton = [UIButton buttonWithType:UIButtonTypeCustom];
    //BUtton.backgroundColor = [UIColor blackColor];
    BUtton.frame = CGRectMake(rect.size.width-80,0,70, 40);
    //[BUtton setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    //[BUtton setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateHighlighted];
    [BUtton setImage:[UIImage imageNamed:@"Munchecked.PNG"] forState:UIControlStateNormal];
    
    //checked = NO;
    //[BUtton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateHighlighted];
    [BUtton addTarget:self action:@selector(onClickButton:) forControlEvents:UIControlEventTouchUpInside];
   
    

    //BUtton.userInteractionEnabled = !self.userInteractionEnabled;
    
    [bgView addSubview:NameLabel];
    if(Tab)
    [bgView addSubview:BUtton];
    
    return bgView;
}

-(void)onClickButton:(UIButton *)but
{
    checked = !checked;
    UIImage *checkImage = (checked) ? [UIImage imageNamed:@"Mchecked.PNG"] : [UIImage imageNamed:@"Munchecked.PNG"];
    NSLog(@"image = %@",checked? @"Mchecked.PNG":@"Munchecked.PNG");
    [but setImage:checkImage forState:UIControlStateNormal];
   // NSLog(@"button.tag =%d ",but.tag);
    //but.tag = 10;
    
    if (myTableDelegate!=nil) {
        NSLog(@"delegate");
		[myTableDelegate checkedButton:but checked:checked];
	}
}

-(void)setDAta:(NSString *)text
{
    NameLabel.text = [text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


-(void)addTab:(BOOL)Tab
{
    checked = Tab;
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier addTAB:(BOOL)Tab
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIView* v = [self getCellView:Tab];
        [self.contentView addSubview:v];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
