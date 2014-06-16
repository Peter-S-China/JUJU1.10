//
//  List1Cell.h
//  JUJU
//
//  Created by linchuanbin on 14-5-9.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "List1Model.h"
#import "EGOImageView.h"

@interface List1Cell : UITableViewCell
{
UILabel * _NameLabel;
EGOImageView * NameHead;
UIView* bgView;
UIImageView * GameHead[6];

List1Model * _Data;
}

@property(nonatomic, retain)List1Model* Data;
@property(nonatomic, retain)UILabel * NameLabel;
-(UIView*)getCellView;

@end
