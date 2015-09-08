//
//  FourViewController.m
//  GamePlatform
//
//  Created by hehao on 15/8/27.
//  Copyright (c) 2015年 kuaifa. All rights reserved.
//

#import "FourViewController.h"

#define kReuserId11 @"cell1"
#define kReuserId22 @"cell2"
#define kReuserId33 @"cell3"
#define kReuserId44 @"cell4"

@interface FourViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UISegmentedControl *seg;
@property(nonatomic,strong)UISearchBar *search;
@property(nonatomic,strong)UIScrollView *scr;
@property(nonatomic,strong)UITableView *tableView11;
@property(nonatomic,strong)UITableView *tableView22;
@property(nonatomic,strong)UITableView *tableView33;
@property(nonatomic,strong)UITableView *tableView44;

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self createSearch];
    [self createSegmentedControl];
    [self createBigScrollView];
    [self createTableView];//顺序
}
#pragma mark - UI
- (void)createBigScrollView
{
    self.scr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20 + 44 + 24, 320*SCREEN_WIDTHSCALE, 480*SCREEN_HEIGHTSCALE - 20 - 44  - 24 - 49)];
    //    self.scr.backgroundColor = [UIColor blackColor];
    self.scr.pagingEnabled = YES;
    self.scr.delegate = self;
    self.scr.backgroundColor = [UIColor blueColor];
    self.scr.contentSize = CGSizeMake(320*SCREEN_WIDTHSCALE * 4, 150*SCREEN_HEIGHTSCALE);
    [self.view addSubview:self.scr];
}

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
    self.seg = [[UISegmentedControl alloc] initWithItems:@[@"热门",@"精选",@"新锐",@"分类"]];
    self.seg.frame = CGRectMake(50*SCREEN_WIDTHSCALE, 64, 220*SCREEN_WIDTHSCALE, 24);
    self.seg.selectedSegmentIndex = 0;
    [self.seg addTarget:self action:@selector(clickSeg:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.seg];
    
}
- (void)createTableView
{
    //1
    self.tableView11 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320*SCREEN_WIDTHSCALE, 480*SCREEN_HEIGHTSCALE - 20 - 44  - 24 - 49) style:UITableViewStylePlain];
    self.tableView11.tag = 30;
    self.tableView11.dataSource = self;
    self.tableView11.delegate = self;
    [self.scr addSubview:self.tableView11];
    //2
    self.tableView22 = [[UITableView alloc] initWithFrame:CGRectMake(320*SCREEN_WIDTHSCALE, 0, 320*SCREEN_WIDTHSCALE, 480*SCREEN_HEIGHTSCALE - 20 - 44  - 24 - 49) style:UITableViewStylePlain];
    self.tableView22.tag = 31;
    self.tableView22.backgroundColor = [UIColor blueColor];
    self.tableView22.dataSource = self;
    self.tableView22.delegate = self;
    [self.scr addSubview:self.tableView22];
    //3
    self.tableView33 = [[UITableView alloc] initWithFrame:CGRectMake(640*SCREEN_WIDTHSCALE, 0, 320*SCREEN_WIDTHSCALE, 480*SCREEN_HEIGHTSCALE - 20 - 44  - 24 - 49) style:UITableViewStylePlain];
    self.tableView33.tag = 32;
    self.tableView33.backgroundColor = [UIColor purpleColor];
    self.tableView33.dataSource = self;
    self.tableView33.delegate = self;
    [self.scr addSubview:self.tableView33];
    //4
    self.tableView44 = [[UITableView alloc] initWithFrame:CGRectMake(960*SCREEN_WIDTHSCALE, 0, 320*SCREEN_WIDTHSCALE, 480*SCREEN_HEIGHTSCALE - 20 - 44  - 24 - 49) style:UITableViewStylePlain];
    self.tableView44.tag = 33;
    self.tableView44.backgroundColor = [UIColor purpleColor];
    self.tableView44.dataSource = self;
    self.tableView44.delegate = self;
    [self.scr addSubview:self.tableView44];
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
}
// 手势方法
- (void)taptap
{
    [self.search resignFirstResponder];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier1 = kReuserId11;
    static NSString *reuseIdentifier2 = kReuserId22;
    static NSString *reuseIdentifier3 = kReuserId33;
    static NSString *reuseIdentifier4 = kReuserId44;
    UITableViewCell *cell = nil;
    if (tableView.tag == 30)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier1];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier1];
        }
        cell.textLabel.text = @"热门";
    }
    if (tableView.tag == 31)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier2];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier2];
        }
        cell.textLabel.text = @"精选";
    }
    if (tableView.tag == 32)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier3];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier3];
        }
        cell.textLabel.text = @"新锐";
    }
    if (tableView.tag == 33)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier4];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier4];
        }
        cell.textLabel.text = @"分类";
    }
    return cell;
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
