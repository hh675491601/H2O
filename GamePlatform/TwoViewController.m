//
//  TwoViewController.m
//  GamePlatform
//
//  Created by hehao on 15/8/27.
//  Copyright (c) 2015年 kuaifa. All rights reserved.
//

#import "TwoViewController.h"

#define kReuserIdOne @"cell1"
#define kReuserIdTwo @"cell2"
#define kReuserIdThree @"cell3"
@interface TwoViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIScrollView *scr;
@property(nonatomic,strong)UISegmentedControl *seg;
@property(nonatomic,strong)UITableView *leftTableView;
@property(nonatomic,strong)UITableView *midTableView;
@property(nonatomic,strong)UITableView *rightTableView;
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self createSegmentedControl];
    [self createScrollView];
    [self createThreeTableView];
    
    NSLog(@"%f",self.tabBarController.tabBar.bounds.size.height);
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
    return 20;
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
        cell.textLabel.text = @"left";
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
// seg绑定的方法
- (void)clickSeg:(id)sender
{
    NSLog(@"我点了%d",self.seg.selectedSegmentIndex);
    CGPoint offset = CGPointMake(self.seg.selectedSegmentIndex * 320 * SCREEN_WIDTHSCALE, 0);
    [self.scr setContentOffset:offset animated:YES];
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
