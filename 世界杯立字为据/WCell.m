//
//  WCell.m
//  JUJU
//
//  Created by linchuanbin on 14-5-13.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "WCell.h"

@implementation WCell
@synthesize Data = _Data, hometeam = hometeam, visitingteam = visitingteam, hometeamV = hometeamV,visitingteamV = visitingteamV;

-(UIView*)getCellView
{
    CGRect rect = CGRectMake(0, 0, 320, 88);
    UIView* bgView = [[UIView alloc]initWithFrame:rect];
    bgView.backgroundColor = [UIColor clearColor];
    
    UIImageView * BG = [[UIImageView alloc] initWithFrame:bgView.bounds];
    BG.image = [UIImage imageNamed:@"WCellBG.PNG"];
    [bgView addSubview:BG];
    
    
    hometeamV = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"icon.png"]];
    hometeamV.frame = CGRectMake(45, 14, 45, 45);
    hometeamV.clipsToBounds = YES;
    hometeamV.layer.cornerRadius = 22.5;
    [hometeamV.layer setBorderWidth:1.0]; //边框宽度
    [hometeamV.layer setBorderColor:[[UIColor blackColor] CGColor]];
    hometeamV.backgroundColor = [UIColor clearColor];
    
    hometeam = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 135, 20)];
    hometeam.text = @"主队";
    hometeam.textAlignment = NSTextAlignmentCenter;
    hometeam.textColor = [UIColor grayColor];
    hometeam.backgroundColor = [UIColor clearColor];
    
   
    visitingteamV = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"icon.png"]];
    visitingteamV.frame = CGRectMake(230, 14, 45, 45);
    visitingteamV.layer.cornerRadius = 22.5;
    visitingteamV.clipsToBounds = YES;
    [visitingteamV.layer setBorderWidth:1.0]; //边框宽度
    [visitingteamV.layer setBorderColor:[[UIColor blackColor] CGColor]];
    visitingteamV.backgroundColor = [UIColor clearColor];
    
    visitingteam = [[UILabel alloc] initWithFrame:CGRectMake(185, 60, 135, 20)];
    visitingteam.text = @"客队";
    visitingteam.textAlignment = NSTextAlignmentCenter;
    visitingteam.textColor = [UIColor grayColor];
    visitingteam.backgroundColor = [UIColor clearColor];
    
    [bgView addSubview:hometeamV];
    [bgView addSubview:hometeam];
    [bgView addSubview:visitingteamV];
    [bgView addSubview:visitingteam];
    
    return bgView;
    
}




-(WModle *)Data
{
    return _Data;
}

-(void)setData:(WModle *)Data
{
    if(_Data != Data)
    {
        _Data = Data;
        hometeamV.imageURL = [NSURL URLWithString:_Data.HometeamURL];
        visitingteamV.imageURL = [NSURL URLWithString:_Data.VisitingURL];
        hometeam.text = _Data.Home_team;
        visitingteam.text = _Data.Visiting_team;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
	[super willMoveToSuperview:newSuperview];
	
	if(!newSuperview) {
		[hometeamV cancelImageLoad];
        [visitingteamV cancelImageLoad];
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
