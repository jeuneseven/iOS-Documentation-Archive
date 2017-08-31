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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)setElement:(AtomicElement *)element {
    _element = element;
    
    self.titleLabel.text = _element.name;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        _titleLabel.textColor = [UIColor blackColor];
    }
    
    return _titleLabel;
}


@end
