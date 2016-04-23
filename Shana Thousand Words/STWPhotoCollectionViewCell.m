//
//  STWPhotoCollectionViewCell.m
//  Shana Thousand Words
//
//  Created by Shana Joyner on 12/6/13.
//  Copyright (c) 2013 Mind Activation Code. All rights reserved.
//

#import "STWPhotoCollectionViewCell.h"

#define IMAGEVIEW_BORDER_LENGTH 5


@implementation STWPhotoCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}


-(void)setup
{
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, IMAGEVIEW_BORDER_LENGTH, IMAGEVIEW_BORDER_LENGTH)];
    
    [self.contentView addSubview: self.imageView];
    
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
