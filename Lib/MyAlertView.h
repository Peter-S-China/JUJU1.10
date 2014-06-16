//
//  MyAlertView.h
//  CordovaLib
//
//  Created by liuxuxing on 14-1-17.
//
//

#import <UIKit/UIKit.h>

@interface MyAlertView : UIView


- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle addkAlertHeight:(float)H;

- (void)show;

@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;
@property (nonatomic, copy) dispatch_block_t dismissBlock;

@end

@interface UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color;


@end
