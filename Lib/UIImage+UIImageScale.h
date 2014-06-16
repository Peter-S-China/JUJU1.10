//
//  UIImage+UIImageScale.h
//  LoginFrame
//
//  Created by linchuanbin on 14-3-17.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageScale)

-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage*)scaleToSize:(CGSize)size;

@end
