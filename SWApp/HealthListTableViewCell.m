//
//  HealthListTableViewCell.m
//  SWApp
//
//  Created by hhsoft on 16/8/11.
//  Copyright © 2016年 swq. All rights reserved.
//

#import "HealthListTableViewCell.h"
#import "HealthListInfo.h"
#import "UIImageView+WebCache.h"
#import "UIColor+CustomColors.h"

@interface HealthListTableViewCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UIImageView *infoImageView;

@end
@implementation HealthListTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self drawCell];
    }
    return self;
}
-(void)drawCell{

    _infoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 60, 80)];
    _infoImageView.contentMode = UIViewContentModeScaleAspectFill;
    _infoImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_infoImageView];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_infoImageView.frame)+10, 10, self.frame.size.width-_infoImageView.frame.size.width-40, 20)];
    _titleLabel.textColor = [UIColor customBlackColor];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    
    [self.contentView addSubview:_titleLabel];
    
    _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_infoImageView.frame)+10, CGRectGetMaxY(_titleLabel.frame)+10, self.frame.size.width-_infoImageView.frame.size.width-40, 50)];
    _detailLabel.textColor = [UIColor customGrayColor];
    _detailLabel.font = [UIFont systemFontOfSize:14];
    _detailLabel.numberOfLines = 100;
    [self.contentView addSubview:_detailLabel];

}
-(void)setHealthListInfo:(HealthListInfo *)healthListInfo{

    [_infoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://tnfs.tngou.net/img%@",healthListInfo.healthListImg]] placeholderImage:[UIImage imageNamed:@"default"]];
    _titleLabel.text = healthListInfo.healthListTitle;
    _detailLabel.text = healthListInfo.healthListDescription;
}
    
@end
