//
//  AtomicElementTableViewCell.m
//  The Elements
//
//  Created by 李占昆 on 2017/8/15.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import "AtomicElementTableViewCell.h"
#import "AtomicElement.h"

@interface AtomicElementTableViewCell ()

@property (nonatomic) UILabel *titleLabel;

@end

@implementation AtomicElementTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
    }
    
    return self;
}

- (void)setElement:(AtomicElement *)element {
    _element = element;
    
    self.titleLabel.text = _element.atomicWeight;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        _titleLabel.textColor = [UIColor blackColor];
    }
    
    return _titleLabel;
}


@end
