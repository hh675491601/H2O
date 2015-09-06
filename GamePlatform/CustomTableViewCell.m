//
//  CustomTableViewCell.m
//  GamePlatform
//
//  Created by hehao on 15/8/31.
//  Copyright (c) 2015年 kuaifa. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell
// rowHeight 44
- (instancetype )initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUserInterface];
    }
    return self;
}
- (void)initUserInterface
{
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(80, 10 * SCREEN_HEIGHTSCALE, 250 * SCREEN_WIDTHSCALE, 20 * SCREEN_HEIGHTSCALE)];
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.label];
}
// rowHeight 64
- (instancetype )initWithNumberOneStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self otherInitUserInterface];
    }
    return self;
}
- (void)otherInitUserInterface
{
    self.bigImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 7, 50, 50)];
    self.bigLabel = [[UILabel alloc] initWithFrame:CGRectMake(80,6, 250 * SCREEN_WIDTHSCALE, 20 * SCREEN_HEIGHTSCALE)];
    self.bigLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 38, 250 * SCREEN_WIDTHSCALE, 20 * SCREEN_HEIGHTSCALE)];
    [self.contentView addSubview:self.bigImgView];
    [self.contentView addSubview:self.bigLabel];
    [self.contentView addSubview:self.bigLabel2];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
