//
//  CollectionViewCell.m
//  CollectionCardPage
//
//  Created by ymj_work on 16/5/22.
//  Copyright © 2016年 ymj_work. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()

@end

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageV.layer.cornerRadius = 10.f;
        self.imageV.layer.masksToBounds = YES;
        [self.contentView addSubview:self.imageV];
        
    }
    return self;
}

@end

