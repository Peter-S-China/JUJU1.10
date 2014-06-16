//
//  List1Cell.m
//  JUJU
//
//  Created by linchuanbin on 14-5-9.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "List1Cell.h"

@implementation List1Cell

@synthesize Data = _Data,NameLabel = _NameLabel;


-(UIView*)getCellView
{
    CGRect rect = CGRectMake(0, 0, 280, 60);
    bgView = [[UIView alloc]initWithFrame:rect];
    bgView.backgroundColor = [UIColor clearColor];
    
    
    _NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50,15,80,30)];
    _NameLabel.text = @"name";
    _NameLabel.font = [UIFont systemFontOfSize:20];
    _NameLabel.textColor = [UIColor whiteColor];
    _NameLabel.textAlignment = NSTextAlignmentLeft;
    _NameLabel.backgroundColor = [UIColor clearColor];
    
    NameHead = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"Radar.png"]];
    NameHead.frame = CGRectMake(5, 10, 40, 40);
    NameHead.layer.cornerRadius = 20;
    [NameHead.layer setBorderWidth:2.0]; //边框宽度
    NameHead.clipsToBounds = YES;
    [NameHead.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    //NameHead.image = [UIImage imageNamed:@"Radar.png"];
    
    //    GameHead = [[UIImageView alloc] initWithFrame:CGRectMake(235, 10, 40, 40)];
    //    //GameHead.layer.cornerRadius = 20;
    //    //[GameHead.layer setBorderWidth:2.0]; //边框宽度
    //    [GameHead.layer setBorderColor:[[UIColor blueColor] CGColor]];
    //    GameHead.image = [UIImage imageNamed:@"Talkshow.PNG"];
    //  [bgView addSubview:GameHead];
    
    
    [bgView addSubview:_NameLabel];
    [bgView addSubview:NameHead];
    
    
    return bgView;
    
}



-(List1Model *)Data
{
    return _Data;
}

-(void)setData:(List1Model *)Data
{
    if(_Data != Data)
    {
        _Data = Data;
        //ImageView.image = [UIImage imageNamed:@"defult.png"];
        _NameLabel.text = _Data.Name;
        NameHead.imageURL = [NSURL URLWithString:_Data.NameHead];
        
        NSArray *array = [_Data.GameHead componentsSeparatedByString:@","];
        NSComparator finderSort = ^(id string1,id string2){
            
            if ([string1 integerValue] > [string2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }else if ([string1 integerValue] < [string2 integerValue]){
                return (NSComparisonResult)NSOrderedAscending;
            }
            else
                return (NSComparisonResult)NSOrderedSame;
        };
        NSArray *resultArray = [array sortedArrayUsingComparator:finderSort];
        NSLog(@"resultArray = %@",resultArray);
        
        for(int i= 0 ;i < [array count];i++)
        {
            GameHead[i] = [[UIImageView alloc] initWithFrame:CGRectMake(135 + 30*i ,15,25, 25)];
            GameHead[i].image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@%@.PNG",[resultArray objectAtIndex:i],[resultArray objectAtIndex:i],[resultArray objectAtIndex:i]]];
            //GameHead[i].backgroundColor = [UIColor grayColor];
            [bgView addSubview:GameHead[i]];
        }
        
        
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
