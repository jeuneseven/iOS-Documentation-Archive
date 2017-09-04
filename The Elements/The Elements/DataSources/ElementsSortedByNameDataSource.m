//
//  ElementsSortedByNameDataSource.m
//  The Elements
//
//  Created by 李占昆 on 2017/8/11.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import "ElementsSortedByNameDataSource.h"
#import "AtomicElementTableViewCell.h"
#import "PeriodicElements.h"

@implementation ElementsSortedByNameDataSource

- (NSString *)name {
    return @"name";
}

- (UIColor *)backgroundColor {
    return [UIColor redColor];
}

- (NSString *)navigationBarName {
    return @"Sorted by Name";
}

- (UIImage *)tabBarImage {
    return [UIImage imageNamed:@"name_gray"];
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
