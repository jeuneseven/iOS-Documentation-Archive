//
//  AtomicElement.m
//  The Elements
//
//  Created by 李占昆 on 2017/8/16.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import "AtomicElement.h"

@implementation AtomicElement

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _atomicNumber = [dictionary valueForKey:@"atomicNumber"];
        _atomicWeight = [dictionary valueForKey:@"atomicWeight"];
        _discoveryYear = [dictionary valueForKey:@"discoveryYear"];
        _group = [dictionary valueForKey:@"group"];
        _horizPos = [dictionary valueForKey:@"horizPos"];
        _name = [dictionary valueForKey:@"name"];
        _period = [dictionary valueForKey:@"period"];
        _radioactive = [dictionary valueForKey:@"radioactive"];
        _state = [dictionary valueForKey:@"state"];
        _symbol = [dictionary valueForKey:@"symbol"];
        _vertPos = [dictionary valueForKey:@"vertPos"];
    }
    
    return self;
}

@end
