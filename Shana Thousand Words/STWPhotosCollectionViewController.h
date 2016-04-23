//
//  STWPhotosCollectionViewController.h
//  Shana Thousand Words
//
//  Created by Shana Joyner on 12/6/13.
//  Copyright (c) 2013 Mind Activation Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"


@interface STWPhotosCollectionViewController : UICollectionViewController

@property (strong, nonatomic) Album *album;


- (IBAction)cameraBarButtonItemPressed:(UIBarButtonItem *)sender;





@end
