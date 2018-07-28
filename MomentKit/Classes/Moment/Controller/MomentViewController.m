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

@interface MomentViewController ()<UITableViewDelegate,UITableViewDataSource,MomentCellDelegate>

@property (nonatomic,strong) NSMutableArray *momentList;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *tableHeadView;
@property (nonatomic,strong) UIImageView *coverImageView;
@property (nonatomic,strong) UIImageView *headImageView;

@end

@implementation MomentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"好友动态";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"moment_camera"] style:UIBarButtonItemStylePlain target:self action:@selector(addMoment)];
    
    [self initTestInfo];
    [self.view addSubview:self.tableView];
}

#pragma mark - 测试数据
- (void)initTestInfo
{
    NSMutableArray *commentList;
    for (int i = 0;  i < 10; i ++)  {
        // 评论
        commentList = [[NSMutableArray alloc] init];
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
            moment.text = @"蜀绣又名“川绣”，是在丝绸或其他织物上采用蚕丝线绣出花纹图案的中国传统工艺，18107891687主要指以四川成都为中心的川西平原一带的刺绣。😁蜀绣最早见于西汉的记载，当时的工艺已相当成熟，同时传承了图案配色鲜艳、常用红绿颜色的特点。😁蜀绣又名“川绣”，是在丝绸或其他织物上采用蚕丝线绣出花纹图案的中国传统工艺，https://www.baidu.com，主要指以四川成都为中心的川西平原一带的刺绣。蜀绣最早见于西汉的记载，当时的工艺已相当成熟，同时传承了图案配色鲜艳、常用红绿颜色的特点。";
            moment.fileCount = 1;
        } else if (i == 1) {
            moment.text = @"天界大乱，九州屠戮，当初被推下地狱的她已经浴火归来 😭😭剑指仙界'你们杀了他，我便覆了你的天，毁了你的界，永世不得超生又如何！'👍👍 ";
            moment.fileCount = arc4random()%10;
            moment.praiseNameList = nil;
        } else if (i == 2) {
            moment.fileCount = 9;
        } else {
            moment.text = @"天界大乱，九州屠戮，当初被推下地狱cheerylau@126.com的她已经浴火归来，😭😭剑指仙界'你们杀了他，我便覆了你的天，毁了你的界，永世不得超生又如何！'👍👍";
            moment.fileCount = arc4random()%10;
        }
        [self.momentList addObject:moment];
    }
}

#pragma mark - Getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight-64)];
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

- (UIView *)tableHeadView
{
    if (!_tableHeadView) {
        _tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 270)];
        _tableHeadView.backgroundColor = [UIColor clearColor];
        _tableHeadView.userInteractionEnabled = YES;
        [_tableHeadView addSubview:self.coverImageView];
        [_tableHeadView addSubview:self.headImageView];
    }
    return _tableHeadView;
}

- (UIImageView *)coverImageView
{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, kWidth, 270)];
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
    NSLog(@"点赞");
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

#pragma mark - UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSIndexPath *indexPath =  [self.tableView indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
    MomentCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.menuView.show = NO;
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
