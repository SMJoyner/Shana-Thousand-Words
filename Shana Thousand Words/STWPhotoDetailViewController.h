//
//  STWPhotoDetailViewController.h
//  Shana Thousand Words
//
//  Created by Shana Joyner on 12/7/13.
//  Copyright (c) 2013 Mind Activation Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;

@interface STWPhotoDetailViewController : UIViewController

@property (strong, nonatomic) Photo *photo;


@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)addFilterButtonPressed:(UIButton *)sender;


- (IBAction)deleteButtonPressed:(UIButton *)sender;







@end
