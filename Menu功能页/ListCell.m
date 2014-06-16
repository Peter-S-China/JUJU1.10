//
//  ListCell.m
//  JUJU
//
//  Created by linchuanbin on 14-5-5.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell
@synthesize Data = _Data,NameLabel = NameLabel;


-(UIView*)getCellView
{
    CGRect rect = CGRectMake(0, 0, 280, 60);
    UIView* bgView = [[UIView alloc]initWithFrame:rect];
    bgView.backgroundColor = [UIColor clearColor];
    
    
    NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60,15,170,30)];
    NameLabel.text = @"name";
    NameLabel.font = [UIFont systemFontOfSize:20];
    NameLabel.textColor = [UIColor whiteColor];
    NameLabel.textAlignment = NSTextAlignmentLeft;
    NameLabel.backgroundColor = [UIColor clearColor];
    
//    NameHead = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
//    NameHead.layer.cornerRadius = 25;
//    [NameHead.layer setBorderWidth:2.0]; //边框宽度
    NameHead = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"Radar.png"]];
    NameHead.frame = CGRectMake(5, 5, 50, 50);
    NameHead.layer.cornerRadius = 25;
    [NameHead.layer setBorderWidth:2.0]; //边框宽度
    

    
    [NameHead.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    NameHead.clipsToBounds = YES;
    //NameHead.image = [UIImage imageNamed:@"Radar.png"];
    
    GameHead = [[UIImageView alloc] initWithFrame:CGRectMake(235, 10, 40, 40)];
    GameHead.layer.cornerRadius = 20;
    [GameHead.layer setBorderWidth:2.0]; //边框宽度
    [GameHead.layer setBorderColor:[[UIColor blueColor] CGColor]];
    //GameHead.image = [UIImage imageNamed:@"Talkshow.PNG"];
    
    
    
    [bgView addSubview:NameLabel];
    [bgView addSubview:NameHead];
    //[bgView addSubview:GameHead];

    
    return bgView;
    
}



-(ListModel *)Data
{
    return _Data;
}

-(void)setData:(ListModel *)Data
{
    if(_Data != Data)
    {
        _Data = Data;
        NameLabel.text = _Data.Name;
        NameHead.imageURL = [NSURL URLWithString:_Data.NameHead];
        
    }
}




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIView* v = [self getCellView];
        [self.contentView addSubview:v];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
