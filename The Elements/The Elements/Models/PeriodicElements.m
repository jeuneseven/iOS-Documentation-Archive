//
//  PeriodicElements.m
//  The Elements
//
//  Created by 李占昆 on 2017/8/28.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import "PeriodicElements.h"
#import "AtomicElement.h"

@interface PeriodicElements ()

@property (nonatomic) NSMutableArray *elementsDataSource;

@end

@implementation PeriodicElements

+ (instancetype)sharedPeriodicElements {
    static PeriodicElements *_sharedPeriodicElements = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedPeriodicElements = [[self alloc] init];
    });
    
    return _sharedPeriodicElements;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupElementsArray];
    }
    
    return self;
}

- (void)setupElementsArray {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Elements" ofType:@"plist"];
    NSArray *elementsArray = [NSArray arrayWithContentsOfFile:plistPath];
    
    for (NSDictionary *dic in elementsArray) {
        AtomicElement *element = [[AtomicElement alloc] initWithDictionary:dic];
        [self.elementsDataSource addObject:element];
    }
    
    NSLog(@"self.elementsDataSource == %@", self.elementsDataSource);
}

- (NSMutableArray *)elementsDataSource
{
    if (!_elementsDataSource) {
        _elementsDataSource = [NSMutableArray array];
    }
    
    return _elementsDataSource;
}


@end
