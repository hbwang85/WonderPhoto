//
// Created by Haibin Wang on 7/9/15.
// Copyright (c) 2015 Haibin Wang. All rights reserved.
//

#import "GalleryFlowLayout.h"


@implementation GalleryFlowLayout

- (void)awakeFromNib {
    [super awakeFromNib];
    CGRect rect = [UIScreen mainScreen].bounds;
    self.itemSize = CGSizeMake((CGRectGetWidth(rect)-30)/2, (CGRectGetWidth(rect)-30)/2);
    self.minimumLineSpacing = 10;
    self.minimumInteritemSpacing = 10;
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
}


@end