//
//  XYZPerson+OC.m
//  Objective-C Exercises
//
//  Created by kkk on 17/6/4.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import "XYZPerson+OC.h"

@implementation XYZPerson (OC)

- (void)displayName {
    NSLog(@"%@%@", self.lastName, self.firstName);
}

@end
