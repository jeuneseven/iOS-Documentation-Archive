//
//  PeriodicElements.h
//  The Elements
//
//  Created by 李占昆 on 2017/8/28.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeriodicElements : NSObject

@property (nonatomic, strong) NSArray *elementNameIndexArray;
@property (nonatomic, strong) NSArray *elementsSortedByNumber;
@property (nonatomic, strong) NSArray *elementsSortedBySymbol;

+ (instancetype)sharedPeriodicElements;

@end
