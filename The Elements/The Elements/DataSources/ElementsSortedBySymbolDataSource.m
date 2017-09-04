//
//  ElementsSortedBySymbolDataSource.m
//  The Elements
//
//  Created by 李占昆 on 2017/8/11.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import "ElementsSortedBySymbolDataSource.h"
#import "AtomicElementTableViewCell.h"
#import "PeriodicElements.h"

@implementation ElementsSortedBySymbolDataSource

- (NSString *)name {
    return @"Symbol";
}

- (UIColor *)backgroundColor {
    return [UIColor blueColor];
}

- (NSString *)navigationBarName {
    
    return @"Sorted by Atomic Symbol";
}

- (UIImage *)tabBarImage {
    
    return [UIImage imageNamed:@"symbol_gray.png"];
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
