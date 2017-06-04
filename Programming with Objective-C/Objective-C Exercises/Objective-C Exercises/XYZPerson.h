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

@property (assign, readonly, nonatomic) float height;
@property (assign, readonly, nonatomic) float weight;

- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName dateOfBirth:(NSDate *)birthDate;
+ (XYZPerson *)person;
+ (XYZPerson *)personWithFirstName:(NSString *)firstName lastName:(NSString *)lastName dateOfBirth:(NSDate *)birthDate;

- (void)sayHello;
- (void)saySomething:(NSString *)greeting;

- (void)measureWeight:(float)personWeight;
- (void)measureHeight:(float)personHeight;

@end
