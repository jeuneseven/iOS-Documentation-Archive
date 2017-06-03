//
//  XYZPerson.h
//  Objective-C Exercises
//
//  Created by kkk on 17/6/3.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZPerson : NSObject

@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSDate *dateOfBirth;

- (void)sayHello;
- (void)saySomething:(NSString *)greeting;

+ (XYZPerson *)person;

@end
