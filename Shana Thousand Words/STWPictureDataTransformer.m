//
//  STWPictureDataTransformer.m
//  Shana Thousand Words
//
//  Created by Shana Joyner on 12/7/13.
//  Copyright (c) 2013 Mind Activation Code. All rights reserved.
//

#import "STWPictureDataTransformer.h"

@implementation STWPictureDataTransformer

//store info as NSData class
+(Class)transformedValueClass
{
    
    return [NSData class];
    
}

//method says we can reverse
+(BOOL)allowsReverseTransformation
{
    return YES;
    
}

//convert image to data
-(id)transformedValue:(id)value
{
    
    return UIImagePNGRepresentation(value);
    
}

//convert data to image
- (id)reverseTransformedValue:(id)value
{
    
    UIImage *image = [UIImage imageWithData:value];
    return image;
    
}






@end
