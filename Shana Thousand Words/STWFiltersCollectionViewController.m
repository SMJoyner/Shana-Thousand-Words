//
//  STWFiltersCollectionViewController.m
//  Shana Thousand Words
//
//  Created by Shana Joyner on 12/7/13.
//  Copyright (c) 2013 Mind Activation Code. All rights reserved.
//

#import "STWFiltersCollectionViewController.h"
#import "STWPhotoCollectionViewCell.h"
#import "Photo.h"


@interface STWFiltersCollectionViewController ()

@property (strong, nonatomic)NSMutableArray *filters;

@property (strong, nonatomic) CIContext *context;



@end

@implementation STWFiltersCollectionViewController

- (NSMutableArray *)filters

{
    
    if (!_filters) _filters = [[NSMutableArray alloc] init];
    
    return _filters;
    
}

- (CIContext *)context
{
    
    if (!_context) _context = [CIContext contextWithOptions:nil];
    
    return _context;
    
    
    
    
    
    
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
    
    self.filters = [[[self class]photoFilters]mutableCopy];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - helper methods
//would be good to refactor and put in it's own class so can be used for other viewcontrollers if needed. current setup allows for calling method [self class]

+ (NSArray *)photoFilters;
{
    
    CIFilter *sepia = [CIFilter filterWithName:@"CISepiaTone" keysAndValues: nil];
    
    CIFilter *blur = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:kCIInputRadiusKey, @1, nil];
    
    CIFilter *colorClamp = [CIFilter filterWithName:@"CIColorClamp" keysAndValues:@"inputMaxComponents", [CIVector vectorWithX:0.9 Y:0.9 Z:0.9 W:0.9], @"inputMinComponents", [CIVector vectorWithX:0.2 Y:0.2 Z:0.2 W:0.2], nil];
    
    CIFilter *instant = [CIFilter filterWithName:@"CIPhotoEffectInstant" keysAndValues: nil];
    
    CIFilter *noir = [CIFilter filterWithName:@"CIPhotoEffectNoir" keysAndValues: nil];
    
    CIFilter *vignette = [CIFilter filterWithName:@"CIVignetteEffect" keysAndValues: nil];
    
    CIFilter *colorControl = [CIFilter filterWithName:@"CIColorControls" keysAndValues: kCIInputSaturationKey, @0.5, nil];
    
    CIFilter *transfer = [CIFilter filterWithName:@"CIPhotoEffectTransfer" keysAndValues: nil];
    
    CIFilter *unsharpen = [CIFilter filterWithName:@"CIUnsharpMask" keysAndValues: nil];
    
    CIFilter *monochrome = [CIFilter filterWithName:@"CIColorMonochrome" keysAndValues: nil];
    
    
    
    NSArray *allFilters = @[sepia, blur, colorClamp, instant, noir, vignette, colorControl, transfer, unsharpen, monochrome];
    
    return allFilters;   
    
}

- (UIImage *)filteredImageFromImage:(UIImage *)image andFilter:(CIFilter *)filter
{
    //sets up conversion of image to be able to add filter and then convert back to UIImage
    
    
    CIImage *unfilteredImage = [[CIImage alloc]initWithCGImage:image.CGImage];
    
    [filter setValue:unfilteredImage forKey:kCIInputImageKey]; //existing constant. see docs
    
    
    CIImage *filteredImage = [filter outputImage];
    
    CGRect extent = [filteredImage extent];
    
    CGImageRef cgImage = [self.context createCGImage:filteredImage fromRect:extent];
    
    UIImage *finalImage = [UIImage imageWithCGImage:cgImage];
    
    
    
    return finalImage;
    
    
    
}






#pragma mark - UICollectionView DataSource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PhotoCell";
    
    STWPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    //block example to refactor to optimize performance, utilizes C structure
    
    dispatch_queue_t filterQueue = dispatch_queue_create("filter queue", NULL);
    
    dispatch_async(filterQueue, ^{
        
        UIImage *filterImage = [self filteredImageFromImage:self.photo.image andFilter:self.filters[indexPath.row]];
    //below pushes change back onto main thread because UI changes have to be on main
        dispatch_async(dispatch_get_main_queue(), ^{
            
            cell.imageView.image = filterImage;
            
        });
        
    });
    
    
    
    
//    cell.imageView.image = [self filteredImageFromImage:self.photo.image andFilter:self.filters[indexPath.row]];
    
    return cell;
    
    
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section

{
    
    return [self.filters count];
    
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    STWPhotoCollectionViewCell *selectedCell = (STWPhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    self.photo.image = selectedCell.imageView.image;
    
    if (self.photo.image) {
    
    
            NSError *error = nil;
            
            
            
            if (![[self.photo managedObjectContext] save:&error]) {
                
                // Handle Error
                
            }
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}




















@end
