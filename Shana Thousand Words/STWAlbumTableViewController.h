//
//  STWAlbumTableViewController.h
//  Shana Thousand Words
//
//  Created by Shana Joyner on 12/6/13.
//  Copyright (c) 2013 Mind Activation Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STWAlbumTableViewController : UITableViewController 


@property (strong, nonatomic) NSMutableArray *albums;

- (IBAction)addBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
