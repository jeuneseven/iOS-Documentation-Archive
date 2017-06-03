//
//  main.m
//  Objective-C Exercises
//
//  Created by kkk on 17/6/3.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYZPerson.h"
#import "XYZShoutingPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        XYZPerson *person = [XYZPerson person];
        person.firstName = @"jeune";
        person.lastName = @"seven";
        [person sayHello];
        
        XYZPerson *otherPerson;
        if (!otherPerson) {
            NSLog(@"otherPerson default nil");
        }
        
        XYZShoutingPerson *shoutingPerson = [XYZShoutingPerson person];
        [shoutingPerson sayHello];
    }
    return 0;
}
