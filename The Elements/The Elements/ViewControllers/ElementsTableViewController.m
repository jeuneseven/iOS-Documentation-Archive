//
//  ElementsTableViewController.m
//  The Elements
//
//  Created by 李占昆 on 2017/8/10.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import "ElementsTableViewController.h"
#import "AtomicElementTableViewCell.h"

@interface ElementsTableViewController ()

@end

@implementation ElementsTableViewController

- (void)setDelegate:(id<ElementsDataSourceProtocol, UITableViewDataSource>)delegate {
    _delegate = delegate;
    
    self.title = _delegate.name;
    self.view.backgroundColor = _delegate.backgroundColor;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = _delegate;
    
    [self.tableView registerClass:[AtomicElementTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AtomicElementTableViewCell class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
