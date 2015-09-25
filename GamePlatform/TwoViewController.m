//
//  TwoViewController.m
//  GamePlatform
//
//  Created by hehao on 15/8/27.
//  Copyright (c) 2015年 kuaifa. All rights reserved.
//

#import "TwoViewController.h"
#import "RequestAssistor.h"
#import "DataModels.h"
#import "MJRefresh.h"
#import "DetailViewController.h"
#import "HudViewController.h"//hh'hud

#define kReuserIdOne @"cell1"
#define kReuserIdTwo @"cell2"
#define kReuserIdThree @"cell3"

static int dataIndex = 2;int count = 10;
@interface TwoViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIScrollView *scr;
@property(nonatomic,strong)UISegmentedControl *seg;
@property(nonatomic,strong)UITableView *leftTableView;
@property(nonatomic,strong)UITableView *midTableView;
@property(nonatomic,strong)UITableView *rightTableView;

@property(nonatomic,strong)NSMutableArray *arr;
@property(nonatomic,strong)NSMutableArray *moreData;
@property(nonatomic,strong)NSMutableArray *nnData;
//@property(nonatomic,strong)NSMutableArray *idArr;//存自增id
@property(nonatomic,strong)BaseClass *baseClass;
@property(nonatomic,strong)MJRefreshNormalHeader *header;
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr = [[NSMutableArray alloc] init];
    self.moreData = [[NSMutableArray alloc] init];
    self.nnData = [[NSMutableArray alloc] init];
//    self.idArr = [[NSMutableArray alloc] init];
    self.baseClass = [[BaseClass alloc] init];
    [self requestData];// 请求数据
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self createSegmentedControl];
    [self createScrollView];
    [self createThreeTableView];
    // my hud singleTon
    [[HudViewController sharedClient] createCustomHudWithSuperView:self.view andLoadText:@"loading..."];
    // 上拉刷新
    [self customUpRefresh];
    // 下拉刷新
    [self customDownRefresh];

//    NSLog(@"%f",self.tabBarController.tabBar.bounds.size.height);
}
- (void)requestData
{
    [RequestAssistor requestWithDetailCompleteBlock:^(BaseClass *requestDic) {
        [self.arr removeAllObjects];
        self.arr = requestDic.travels;
//        NSLog(@"dic?->%d",[requestDic.travels isKindOfClass:[NSArray class]]);
        [self.leftTableView reloadData];// 刷新
        // hide my hud
        [[HudViewController sharedClient] hideThisHud];
    }];
}
// upPull 上拉 ---------------------------------------------
- (void)requestMoreData
{
    [RequestAssistor requestWith:dataIndex UpPullDetailCompleteBlock:^(BaseClass *requestDic) {
        [self.moreData removeAllObjects];
        self.moreData = requestDic.travels;
//        NSLog(@"moreData - %@",self.moreData);
    }];
    dataIndex ++;
}
// downPull 下拉
- (void)requestNewData
{
    [RequestAssistor requestWithDetailCompleteBlock:count downPullDetailCompleteBlock:^(BaseClass *requestDic) {
        [self.nnData removeAllObjects];
        self.nnData = requestDic.travels;
        for (int i = 0;i < self.nnData.count;i++)
        {
            Travels *travel = self.nnData[i];
//            self.idArr = [[self.nnData objectAtIndex:i] objectForKey:@"id"];
            NSLog(@"travel::%@",travel);
        }
//        NSLog(@"nnDataa::%@",self.nnData);
    }];
}
#pragma mark - UI
- (void)createSegmentedControl
{
    self.seg = [[UISegmentedControl alloc] initWithItems:@[@"飙升榜",@"游戏榜",@"苹果榜"]];
    self.seg.frame = CGRectMake(50*SCREEN_WIDTHSCALE, 20, 220*SCREEN_WIDTHSCALE, 44);
    self.seg.selectedSegmentIndex = 0;
    [self.seg addTarget:self action:@selector(clickSeg:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.seg];
}
- (void)createScrollView
{
    self.scr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, 320*SCREEN_WIDTHSCALE, 480*SCREEN_HEIGHTSCALE - 20 - 44)];
    //设置翻页,这个属性的每一页取决于sc的宽度,不取决于图片的大小
    self.scr.pagingEnabled=YES;
    //设置在拖拽的时候是否锁定其在水平或者垂直的方向
    self.scr.directionalLockEnabled = NO;
    self.scr.backgroundColor = [UIColor whiteColor];
    self.scr.delegate = self;
    self.scr.contentSize = CGSizeMake(320*SCREEN_WIDTHSCALE*3, 480*SCREEN_HEIGHTSCALE - 20 - 44 - 49);
    [self.view addSubview:self.scr];
}
- (void)createThreeTableView
{
    //left
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320*SCREEN_WIDTHSCALE, 480*SCREEN_HEIGHTSCALE - 20 - 44 - 49) style:UITableViewStylePlain];
    self.leftTableView.tag = 10;
    self.leftTableView.dataSource = self;
    self.leftTableView.delegate = self;
    [self.scr addSubview:self.leftTableView];
    //mid
    self.midTableView = [[UITableView alloc] initWithFrame:CGRectMake(320*SCREEN_WIDTHSCALE, 0, 320*SCREEN_WIDTHSCALE, 480*SCREEN_HEIGHTSCALE - 20 - 44 - 49) style:UITableViewStylePlain];
    self.midTableView.tag = 11;
    self.midTableView.backgroundColor = [UIColor blueColor];
    self.midTableView.dataSource = self;
    self.midTableView.delegate = self;
    [self.scr addSubview:self.midTableView];
    //right
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(640*SCREEN_WIDTHSCALE, 0, 320*SCREEN_WIDTHSCALE, 480*SCREEN_HEIGHTSCALE - 20 - 44 - 49) style:UITableViewStylePlain];
    self.rightTableView.tag = 12;
    self.rightTableView.backgroundColor = [UIColor purpleColor];
    self.rightTableView.dataSource = self;
    self.rightTableView.delegate = self;
    [self.scr addSubview:self.rightTableView];
}
#pragma mark - uiscrollviewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = self.scr.frame.size.width;
    int x = (self.scr.contentOffset.x)/width;
    self.seg.selectedSegmentIndex = x;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 10)
    {
        return self.arr.count;
    }
    else if (tableView.tag == 11)
    {
        return self.arr.count;
    }
    else
    {
        return self.arr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier1 = kReuserIdOne;
    static NSString *reuseIdentifier2 = kReuserIdTwo;
    static NSString *reuseIdentifier3 = kReuserIdThree;
    UITableViewCell *cell = nil;
        if (tableView.tag == 10)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier1];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier1];
        }
        Travels *travel = self.arr[indexPath.row]; // 用objectForKey：的话是取的travels的对象，travels不是字典。不能用objectForKey：。
//        NSLog(@">>%d",[self.arr[indexPath.row] isKindOfClass:[NSDictionary class]]);
        cell.textLabel.text = travel.title;
    }
        if (tableView.tag == 11)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier2];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier2];
        }
        cell.textLabel.text = @"mid";
    }
        if (tableView.tag == 12)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier3];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier3];
        }
        cell.textLabel.text = @"right";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailVC = [[DetailViewController alloc] initWithPara:self.arr[indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
// seg绑定的方法
- (void)clickSeg:(id)sender
{
//    NSLog(@"我点了%ld",(long)self.seg.selectedSegmentIndex);
    CGPoint offset = CGPointMake(self.seg.selectedSegmentIndex * 320 * SCREEN_WIDTHSCALE, 0);
    [self.scr setContentOffset:offset animated:YES];
}
/*
 **********************************************
 */
#pragma mark UITableView + 上拉刷新 自动回弹的上拉01 ------------------------------------------------------------------
- (void)customUpRefresh
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.leftTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置了底部inset
    self.leftTableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    // 忽略掉底部inset
    self.leftTableView.footer.ignoredScrollViewContentInsetBottom = 30;
    [self requestMoreData];
}
#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    [self requestMoreData];

    // 1.添加数据
        [self.arr addObjectsFromArray:self.moreData];//尾部追加一个数组
    // 2.刷新表格UI
        [self.leftTableView reloadData];
        // 拿到当前的上拉刷新控件，结束刷新状态
        [self.leftTableView.footer endRefreshing];
}
#pragma mark UITableView + 下拉刷新 自定义文字
- (void)customDownRefresh
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置文字
    // 设置字体
    self.header.stateLabel.font = [UIFont systemFontOfSize:15];
    self.header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    // 设置颜色
    self.header.stateLabel.textColor = [UIColor grayColor];
    self.header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    // 马上进入刷新状态
    [self.header beginRefreshing];
    // 设置刷新控件
    self.leftTableView.header = self.header;
}
#pragma mark 下拉刷新数据 ------------------------------------------------------------------
- (void)loadNewData
{
    [self requestNewData];
    // 1.添加数据
    if (self.arr.count != 0 && self.nnData.count != 0)
    {
//        NSLog(@"self.arr[0]>>%@",self.arr);
        if ([self.arr[0] isEqual:self.nnData[0]])
        {
//            NSLog(@"self.arr[0]>>%@ \nself.nnData[0]>>%@",self.arr[0],self.nnData[0]);
            NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:
                                   NSMakeRange(0,[self.nnData count])];
            [self.arr insertObjects:self.nnData atIndexes:indexes];

        }
        // 设置文字
        [self.header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [self.header setTitle:@"松手刷新" forState:MJRefreshStatePulling];
        [self.header setTitle:@"Loading..." forState:MJRefreshStateRefreshing];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (ino64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 2.刷新表格UI
        [self.leftTableView reloadData];
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.leftTableView.header endRefreshing];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
