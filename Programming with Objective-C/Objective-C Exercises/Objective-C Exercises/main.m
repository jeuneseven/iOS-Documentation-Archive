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
        
        XYZPerson *strongPerson = [XYZPerson person];
        strongPerson = nil;
        
        __weak XYZPerson *weakPerson = [XYZPerson person];
        
        XYZPerson *person = [XYZPerson person];
        person.firstName = @"jeune";
        person.lastName = @"seven";
        [person sayHello];
        person = nil;
        
        NSMutableString *firstNameString = [[NSMutableString alloc] initWithString:@"jeu"];
        XYZPerson *secondPerson = [[XYZPerson alloc] init];
        secondPerson.firstName = firstNameString;
        [firstNameString appendString:@"ne"];
        [secondPerson sayHello];
        secondPerson = nil;
        
        XYZPerson *otherPerson;
        if (!otherPerson) {
            NSLog(@"otherPerson default nil");
        }
        
        XYZShoutingPerson *shoutingPerson = [XYZShoutingPerson person];
        [shoutingPerson sayHello];
        shoutingPerson = nil;
        
        XYZPerson *somePerson = [XYZPerson person];
        [somePerson measureHeight:123];
        [somePerson measureWeight:456];
        NSLog(@"somePerson.height == %f somePerson.weight == %f", somePerson.height, somePerson.weight);
    }
    return 0;
}
