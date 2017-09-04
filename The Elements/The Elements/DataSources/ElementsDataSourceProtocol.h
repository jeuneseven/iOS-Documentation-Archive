//
//  ElementsDataSourceProtocol.h
//  The Elements
//
//  Created by 李占昆 on 2017/8/11.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ElementsDataSourceProtocol <NSObject>

@property (readonly) NSString *name;
@property (readonly) UIColor *backgroundColor;

@property (readonly) UIImage *tabBarImage;
@property (readonly) NSString *navigationBarName;

@end
