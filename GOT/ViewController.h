//
//  ViewController.h
//  GOT
//
//  Created by Marek on 03.09.2015.
//  Copyright (c) 2015 Marek Helak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterModel.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDataSource> {
    NSMutableArray *characterArray;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

