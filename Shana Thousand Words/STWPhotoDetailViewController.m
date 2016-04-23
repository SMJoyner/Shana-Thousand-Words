//
//  STWPhotoDetailViewController.m
//  Shana Thousand Words
//
//  Created by Shana Joyner on 12/7/13.
//  Copyright (c) 2013 Mind Activation Code. All rights reserved.
//

#import "STWPhotoDetailViewController.h"
#import "Photo.h"
#import "STWFiltersCollectionViewController.h"



@interface STWPhotoDetailViewController ()

@end

@implementation STWPhotoDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    self.imageView.image = self.photo.image;
    
    
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"FilterSegue"]){
        if ([segue.destinationViewController isKindOfClass:[STWFiltersCollectionViewController class]]) {
            STWFiltersCollectionViewController *targetViewController = segue.destinationViewController;
            targetViewController.photo = self.photo;
            
        }
    }
    
    
    
    
    
    
    
    
    
    
}









- (IBAction)addFilterButtonPressed:(UIButton *)sender {
}

- (IBAction)deleteButtonPressed:(UIButton *)sender {
    
    [[self.photo managedObjectContext] deleteObject:self.photo];
    
    NSError *error = nil;
    [[self.photo managedObjectContext] save:&error];
    if(error){
        NSLog(@"error");//just to check if working
        
    }
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
    
    
}
@end
