//
//  ElementsTableViewController.h
//  The Elements
//
//  Created by 李占昆 on 2017/8/10.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ElementsDataSourceProtocol.h"

@interface ElementsTableViewController : UITableViewController

@property (nonatomic, strong) id <ElementsDataSourceProtocol> delegate;

@end
