//
//  MenuViewController.h
//  JUJU
//
//  Created by linchuanbin on 14-5-17.
//  Copyright (c) 2014年 linchaunbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPageControl.h"
#import "PassImageDelegate.h"
#import "CaptureViewController.h"
#import "EGOImageView.h"


@interface MenuViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIScrollViewDelegate,NetWorkDelegate,ASIHTTPRequestDelegate,ActivityViewDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIActionSheetDelegate>
{
    UIImageView * _BackImage;
    UIImageView * _ChatImage;
    UIImageView * _GameTitleImage;
    UIImageView * _GamebackImage;
    
    UIView * _Namelist;
    UIImageView * NameBG;
    UITableView * _NametableV;
    NSMutableArray * _tableVdata;

    
    UIScrollView * _Gameunderway;
    NSMutableArray * _GameunderwayData;
    UIScrollView * _GameList;
    NSMutableArray * _GameListData;
    UIPageControl * _GamepageControl;
    
    
    UIView * _HomeV;
    UITextField * _Roomnumber;
    
    NetWork * netWork;
    RQIdentifier rqIdentifier;
    ActivityView *activityView;
    ASIFormDataRequest *upLoadRequest;
    UIView * gameNaV;
    
    UIButton * NBut;
    
    
    UITableView * ChatV;
    UITableView * ChatTab;
    UIView * PopChatV;
    UITextField * _ChatText;
    NSMutableArray * _Chatdata;
    NSTimer * Chatdatatime;
    
    UIButton * JiaRoom;
    
    
    UILabel * Title1;
    
    
    NSTimer * _Gamelisttime;
    
    EGOImageView * addimageV;
    
    UIView * ADDimageV;
    UIButton * imageheadView;
    
    
}

@property (nonatomic, retain)UIImageView * BackImage;
@property (nonatomic, retain)UIImageView * ChatImage;
@property (nonatomic, retain)UIImageView * GameTitleImage;
@property (nonatomic, retain)UIImageView * GamebackImage;
@property (nonatomic, retain)UIView      * Namelist;
@property (nonatomic, retain)UIScrollView * Gameunderway;
@property (nonatomic, retain)UIScrollView * GameList;

@property (nonatomic, retain)UITextField * Roomnumber;
@property (nonatomic, retain)UIView * HomeV;

@end
