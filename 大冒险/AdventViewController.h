//
//  AdventViewController.h
//  JUJU
//
//  Created by linchuanbin on 14-5-20.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import "AdventureViewController.h"

@interface AdventViewController : AdventureViewController<AVAudioPlayerDelegate>
{
    //RQIdentifierForSingleadventure
    ASIFormDataRequest *upLoadRequest;   // 上传请求
    UITextView * title;
    UITextView * content;
}

@end
