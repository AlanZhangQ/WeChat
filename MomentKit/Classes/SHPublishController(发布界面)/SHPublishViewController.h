//
//  SHPublishViewController.h
//  SHFriendTimeLineUI
//
//  Created by Alan on 2018/12/15.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLPhotoPickerBrowserViewController.h"
#import "Moment.h"

/**
 发布界面
 */
@interface SHPublishViewController : UIViewController

//回调
@property (nonatomic, strong) void(^block)(Moment *message);


@end
