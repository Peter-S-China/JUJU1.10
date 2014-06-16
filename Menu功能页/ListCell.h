//
//  ListCell.h
//  JUJU
//
//  Created by linchuanbin on 14-5-5.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"
#import "EGOImageView.h"

@interface ListCell : UITableViewCell
{
    UILabel * NameLabel;
    EGOImageView * NameHead;
    UIImageView * GameHead;
    
    ListModel * _Data;
}

@property(nonatomic, retain)ListModel* Data;
@property(nonatomic, retain)UILabel * NameLabel;
-(UIView*)getCellView;

@end
