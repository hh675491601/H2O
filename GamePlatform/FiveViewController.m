//
//  FiveViewController.m
//  GamePlatform
//
//  Created by hehao on 15/8/27.
//  Copyright (c) 2015年 kuaifa. All rights reserved.
//

#import "FiveViewController.h"
#import "CustomTableViewCell.h"

#define kReuserId @"cell"
#define kReuserId2 @"cell1"
@interface FiveViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation FiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的";
    [self createCustomView];
    [self createCustomTableView];
}
#pragma mark - UI
- (void)createCustomView
{
    //left
    UIImage* backImage = [UIImage imageNamed:@"userinfo@2x.png"];
    CGRect backframe = CGRectMake(0,0,35,35);
    UIButton* leftButton= [[UIButton alloc] initWithFrame:backframe];
    [leftButton setBackgroundImage:backImage forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(left) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    //right
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 35, 35);
    [rightButton setBackgroundImage:[UIImage imageNamed:@"email@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
- (void)createCustomTableView
{
    UITableView *staticTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    staticTableView.delegate = self;
    staticTableView.dataSource = self;
    [self.view addSubview:staticTableView];
}
#pragma mark - 绑定的方法
- (void)left
{
    
}
- (void)right
{
    
}
#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else if (section == 1)
    {
        return 2;
    }
    else if (section == 2)
    {
        return 3;
    }
    else if (section == 3)
    {
        return 1;
    }
    else
    {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuserIdentifier= kReuserId;
    static NSString *otherReuserIdentifier= kReuserId2;
    CustomTableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentifier];
    if (!cell)
    {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIdentifier];
    }
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        cell = [[CustomTableViewCell alloc] initWithNumberOneStyle:UITableViewCellStyleDefault reuseIdentifier:otherReuserIdentifier];
        cell.bigLabel.text = @"全球领先,独家科研技术";
        cell.bigLabel2.text = @"绑定apple ID永不闪退";
        cell.bigLabel2.textColor = [UIColor grayColor];
        cell.bigImgView.image = [UIImage imageNamed:@"btn_home.png"];
    }
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        cell.label.text = @"下载中心";
        cell.imgView.image = [UIImage imageNamed:@"btn_home.png"];
    }
    if (indexPath.section == 1 && indexPath.row == 1)
    {
        cell.label.text = @"软件更新";
        cell.imgView.image = [UIImage imageNamed:@"btn_home.png"];
    }
    if (indexPath.section == 2 && indexPath.row == 0)
    {
        cell.label.text = @"活动中心";
        cell.imgView.image = [UIImage imageNamed:@"btn_home.png"];
    }
    if (indexPath.section == 2 && indexPath.row == 1)
    {
        cell.label.text = @"修复闪退";
        cell.imgView.image = [UIImage imageNamed:@"btn_home.png"];
    }
    if (indexPath.section == 2 && indexPath.row == 2)
    {
        cell.label.text = @"设备授权";
        cell.imgView.image = [UIImage imageNamed:@"btn_home.png"];
    }
    if (indexPath.section == 3 && indexPath.row == 0)
    {
        cell.label.text = @"设置";
        cell.imgView.image = [UIImage imageNamed:@"btn_home.png"];
    }
    if (indexPath.section == 4 && indexPath.row == 0)
    {
        cell.label.text = @"更多";
        cell.imgView.image = [UIImage imageNamed:@"btn_home.png"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return 64;
    }
    else
    {
        return 44;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
