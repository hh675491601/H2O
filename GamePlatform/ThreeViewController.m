//
//  ThreeViewController.m
//  GamePlatform
//
//  Created by hehao on 15/8/27.
//  Copyright (c) 2015年 kuaifa. All rights reserved.
//

#import "ThreeViewController.h"

#define kReuserId111 @"cell1"
#define kReuserId222 @"cell2"
#define kReuserId333 @"cell3"
#define kReuserId444 @"cell4"
@interface ThreeViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UISegmentedControl *seg;
@property(nonatomic,strong)UISearchBar *search;
@property(nonatomic,strong)UIScrollView *scr;
@property(nonatomic,strong)UITableView *tableView1;
@property(nonatomic,strong)UITableView *tableView2;
@property(nonatomic,strong)UITableView *tableView3;
@property(nonatomic,strong)UITableView *tableView4;
@property(nonatomic,strong)UIScrollView *smallScr;
@property(nonatomic,strong)UIPageControl *page;
@property(nonatomic,strong)NSMutableArray *imgArr;

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self createSearch];
    [self createSegmentedControl];
    [self createBigScrollView];
    [self createTableView];
}
#pragma mark - UI
- (void)createSearch
{
    self.search = [[UISearchBar alloc] initWithFrame:CGRectMake(50*SCREEN_WIDTHSCALE, 20, (320 - 55)*SCREEN_WIDTHSCALE, 44)];
    self.search.searchBarStyle = UISearchBarStyleDefault;
    self.search.placeholder = @"大家都在搜'新征途'";
    // gesture
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taptap)];
    [self.search addGestureRecognizer:tap];
    [self.view addSubview:self.search];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(5*SCREEN_WIDTHSCALE, 20, 40*SCREEN_WIDTHSCALE, 44);
    [btn setBackgroundImage:[UIImage imageNamed:@"gift@2x.png"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
}
- (void)createSegmentedControl
{
    self.seg = [[UISegmentedControl alloc] initWithItems:@[@"必玩",@"精选",@"新锐",@"分类"]];
    self.seg.frame = CGRectMake(50*SCREEN_WIDTHSCALE, 64, 220*SCREEN_WIDTHSCALE, 24);
    self.seg.selectedSegmentIndex = 0;
    [self.seg addTarget:self action:@selector(clickSeg:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.seg];
}
- (void)createBigScrollView
{
    self.scr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20 + 44 + 24, 320*SCREEN_WIDTHSCALE, 480*SCREEN_HEIGHTSCALE - 20 - 44  - 24 - 49)];
//    self.scr.backgroundColor = [UIColor blackColor];
    self.scr.pagingEnabled = YES;
    self.scr.delegate = self;
    self.scr.contentSize = CGSizeMake(320*SCREEN_WIDTHSCALE * 4, 150*SCREEN_HEIGHTSCALE);
    [self.view addSubview:self.scr];
}
- (void)createTableView
{
    //1
    self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320*SCREEN_WIDTHSCALE, 480*SCREEN_HEIGHTSCALE - 20 - 44  - 24 - 49) style:UITableViewStylePlain];
    self.tableView1.tag = 20;
    self.tableView1.dataSource = self;
    self.tableView1.delegate = self;
    [self.scr addSubview:self.tableView1];
    //2
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(320*SCREEN_WIDTHSCALE, 0, 320*SCREEN_WIDTHSCALE, 480*SCREEN_HEIGHTSCALE - 20 - 44  - 24 - 49) style:UITableViewStylePlain];
    self.tableView2.tag = 21;
    self.tableView2.dataSource = self;
    self.tableView2.delegate = self;
    [self.scr addSubview:self.tableView2];
    // 展示的小的 smallScr
    self.smallScr = [[UIScrollView alloc] initWithFrame:CGRectMake(320 * SCREEN_WIDTHSCALE, 20 + 44 +24, 320*SCREEN_WIDTHSCALE, 150*SCREEN_HEIGHTSCALE)];
    self.smallScr.backgroundColor = [UIColor blueColor];
    self.smallScr.pagingEnabled = YES;
    self.smallScr.delegate = self;
    self.smallScr.contentSize = CGSizeMake(320*SCREEN_WIDTHSCALE * 5, 150*SCREEN_HEIGHTSCALE);
    [self.view addSubview:self.smallScr];
    self.imgArr = [[NSMutableArray alloc] initWithObjects:@"0.jpg",@"1.jpg",@"3.jpg",@"2.jpg",@"3.jpg",nil];
    for (int i = 0; i<5; i++)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self.imgArr objectAtIndex:i]]];
        imgView.frame = CGRectMake(self.view.bounds.size.width * i, 0, self.view.bounds.size.width, 300);
        [self.smallScr addSubview:imgView];
    }
    // 设置表头
    self.tableView2.tableHeaderView = self.smallScr;
    // 置于最后
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(110*SCREEN_WIDTHSCALE, 110*SCREEN_HEIGHTSCALE, 100*SCREEN_WIDTHSCALE, 40*SCREEN_HEIGHTSCALE)];
    [self.page setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [self.page setPageIndicatorTintColor:[UIColor blackColor]];
    self.page.numberOfPages = 5;
    self.page.currentPage = 0;
    [self.tableView2 addSubview:self.page];

    //3
    self.tableView3 = [[UITableView alloc] initWithFrame:CGRectMake(640*SCREEN_WIDTHSCALE, 0, 320*SCREEN_WIDTHSCALE, 480*SCREEN_HEIGHTSCALE - 20 - 44  - 24 - 49) style:UITableViewStylePlain];
    self.tableView3.tag = 22;
    self.tableView3.backgroundColor = [UIColor purpleColor];
    self.tableView3.dataSource = self;
    self.tableView3.delegate = self;
    [self.scr addSubview:self.tableView3];
    //4
    self.tableView4 = [[UITableView alloc] initWithFrame:CGRectMake(960*SCREEN_WIDTHSCALE, 0, 320*SCREEN_WIDTHSCALE, 480*SCREEN_HEIGHTSCALE - 20 - 44  - 24 - 49) style:UITableViewStylePlain];
    self.tableView4.tag = 23;
    self.tableView4.backgroundColor = [UIColor purpleColor];
    self.tableView4.dataSource = self;
    self.tableView4.delegate = self;
    [self.scr addSubview:self.tableView4];
}
// 手势方法
- (void)taptap
{
    [self.search resignFirstResponder];
}
// seg绑定的方法
- (void)clickSeg:(id)sender
{
    NSLog(@"我点了%d",self.seg.selectedSegmentIndex);
    CGPoint offset = CGPointMake(self.seg.selectedSegmentIndex * 320 * SCREEN_WIDTHSCALE, 0);
    [self.scr setContentOffset:offset animated:YES];
}
#pragma mark - uiscrollviewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = self.scr.frame.size.width;
    int x = (self.scr.contentOffset.x)/width;
    self.seg.selectedSegmentIndex = x;
    
    CGFloat pagewidth = self.smallScr.frame.size.width;
    int page = floor((self.smallScr.contentOffset.x - pagewidth/(5+2))/pagewidth)+1;
    self.page.currentPage = page;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier1 = kReuserId111;
    static NSString *reuseIdentifier2 = kReuserId222;
    static NSString *reuseIdentifier3 = kReuserId333;
    static NSString *reuseIdentifier4 = kReuserId444;
    UITableViewCell *cell = nil;
    if (tableView.tag == 20)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier1];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier1];
        }
        cell.textLabel.text = @"111";
    }
    if (tableView.tag == 21)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier2];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier2];
        }
        cell.textLabel.text = @"222";
    }
    if (tableView.tag == 22)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier3];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier3];
        }
        cell.textLabel.text = @"333";
    }
    if (tableView.tag == 23)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier4];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier4];
        }
        cell.textLabel.text = @"444";
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 21)
    {
        return 20;
    }
    else
    {
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    lab.backgroundColor = [UIColor whiteColor];
    lab.alpha = 0.8;
    lab.text = @"    热门推荐";
    lab.textColor = [UIColor greenColor];
    lab.font = [UIFont systemFontOfSize:14];
    return lab;
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
