//
//  MyAlertV.h
//  LoginFrame
//
//  Created by liuxuxing on 14-3-5.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyAlertVDelegate

@optional
- (void)MyAlertVTab:(BOOL)tab;
@end


@interface MyAlertV : UIView<UITableViewDataSource,UITableViewDelegate>
{
     id<MyAlertVDelegate> deleage;
}

@property (nonatomic, assign) id<MyAlertVDelegate> delegate;

- (id)initWithTitle:(NSString *)title
        contentArray:(NSArray *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle addTAB:(BOOL)TAB;

- (void)show;

@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;
@property (nonatomic, copy) dispatch_block_t dismissBlock;


@end

@interface UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color;


@end

