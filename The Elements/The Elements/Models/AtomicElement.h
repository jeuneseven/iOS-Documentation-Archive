//
//  AtomicElement.h
//  The Elements
//
//  Created by 李占昆 on 2017/8/16.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AtomicElement : NSObject

@property (nonatomic, strong) NSNumber *atomicNumber;
@property (nonatomic, strong) NSString *atomicWeight;
@property (nonatomic, strong) NSString *discoveryYear;
@property (nonatomic, strong) NSNumber *group;
@property (nonatomic, strong) NSNumber *horizPos;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *period;
@property (nonatomic, strong) NSString *radioactive;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSNumber *vertPos;

//@property (weak, readonly) UIImage *flipperImageForAtomicElementNavigationItem;
//@property (weak, readonly) UIImage *stateImageForAtomicElementTileView;
//@property (weak, readonly) UIImage *stateImageForAtomicElementView;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
