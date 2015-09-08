//
//  OneViewController.m
//  GamePlatform
//
//  Created by hehao on 15/8/27.
//  Copyright (c) 2015年 kuaifa. All rights reserved.
//

#import "OneViewController.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "MJChiBaoZiFooter.h"
#import "MJChiBaoZiHeader.h"

#define kReuserIdentifier @"cell"
#define kTimeInterval 1
/**
 * 随机数据
 */
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]
static const CGFloat MJDuration = 2.0;

@interface OneViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIScrollView *scr;
@property(nonatomic,strong)UIPageControl *page;
@property(nonatomic,strong)NSMutableArray *imgArr;
@property(nonatomic,strong)UISearchBar *search;
@property(nonatomic,strong)UITableView *tableView;
/** 用来显示的假数据 */
@property(strong, nonatomic) NSMutableArray *data;
@property(strong, nonatomic)NSTimer *timer;
@property(nonatomic,strong)UIActivityIndicatorView *hud;
@end

@implementation OneViewController
// init data
- (NSMutableArray *)data
{
    if (!_data) {
        self.data = [NSMutableArray array];
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self createSearchBar];
    [self createTableView];
    // 下拉刷新
    [self example02];
    // 上拉刷新
    [self example12];
    
    [self createHud];

}
#pragma mark - hud
- (void)createHud
{
    self.hud = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.hud.frame = CGRectMake(110, 190, 100, 100);
    [self.view addSubview:self.hud];
    [self.hud startAnimating];
}
/*
 **********************************************
 */
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data insertObject:MJRandomData atIndex:0];
    }
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.header endRefreshing];
        //
        [self.hud stopAnimating];
    });
}
#pragma mark UITableView + 下拉刷新 自定义文字
- (void)customDownRefresh
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置文字
    [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
    [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    // 设置颜色
    header.stateLabel.textColor = [UIColor grayColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    // 马上进入刷新状态
    [header beginRefreshing];
    // 设置刷新控件
    self.tableView.header = header;
}
#pragma mark UITableView + 下拉刷新 动画图片
- (void)example02
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
}

/*
 **********************************************
 */
#pragma mark UITableView + 上拉刷新 自动回弹的上拉01
- (void)customUpRefresh
{
//    [self example01];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置了底部inset
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    // 忽略掉底部inset
    self.tableView.footer.ignoredScrollViewContentInsetBottom = 30;
}
#pragma mark UITableView + 上拉刷新 动画图片
- (void)example12
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.tableView.footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    // 1.添加5条假数据
    for (int i = 0; i<5; i++) {
        [self.data addObject:MJRandomData];
    }
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的上拉刷新控件，结束刷新状态
        [self.tableView.footer endRefreshing];
    });
}
/*
 **********************************************
 */
#pragma mark - UI
- (void)createSearchBar
{
    self.search = [[UISearchBar alloc] initWithFrame:CGRectMake(50*SCREEN_WIDTHSCALE, 20, (320 - 55)*SCREEN_WIDTHSCALE, 44)];
    self.search.searchBarStyle = UISearchBarStyleDefault;
    [self.view addSubview:self.search];
    //
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.timer = [NSTimer scheduledTimerWithTimeInterval:kTimeInterval target:self selector:@selector(autoChange) userInfo:nil repeats:YES];
        });
    });
    //
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taptap)];
    [self.search addGestureRecognizer:tap];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(5*SCREEN_WIDTHSCALE, 20, 40*SCREEN_WIDTHSCALE, 44);
    [btn setBackgroundImage:[UIImage imageNamed:@"gift@2x.png"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
}
// self.search.placeholder 循环
- (void)autoChange
{
    NSArray *textArr = [[NSArray alloc] initWithObjects:@"大家都在搜'美团'",@"大家都在搜'FIFA'",@"大家都在搜'LOL'",@"大家都在搜'DOTA2'", nil];
    self.search.placeholder = textArr[arc4random()%4];
 
}
- (void)createTableView
{
    //
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320 * SCREEN_WIDTHSCALE, 480 * SCREEN_HEIGHTSCALE - 44 - 20 - 49) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    //
    self.scr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20 + 44, 320*SCREEN_WIDTHSCALE, 150*SCREEN_HEIGHTSCALE)];
    self.scr.backgroundColor = [UIColor blueColor];
    self.scr.pagingEnabled = YES;
    self.scr.delegate = self;
    self.scr.contentSize = CGSizeMake(320*SCREEN_WIDTHSCALE * 5, 150*SCREEN_HEIGHTSCALE);
    [self.view addSubview:self.scr];
    self.imgArr = [[NSMutableArray alloc] initWithObjects:@"0.jpg",@"1.jpg",@"3.jpg",@"2.jpg",@"3.jpg",nil];
    for (int i = 0; i<5; i++)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self.imgArr objectAtIndex:i]]];
        imgView.frame = CGRectMake(self.view.bounds.size.width * i, 0, self.view.bounds.size.width, 300);
        [self.scr addSubview:imgView];
    }
    // 设置表头
    self.tableView.tableHeaderView = self.scr;
    // 置于最后
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(110*SCREEN_WIDTHSCALE, 110*SCREEN_HEIGHTSCALE, 100*SCREEN_WIDTHSCALE, 40*SCREEN_HEIGHTSCALE)];
    [self.page setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
    [self.page setPageIndicatorTintColor:[UIColor grayColor]];
    self.page.numberOfPages = 5;
    self.page.currentPage = 0;
    [self.tableView addSubview:self.page];
}
#pragma mark - scrollviewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pagewidth = self.scr.frame.size.width;
    int page = floor((self.scr.contentOffset.x - pagewidth/(5+2))/pagewidth)+1;
    self.page.currentPage = page;
}
#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuserIdentifier = kReuserIdentifier;
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"fakeData%@",self.data[indexPath.row]];
    return cell;
}
// 区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    vi.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"gift@2x.png"] forState:UIControlStateNormal];
    btn1.frame = CGRectMake(5 * SCREEN_WIDTHSCALE, 5 * SCREEN_HEIGHTSCALE, 35, 35);
    [vi addSubview:btn1];
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(40 * SCREEN_WIDTHSCALE, 12 * SCREEN_HEIGHTSCALE, 40, 20)];
    lab1.text = @"必备";
    lab1.textColor = [UIColor grayColor];
    [vi addSubview:lab1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"userinfo@2x.png"] forState:UIControlStateNormal];
    btn2.frame = CGRectMake(85 * SCREEN_WIDTHSCALE, 5 *SCREEN_HEIGHTSCALE, 35, 35);
    [vi addSubview:btn2];
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(120 * SCREEN_WIDTHSCALE, 12 * SCREEN_HEIGHTSCALE, 40, 20)];
    lab2.text = @"发现";
    lab2.textColor = [UIColor grayColor];
    [vi addSubview:lab2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"email@2x.png"] forState:UIControlStateNormal];
    btn3.frame = CGRectMake(165*SCREEN_WIDTHSCALE, 5 * SCREEN_HEIGHTSCALE, 35, 35);
    [vi addSubview:btn3];
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(200 *SCREEN_WIDTHSCALE, 12 * SCREEN_HEIGHTSCALE, 40, 20)];
    lab3.text = @"网游";
    lab3.textColor = [UIColor grayColor];
    [vi addSubview:lab3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setBackgroundImage:[UIImage imageNamed:@"btn_home.png"] forState:UIControlStateNormal];
    btn4.frame = CGRectMake(245 * SCREEN_WIDTHSCALE, 5 * SCREEN_HEIGHTSCALE, 35, 35);
    [vi addSubview:btn4];
    UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(280 * SCREEN_WIDTHSCALE, 12 * SCREEN_HEIGHTSCALE, 40, 20)];
    lab4.text = @"专题";
    lab4.textColor = [UIColor grayColor];
    [vi addSubview:lab4];

    return vi;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
// 手势方法
- (void)taptap
{
    [self.search resignFirstResponder];
}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)didReceiveMemoryWarning
{
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
