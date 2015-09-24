//
//  HudViewController.h
//  CustonHud
//
//  Created by hehao on 15/9/24.
//  Copyright © 2015年 kuaifa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HudViewController : UIViewController
+ (instancetype)sharedClient;
- (void)createCustomHudWithSuperView :(UIView *)superView andLoadText:(NSString *)loadText;
- (void)hideThisHud;
@end
