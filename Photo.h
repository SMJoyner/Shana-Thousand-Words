//
//  Photo.h
//  Shana Thousand Words
//
//  Created by Shana Joyner on 12/7/13.
//  Copyright (c) 2013 Mind Activation Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Album;

@interface Photo : NSManagedObject

@property (nonatomic, retain) id image;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) Album *albumBook;

@end
