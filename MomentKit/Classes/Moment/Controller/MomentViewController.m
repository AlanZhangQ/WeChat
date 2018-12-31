//
//  MomentViewController.m
//  MomentKit
//
//  Created by Alan on 2018/12/12.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "MomentViewController.h"
#import "MomentCell.h"
#import "Moment.h"
#import "Comment.h"
#import "SHPublishViewController.h"
#import "XJJRefresh.h"
#import "MJRefresh.h"
#import "SHFriendHeadView.h"

#define kStatusBarH ([[UIApplication sharedApplication] statusBarFrame].size.height)
//背景自己
#define kActionSheet_BackGroup_Me_Tag 1
//背景其他人
#define kActionSheet_BackGroup_Other_Tag 2

//当前用户
#define UserName @"Alan"

@interface MomentViewController ()<UITableViewDelegate,UITableViewDataSource,MomentCellDelegate,SHFriendHeadViewDelegate,UIActionSheetDelegate>

@property (nonatomic,strong) NSMutableArray *momentList;
@property (nonatomic,strong) UITableView *tableView;
//@property (nonatomic,strong) UIView *tableHeadView;
@property (nonatomic,strong) SHFriendHeadView *tableHeadView;
@property (nonatomic,strong) UIImageView *coverImageView;
@property (nonatomic,strong) UIImageView *headImageView;

@end

@implementation MomentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"好友动态";
    self.userInfo = @"Alan";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"moment_camera"] style:UIBarButtonItemStylePlain target:self action:@selector(addMoment)];
    
    self.momentList = [self getFriendDataWithNum:10];
    [self.view addSubview:self.tableView];
    [self setRefresh];
}

#pragma mark - 测试数据
- (NSMutableArray *)getFriendDataWithNum:(NSInteger)num
{
    NSMutableArray * tempArray = [NSMutableArray array];
    NSMutableArray *commentList;
    NSMutableArray *imgArray;
    for (int i = 0;  i < num; i ++)  {
        // 评论
        commentList = [[NSMutableArray alloc] init];
        imgArray = [[NSMutableArray alloc] init];
        int num = arc4random()%5 + 1;
        for (int j = 0; j < num; j ++) {
            Comment *comment = [[Comment alloc] init];
            comment.userName = @"胡一菲";
            comment.text = @"天界大乱，九州屠戮，当初被推下地狱的她已经浴火归来.";
            comment.time = 1487649503;
            comment.pk = j;
            [commentList addObject:comment];
        }
        
        Moment *moment = [[Moment alloc] init];
        moment.commentList = commentList;
        moment.praiseNameList = @"胡一菲，唐悠悠，陈美嘉，吕小布，曾小贤，张伟，关谷神奇";
        moment.userName = @"Jeanne";
        moment.time = 1487649403;
        moment.singleWidth = 500;
        moment.singleHeight = 315;
        if (i == 0) {
            moment.commentList = nil;
            moment.praiseNameList = nil;
            moment.location = @"北京 · 西单";
            moment.text = @"来自：https://www.baidu.com.蜀绣又名“川绣”，是在丝绸或其他织物上采用蚕丝线绣出花纹图案的中国传统工艺，18107891687主要指以四川成都为中心的川西平原一带的刺绣。😁蜀绣最早见于西汉的记载，当时的工艺已相当成熟，同时传承了图案配色鲜艳、常用红绿颜色的特点。😁蜀绣又名“川绣”，是在丝绸或其他织物上采用蚕丝线绣出花纹图案的中国传统工艺，https://www.baidu.com，主要指以四川成都为中心的川西平原一带的刺绣。蜀绣最早见于西汉的记载，当时的工艺已相当成熟，同时传承了图案配色鲜艳、常用红绿颜色的特点。";
            moment.fileCount = 1;
        } else if (i == 1) {
            moment.text = @"来自：https://www.baidu.com.天界大乱，九州屠戮，当初被推下地狱的她已经浴火归来 😭😭剑指仙界'你们杀了他，我便覆了你的天，毁了你的界，永世不得超生又如何！'👍👍 ";
            moment.fileCount = arc4random()%10;
            moment.praiseNameList = nil;
        } else if (i == 2) {
            moment.fileCount = 9;
        } else {
            moment.text = @"来自：https://www.baidu.com.天界大乱，九州屠戮，当初被推下地狱cheerylau@126.com的她已经浴火归来，😭😭剑指仙界'你们杀了他，我便覆了你的天，毁了你的界，永世不得超生又如何！'👍👍";
            moment.fileCount = arc4random()%10;
        }
        
        for (int i = 0;i<moment.fileCount;i++) {
            [imgArray addObject:
             [UIImage imageNamed:[NSString stringWithFormat:@"moment_pic_%d",(int)i]]];
        }
        
        moment.imageFArr = imgArray;
        
        [tempArray addObject:moment];
    }
    return tempArray;
}

#pragma mark - 配置刷新、加载
- (void)setRefresh{
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadOldData];
        });
    }];
    
    UIImageView *refreshView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    refreshView.image = [UIImage imageNamed:@"moment_refresh@2x.png"];
    
    XJJHolyCrazyHeader *crazyRefresh = [XJJHolyCrazyHeader holyCrazyCustomHeaderWithCustomContentView:refreshView];
    crazyRefresh.startPosition = CGPointMake(20, (44 + kStatusBarH) - 32);
    crazyRefresh.refreshingPosition = CGPointMake(20,100);
    
    __weak typeof(self) weakSelf = self;
    [self.tableView add_xjj_refreshHeader:crazyRefresh refreshBlock:^{
        
        [weakSelf.tableView setRefreshState:XJJRefreshStateIdle];
        
        [weakSelf.tableView replace_xjj_refreshBlock:^{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf loadNewData];
            });
        }];
    }];
}

#pragma mark - 刷新数据
- (void)loadNewData{
    NSLog(@"刷新数据");

    NSMutableArray *temp = [self getFriendDataWithNum:3];

    for (Moment *model in temp) {
        [self.momentList insertObject:model atIndex:0];
    }

    [self.tableView reloadData];

    [self.tableView end_xjj_refresh];
}

#pragma mark - 加载数据
- (void)loadOldData{
    NSLog(@"加载数据");

    NSArray *temp = [self getFriendDataWithNum:3];

    for (Moment *model in temp) {

        [self.momentList addObject:model];
    }

    [self.tableView reloadData];

    //滚动到指定位置
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.momentList.count - temp.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];

    [self.tableView.mj_footer endRefreshing];
}


#pragma mark - Getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -(44 + kStatusBarH), kWidth, kHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = self.tableHeadView;
    }
    return _tableView;
}

- (SHFriendHeadView *)tableHeadView
{
    if (!_tableHeadView) {
        _tableHeadView = [[SHFriendHeadView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 334)];
        _tableHeadView.backgroundColor = [UIColor clearColor];
        _tableHeadView.userInteractionEnabled = YES;
//        [_tableHeadView addSubview:self.coverImageView];
//        [_tableHeadView addSubview:self.headImageView];
        _tableHeadView.userName = @"Alan";
        _tableHeadView.userAvatar = [NSString stringWithFormat:@"%@",@"moment_head"];
        _tableHeadView.backgroundUrl = [NSString stringWithFormat:@"%@",@"moment_cover"];
        _tableHeadView.delegate = self;
    }
    return _tableHeadView;
}

- (UIImageView *)coverImageView
{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 270)];
        _coverImageView.backgroundColor = [UIColor clearColor];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImageView.contentScaleFactor = [[UIScreen mainScreen] scale];
        _coverImageView.clipsToBounds = YES;
        _coverImageView.userInteractionEnabled = YES;
        _coverImageView.image = [UIImage imageNamed:@"moment_cover"];
    }
    return _coverImageView;
}

- (UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth-85, self.coverImageView.bottom-40, 75, 75)];
        _headImageView.backgroundColor = [UIColor clearColor];
        _headImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
        _headImageView.layer.borderWidth = 2;
        _headImageView.userInteractionEnabled = YES;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.image = [UIImage imageNamed:@"moment_head"];
    }
    return _headImageView;
}

- (NSMutableArray *)momentList
{
    if (!_momentList) {
        _momentList = [[NSMutableArray alloc] init];
    }
    return _momentList;
}

#pragma mark - 发布动态
- (void)addMoment
{
    SHPublishViewController *view = [[SHPublishViewController alloc]init];
    view.block = ^(Moment *message){
        if (message) {
//            Moment *messageFrame = [[Moment alloc]init];
//            messageFrame.message = message;
            [self.momentList insertObject:message atIndex:0];
            //进行刷新
            [self.tableView reloadData];
        }
    };
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:view];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - MomentCellDelegate
// 点击用户头像
- (void)didClickHead:(MomentCell *)cell
{
    NSLog(@"击用户头像");
}
// 赞
- (void)didLikeMoment:(MomentCell *)cell
{
    NSLog(@"点击了====菜单");
    
    __block BOOL isLike = NO;
    
    NSInteger index = [self.momentList indexOfObject:cell.moment];
    
    //查看点赞列表是否有自己
    if ([cell.moment.praiseNameList containsString:@"Alan"]) {
        isLike = YES;
    }
    //    __weak typeof(self) weakSelf = self;
    NSMutableString *muString = [NSMutableString string];
    if(cell.moment.praiseNameList.length > 0) {
    [muString appendString:cell.moment.praiseNameList];
    }
    
    if (isLike) {//点过赞了
        NSRange range1 = [cell.moment.praiseNameList rangeOfString:@",Alan"];
        NSRange range2 = [cell.moment.praiseNameList rangeOfString:@"Alan"];
        if(range1.length) {
            cell.moment.praiseNameList = [muString substringToIndex:range1.location];
        } else if(range2.length) {
            cell.moment.praiseNameList = [muString substringToIndex:range2.location];
        }
    }else{
        if([cell.moment.praiseNameList isEqualToString:@""] || (cell.moment.praiseNameList == nil)){
            cell.moment.praiseNameList = [muString stringByAppendingString:@"Alan"];
        } else {
            cell.moment.praiseNameList = [muString stringByAppendingString:@",Alan"];
        }
    }
    
    [self.momentList replaceObjectAtIndex:index withObject:cell.moment];
    //进行刷新
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
// 评论
- (void)didAddComment:(MomentCell *)cell
{
    NSLog(@"评论");
}
// 查看全文/收起
- (void)didSelectFullText:(MomentCell *)cell
{
    NSLog(@"全文/收起");
    
    [self.tableView reloadData];
}
// 删除
- (void)didDeleteMoment:(MomentCell *)cell
{
    NSLog(@"删除");
    NSInteger index = cell.tag;
    //数组中移除
    [self.momentList removeObjectAtIndex:index];
    //刷新表格
    [self.tableView reloadData];
}
// 选择评论
- (void)didSelectComment:(Comment *)comment
{
    NSLog(@"点击评论");
}
// 点击高亮文字
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText momentCell:(MomentCell *)cell
{
    if(link.linkType == MLLinkTypeURL) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkText]];
    } else if(link.linkType == MLLinkTypeEmail) {
        NSString *recipients = @"mailto:cheerylau@126.com";
        NSString *email = [NSString stringWithFormat:@"%@", recipients];
        email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
    } else if(link.linkType == MLLinkTypePhoneNumber) {
        NSString *mobileNumber = [NSString stringWithFormat:@"tel://%@", linkText];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mobileNumber]];
    }
    NSLog(@"点击高亮文字：%@",linkText);
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.momentList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MomentCell";
    MomentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MomentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    cell.tag = indexPath.row;
    cell.moment = [self.momentList objectAtIndex:indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [MomentCell momentCellHeightForMoment:[self.momentList objectAtIndex:indexPath.row]];
    return height;
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (actionSheet.tag) {
        case kActionSheet_BackGroup_Me_Tag://自己背景
        {
            switch (buttonIndex) {
                case 0://相册
                {
                    NSLog(@"点击了==相册");
                }
                    break;
                case 1://相机
                {
                    NSLog(@"点击了==相机");
                }
                    
                default:
                    break;
            }
        }
            break;
        case kActionSheet_BackGroup_Other_Tag://别人背景
        {
            switch (buttonIndex) {
                case 0://保存到相册
                {
                    NSLog(@"点击了==保存到相册");
                }
                    break;
                default:
                    break;
            }
        }
            
            break;
        default:
            break;
    }
}

#pragma mark - UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSIndexPath *indexPath =  [self.tableView indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
    MomentCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.menuView.show = NO;
}

#pragma mark - SHFriendHeadViewDelegate
- (void)headClick:(SHFriendHeadView *)view ClickType:(SHFriendHeadClickType)clickType{
    switch (clickType) {
        case SHFriendHeadClickType_Avatar://头像
        {
            NSLog(@"头部视图===头像点击");
            [self messageUserClick:nil message:UserName];
        }
            break;
        case SHFriendHeadClickType_Background://背景
            NSLog(@"头部视图===背景点击");
        {
            UIActionSheet *sheet;
            if ([self.userInfo isEqualToString:UserName]) {//自己
                
                sheet = [[UIActionSheet alloc] initWithTitle:@"更换背景" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"相机", nil];
                sheet.tag = kActionSheet_BackGroup_Me_Tag;
                
            }else{//其他人
                
                sheet = [[UIActionSheet alloc] initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存到相册" otherButtonTitles:nil, nil];
                sheet.tag = kActionSheet_BackGroup_Other_Tag;
            }
            [sheet showInView:self.view];
        }
            break;
        default:
            break;
    }
}

- (void)messageUserClick:(MomentCell *)cell message:(NSString *)message{
    
    //移除点赞
//    [[SHTimeLineMenu shareSHTimeLineMenu] removeFromSuperview];
    
    UIAlertView *ale = [[UIAlertView alloc]initWithTitle:@"用户点击" message:message delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
    [ale show];
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
