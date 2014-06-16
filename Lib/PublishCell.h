//
//  PublishCell.h
//  LoginFrame
//
//  Created by liuxuxing on 14-2-25.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableDelegate.h"

@interface PublishCell : UITableViewCell
{
    UILabel * NameLabel;
    UIButton * BUtton;
    BOOL checked;
    id<TableDelegate> myTableDelegate;

}
-(UIView*)getCellView:(BOOL)Tab;
-(void)setDAta:(NSString *)text;
-(void)addTab:(BOOL)Tab;
@property (nonatomic,retain) id<TableDelegate> myTableDelegate;
@property (nonatomic,retain)  UIButton *BUtton;
//@property (nonatomic,copy) BOOL checked;

@end
