//
//  ElementsSortedByAtomicNumberDataSource.m
//  The Elements
//
//  Created by 李占昆 on 2017/8/11.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import "ElementsSortedByAtomicNumberDataSource.h"
#import "AtomicElementTableViewCell.h"
#import "PeriodicElements.h"

@implementation ElementsSortedByAtomicNumberDataSource

- (NSString *)name {
    return @"AtomicNumber";
}

- (UIColor *)backgroundColor {
    return [UIColor yellowColor];
}

- (NSString *)navigationBarName {
    return @"Sorted by Atomic Number";
}

- (UIImage *)tabBarImage {    
    return [UIImage imageNamed:@"number_gray.png"];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [PeriodicElements sharedPeriodicElements].elementNameIndexArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AtomicElementTableViewCell *cell = (AtomicElementTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AtomicElementTableViewCell class]) forIndexPath:indexPath];
    
    cell.element = [PeriodicElements sharedPeriodicElements].elementNameIndexArray[indexPath.row];
    
    return cell;
}
@end
