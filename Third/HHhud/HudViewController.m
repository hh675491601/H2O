//
//  HudViewController.m
//  CustonHud
//
//  Created by hehao on 15/9/24.
//  Copyright © 2015年 kuaifa. All rights reserved.
//

#import "HudViewController.h"

int a = 0;
@interface HudViewController ()
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UILabel *bottomLab;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)UIImageView *imgView;
@end

@implementation HudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
+ (instancetype)sharedClient {
    
    static HudViewController *_sharedClient = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[HudViewController alloc] init];
        
    }); 
    
    return _sharedClient; 
    
}
- (void)createCustomHudWithSuperView :(UIView *)superView andLoadText:(NSString *)loadText
{
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 50, [UIScreen mainScreen].bounds.size.height/2 - 50, 100, 100)];
    NSLog(@"%@",NSStringFromCGRect(self.bottomView.frame));
    self.bottomView.backgroundColor = [UIColor grayColor];
    [superView addSubview:self.bottomView];
    // customhud
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bottomView.bounds.size.width/2 - 20, 10, 40, 40)];
    [self.bottomView addSubview:self.imgView];
    //gcd
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(createFPSanimated) userInfo:nil repeats:YES];
        });
    });
    // label
    self.bottomLab = [[UILabel alloc] initWithFrame:CGRectMake(self.bottomView.bounds.size.width/2 - 50 , self.bottomView.bounds.size.height - 60, 100, 60)];
    self.bottomLab.text = loadText;
    self.bottomLab.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:self.bottomLab];

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerBottomLeft |UIRectCornerTopLeft|UIRectCornerTopRight |UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bottomView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.bottomView.layer.mask = maskLayer;
}
//animated
- (void)createFPSanimated
{
    a = a++ > 5 ? 1 :a;
    self.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"lee－%d.tiff",a]];
}
// hidehud
- (void)hideThisHud
{
    [self.imgView removeFromSuperview];
    self.imgView = nil;
    [self.bottomLab removeFromSuperview];
    self.bottomLab = nil;
    [self.bottomView removeFromSuperview];
    self.bottomView = nil;
    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"imgview::%@,lab::%@,view::%@,timer::%@",self.imgView,self.bottomLab,self.bottomView,self.timer);
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
