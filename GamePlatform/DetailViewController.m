//
//  DetailViewController.m
//  GamePlatform
//
//  Created by hehao on 15/9/10.
//  Copyright (c) 2015年 kuaifa. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+WebCache.h"
@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)Travels *travel;
@end

@implementation DetailViewController
- (id)initWithPara:(Travels *)sender
{
    if (self == [super init])
    {
        self.travel = sender;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.tabBar.hidden = YES;
    [self createTableView];
    [self createBackBtn];
    [self createTableViewHeader];
}
#pragma mark -- 区头 + 表头
// 区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    vi.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"userinfo@2x.png"] forState:UIControlStateNormal];
    btn1.frame = CGRectMake(5 * SCREEN_WIDTHSCALE, 5 * SCREEN_HEIGHTSCALE, 35, 35);
    [vi addSubview:btn1];
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(40 * SCREEN_WIDTHSCALE, 12 * SCREEN_HEIGHTSCALE, 100, 20)];
    lab1.text = self.travel.userName;
    lab1.textColor = [UIColor grayColor];
    [vi addSubview:lab1];

    return vi;
}
// 表头
- (void)createTableViewHeader
{
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320 *SCREEN_WIDTHSCALE, 200 * SCREEN_HEIGHTSCALE)];
    [img setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.517huwai.com%@",self.travel.cover]]];
    [self.view addSubview:img];
    self.tableView.tableHeaderView = img;
}
#pragma mark -- tableView
- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 480 * SCREEN_HEIGHTSCALE - 20) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    static NSString *reuseIdentifier = @"cell";
    cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.textLabel.text = self.travel.title;
    return cell;
}
#pragma mark -- back btn
- (void)createBackBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 30, 50, 50);
    [btn setTitle:@"back" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithRed:80.0/255 green:78.0/255 blue:78.0/255 alpha:0.5];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:UIRectCornerBottomLeft |UIRectCornerTopLeft|UIRectCornerTopRight |UIRectCornerBottomRight cornerRadii:CGSizeMake(25, 25)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = btn.bounds;
    maskLayer.path = maskPath.CGPath;
    btn.layer.mask = maskLayer;
    
    [self.view addSubview:btn];
}
- (void)back
{
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
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
