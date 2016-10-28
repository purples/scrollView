//
//  LSScrollCycleCell.m
//  ScrollCycle
//
//  Created by 李景景 on 16/10/27.
//  Copyright © 2016年 Linkstores. All rights reserved.
//

#import "LSScrollCycleCell.h"

@interface LSScrollCycleCell ()

@property (nonatomic, strong) UIImageView                   *imgView;

@end


@implementation LSScrollCycleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imgView.frame = self.contentView.bounds;
}

- (void)setImgName:(NSString *)imgName
{
    self.imgView.image = [UIImage imageNamed:imgName];
}

@end
