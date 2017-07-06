//
//  UserCommentCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/24.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "UserCommentCell.h"
#import "UIButton+Utilities.h"
#import "NSString+Utilities.h"

@implementation ImageCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addImageview];
    }
    return self;
}


- (void)addImageview {
    self.imageview = ({
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self.contentView addSubview:imageView];
        imageView;
    });
    
    [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}

- (void)updateUrlString:(NSString *)url {
    self.urlString = url;
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage placeholderImage] options:SDWebImageCacheMemoryOnly];
}

@end


@implementation UserCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureCell];
}


- (void)layoutSubviews {
    [super layoutSubviews];
}


- (void)configureCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentLabel.lineSpacing = 1;
    [self.contentLabel sizeToFit];
    [self.starView updateForeImage:@"total_yellow_star" backImage:@"total_gray_star"];
    [self.commentButton makeCornerBorderWithWidth:1 cornerRadius:self.commentButton.height / 2.0 borderColor:[UIColor colorWithIntRed:179 green:179 blue:179 alpha:1]];
    [self.favourButton makeCornerBorderWithWidth:1 cornerRadius:self.commentButton.height / 2.0 borderColor:[UIColor colorWithIntRed:179 green:179 blue:179 alpha:1]];
    [self configureCollectionView];
    [self.headView updateCompanyStatusViewHeight:10 personHeight:15];
}


- (void)configureCollectionView {
    self.layout = [[UICollectionViewFlowLayout alloc]init];
    self.layout.minimumInteritemSpacing = 5;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.layout.itemSize = CGSizeMake(80, 80);
    
    self.collectionView.dataSource = self;
    self.collectionView.collectionViewLayout = self.layout;
    [self.collectionView registerClass:[ImageCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([ImageCollectionCell class])];
}


#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.img_url.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ImageCollectionCell class]) forIndexPath:indexPath];
    UserDpImaUrlModel *model = self.model.img_url[indexPath.row];
    [cell updateUrlString:model.img_url];
    return cell;
}


#pragma mark - actionMethod

- (IBAction)commentAction:(UIButton *)sender {
    if (!USERSid) {
        [self alertToLogin];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(userCommentCellDidCilckComment:)]) {
        [self.delegate userCommentCellDidCilckComment:self];
    }
}

- (IBAction)favourAction:(UIButton *)sender {
    if (self.favourButton.selected) return;
    if (!USERSid) {
        [self alertToLogin];
        return;
    }
    self.favourButton.selected = YES;
    self.model.is_star = @"1";
    self.model.star = @([self.model.star intValue] + 1);
    [self button:self.favourButton setTitle:[NSString stringWithCount:[self.model.star intValue]]];
    if ([self.delegate respondsToSelector:@selector(userCommentCellDidCilckFavour:)]) {
        [self.delegate userCommentCellDidCilckFavour:self];
    }
}


#pragma mark - publicMethod

- (void)updateBiaoQianModel:(BiaoQianModel *)model {
    self.model = model;
    [self.headView updateImageUrlString:model.head_image];
    if ([model.company_vip boolValue]) {
        [self.headView updateHeadStatus:kCompanyVip];
    }else if ([model.person_vip boolValue]) {
        [self.headView updateHeadStatus:kPersonVip];
    }else {
        [self.headView updateHeadStatus:kNormal];
    }
    self.nameLabel.text = model.uname;
    [self.starView updateScore:[model.score floatValue] / 5.0];
    self.scoreLabel.text = [NSString stringWithFormat:@"%@.0分",model.score];
    self.timeLabel.text = [[model.time_h componentsSeparatedByString:@" "] firstObject];
    self.contentLabel.text = model.content;
    self.creamImageView.hidden = ![model.is_good boolValue];
    [self updateContentImageViewWithImages:model.img_url];
    self.favourButton.selected = [model.is_star boolValue];
    [self button:self.favourButton setTitle:[NSString stringWithCount:[model.star intValue] stringWhenZero:@"赞"]];
    [self.commentButton setTitle:[NSString stringWithCount:[model.reply_nums intValue] stringWhenZero:@"评论"] forState:UIControlStateNormal];
    [self.collectionView reloadData];
}



#pragma mark - helpMethod

- (void)updateContentImageViewWithImages:(NSArray *)images {
    if (!images || images.count == 0) {
        [self updateImageViewConstraintWithHeight:2];
        self.layout.itemSize = CGSizeMake(2, 2);
    }else if (images.count == 1) {
        [self updateImageViewConstraintWithHeight:120];
        self.layout.itemSize = CGSizeMake(120, 120);
    }else {
        [self updateImageViewConstraintWithHeight:80];
        self.layout.itemSize = CGSizeMake(80, 80);
        
    }
    [self.layout invalidateLayout];
    [self.collectionView reloadData];
}

- (void)updateImageViewConstraintWithHeight:(CGFloat)height {
    self.contentLabelBottomToContentImageViewTop.constant = height == 2 ? 0 : 15;
    self.collectionContainerHeight.constant = height;
    [self layoutIfNeeded];
}

- (void)imageViewLoadImage:(UIImageView *)imageView url:(NSString *)url {
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage placeholderImage] options:SDWebImageCacheMemoryOnly];
}


- (void)button:(UIButton *)button setTitle:(NSString *)title {
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];
    [self layoutSubviews];
}

- (void)alertToLogin {
    if ([self.delegate respondsToSelector:@selector(userCommentCellAlertToLogin:)]) {
        [self.delegate userCommentCellAlertToLogin:self];
    }
}


@end
