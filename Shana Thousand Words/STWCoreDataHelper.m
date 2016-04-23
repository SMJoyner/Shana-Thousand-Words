//
//  STWCoreDataHelper.m
//  Shana Thousand Words
//
//  Created by Shana Joyner on 12/6/13.
//  Copyright (c) 2013 Mind Activation Code. All rights reserved.
//

#import "STWCoreDataHelper.h"

@implementation STWCoreDataHelper

+(NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    
    id delegate = [[UIApplication sharedApplication] delegate];
    
    
    if ([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
        
    }
    
    
    
    
    return context;
    
    
}
@end
