//
//  STWPhotosCollectionViewController.m
//  Shana Thousand Words
//
//  Created by Shana Joyner on 12/6/13.
//  Copyright (c) 2013 Mind Activation Code. All rights reserved.
//

#import "STWPhotosCollectionViewController.h"
#import "STWPhotoCollectionViewCell.h"
#import "Photo.h"
#import "STWPictureDataTransformer.h"
#import "STWCoreDataHelper.h"
#import "STWPhotoDetailViewController.h"



@interface STWPhotosCollectionViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSMutableArray *photos; // of UIImages


@end

@implementation STWPhotosCollectionViewController


- (NSMutableArray *)photos
{
    if (!_photos) {
        _photos = [[NSMutableArray alloc]init];
        
    }
    return _photos;
    
    
}






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

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    
    
    NSSet *unorderedPhotos = self.album.photos;
    
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    
    NSArray *sortedPhotos = [unorderedPhotos sortedArrayUsingDescriptors:@[dateDescriptor]];
    
    self.photos = [sortedPhotos mutableCopy];
    
    [self.collectionView reloadData];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DetailSegue"])
    {
    
        if ([segue.destinationViewController isKindOfClass:[STWPhotoDetailViewController class]]) {
            STWPhotoDetailViewController *targetViewController = segue.destinationViewController;
            NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems]lastObject];
            
            Photo *selectedPhoto = self.photos[indexPath.row];
            targetViewController.photo = selectedPhoto;
            
        }
    
    }
    
    
}











#pragma mark - UICollectionView DataSource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PhotoCell";
    STWPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Photo *photo = self.photos[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.imageView.image = photo.image;
    
    return cell;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return [self.photos count];
       
    
}

#pragma mark - helper methods

- (Photo *)photoFromImage:(UIImage *)image
{
    
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:[STWCoreDataHelper managedObjectContext]];
    photo.image = image;
    photo.date = [NSDate date];
    photo.albumBook = self.album;
    
    NSError *error = nil;
    if(![[photo managedObjectContext] save:&error]){
        //Error in saving
        NSLog(@"%@",error);
        
    }
    return photo;
    
    
}


#pragma mark - UIImagePickerControllerDelegate


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    [self.photos addObject:[self photoFromImage:image]];
    
    [self.collectionView reloadData];
    
    
 //   NSLog(@"Finished Picking");
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
 //   NSLog(@"Cancel");
    [self dismissViewControllerAnimated:YES completion:nil];
    
}





#pragma mark - IBAction method

- (IBAction)cameraBarButtonItemPressed:(UIBarButtonItem *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    }
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
    }
    
    [self presentViewController:picker animated:YES completion:nil];
    
    
}
















@end
