//
//  XYZPerson.m
//  Objective-C Exercises
//
//  Created by kkk on 17/6/3.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import "XYZPerson.h"

@implementation XYZPerson

- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName dateOfBirth:(NSDate *)birthDate {
    self = [super init];
    if (self) {
        _firstName = firstName;
        _lastName = lastName;
        _dateOfBirth = birthDate;
    }
    
    return self;
}

- (instancetype)init {
    return [self initWithFirstName:@"jeune" lastName:@"seven" dateOfBirth:[NSDate date]];
}

+ (XYZPerson *)personWithFirstName:(NSString *)firstName lastName:(NSString *)lastName dateOfBirth:(NSDate *)birthDate {
    return [[self alloc] initWithFirstName:firstName lastName:lastName dateOfBirth:birthDate];
}

+ (XYZPerson *)person {
    return [[self alloc] init];
}

- (void)dealloc {
    NSLog(@"XYZPerson is being deallocated");
}

- (void)sayHello {
    NSString *string = [NSString stringWithFormat:@"Hello %@ %@", self.firstName, self.lastName];
    [self saySomething:string];
}

- (void)saySomething:(NSString *)greeting {
    NSLog(@"%@", greeting);
}

@end
