//
//  CustomTableViewCell.h
//  GamePlatform
//
//  Created by hehao on 15/8/31.
//  Copyright (c) 2015年 kuaifa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIImageView *bigImgView;
@property(nonatomic,strong)UILabel *bigLabel;
@property(nonatomic,strong)UILabel *bigLabel2;
- (instancetype )initWithNumberOneStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
