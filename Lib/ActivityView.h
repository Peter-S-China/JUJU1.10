//
//  ActivityView.h
//  LoginFrame
//
//  Created by liuxuxing on 14-2-24.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActivityViewDelegate

@optional
- (void)CancelTab:(BOOL)tab;
@end


@interface ActivityView : UIView{
    UIActivityIndicatorView *activityView;
    id<ActivityViewDelegate> deleage;
}
@property (nonatomic, assign) id<ActivityViewDelegate> delegate;
- (void)show;

- (void)hidden;
//@property (nonatomic, strong) UIView *backImageView;

@end
