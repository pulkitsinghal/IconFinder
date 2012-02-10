//
//  IconDetailsViewController.m
//  IconFinder
//
//  Created by Pulkit Singhal on 6/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IconDetailsViewController.h"


@implementation IconDetailsViewController

@synthesize icon = _icon;
@synthesize iconDetails = _iconDetails;

@synthesize authorLabel = _authorLabel;
@synthesize licenseLabel = _licenseLabel;
@synthesize iconidLabel =_iconidLabel;
@synthesize iconsetLabel= _iconsetLabel;
@synthesize iconsetidLabel = _iconsetidLabel;
@synthesize attributionTextView = _attributionTextView;

@synthesize licenseButton = _licenseButton;
@synthesize authorButton = _authorButton;
@synthesize iconsetButton = _iconsetButton;

@synthesize imageView = _imageView;
@synthesize tabBar = _tabBar;

- (IBAction) gotoAuthorWebsite:(UIButton*)sender
{
    NSURL *url = [NSURL URLWithString:self.iconDetails.authorwebsite];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction) gotoLicenseWebsite:(UIButton*)sender
{
    NSURL *url = [NSURL URLWithString:self.iconDetails.licensewebsite];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction) gotoIconSetWebsite:(UIButton*)sender
{
    NSURL *url = [NSURL URLWithString:self.iconDetails.iconsetwebsite];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects
{
    self.iconDetails = [objects lastObject];

    if ([self.iconDetails.license length]) {
        self.licenseLabel.text = [@"License: " stringByAppendingString:self.iconDetails.license];
    }

    if ([self.iconDetails.author length]) {
        self.authorLabel.text = [@"Author: " stringByAppendingString:self.iconDetails.author];
    }

    self.iconidLabel.text = [@"Icon Id: " stringByAppendingString:self.icon.identifier];

    if ([self.iconDetails.iconset length]) {
            self.iconsetLabel.text = [@"Icon Set: " stringByAppendingString:self.iconDetails.iconset];
    }
    if ([self.iconDetails.iconsetid length]) {
        self.iconsetidLabel.text = [@"Icon Set Id: " stringByAppendingString:self.iconDetails.iconsetid];
    }
    if ([self.iconDetails.attribution length]) {
        self.attributionTextView.text = [@"Attributions: \n" stringByAppendingString:self.iconDetails.attribution];
    }

    if ([self.iconDetails.licensewebsite length]) {
        self.licenseButton.hidden = NO;
    } else {
        self.licenseButton.hidden = YES;
    }

    if ([self.iconDetails.authorwebsite length]) {
        self.authorButton.hidden = NO;
    } else {
        self.authorButton.hidden = YES;
    }

    if ([self.iconDetails.iconsetwebsite length]) {
        self.iconsetButton.hidden = NO;
    } else {
        self.iconsetButton.hidden = YES;
    }

    NSString* normalizedImageUrl = [self.icon.imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    UIImage* originalImage = 
        [[UIImage alloc] initWithData:
            [NSData dataWithContentsOfURL:
                [NSURL URLWithString:normalizedImageUrl]]];
    self.imageView.image = [self imageWithImage:originalImage
                                   scaledToSize:(CGSizeMake(32.0, 32.0))];
    
    // Assign the image to the tab bar item
    [
      [self.tabBar.items objectAtIndex:0]
      setImage:
      [self imageWithImage:originalImage
              scaledToSize:(CGSizeMake(32.0, 32.0))]
    ];
    [originalImage release];

    // Assign the search query as the tab bar item's title
    [[self.tabBar.items objectAtIndex:0] setTitle:@"32x32 Sample"];
}

/* The following method is copied from:
 * http://stackoverflow.com/questions/603907/uiimage-resize-then-crop
 * where it was posted by: Brad Larson.
 */
- (UIImage*)imageWithImage:(UIImage*)image 
              scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error 
{
	UIAlertView* alert = [[[UIAlertView alloc]
                           initWithTitle:@"Error"
                           message:[error localizedDescription]
                           delegate:nil
                           cancelButtonTitle:@"OK"
                           otherButtonTitles:nil] autorelease];
	[alert show];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_icon release];
    [_iconDetails release];
    
    [_authorLabel release];
    [_licenseLabel release];
    [_attributionTextView release];
    [_iconidLabel release];
    [_iconsetLabel release];
    [_iconsetidLabel release];
    
    [_licenseButton release];
    [_authorButton release];
    [_iconsetButton release];

    [_imageView release];
    [_tabBar release];

    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    RKObjectManager* objectManager = [RKObjectManager sharedManager];
    
    RKObjectMapping* objectMappingForIconDetails = [RKObjectMapping mappingForClass:[IconDetails class]];
    [objectMappingForIconDetails
     mapKeyPathsToAttributes:
     @"icon.author",@"author",
     @"icon.authorwebsite",@"authorwebsite",
     @"icon.license",@"license",
     @"icon.licensewebsite",@"licensewebsite",
     @"icon.iconsetwebsite",@"iconsetwebsite",
     @"icon.attribution",@"attribution",
     @"icon.iconset",@"iconset",
     @"icon.iconsetid",@"iconsetid",
     nil];
    
    [objectManager.mappingProvider setMapping:objectMappingForIconDetails forKeyPath:@""];
    
    /*
     Params
     id: Icon ID
     size: Icon size
     api_key: An Iconfinder API key
     callback: Name of callback function (JSONP)
     */
    NSString* identifier = [@"id=" stringByAppendingString:self.icon.identifier];
    NSString* size = [@"size=" stringByAppendingString:self.icon.size];
    NSString* apiKey = @"api_key=59b993a7c3815736836ff0a9242434e0";
    NSString* repo = [@"/icondetails/?"
                      stringByAppendingFormat:@"%@&%@&%@",
                      identifier,
                      size,
                      apiKey];
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:repo
                                                      delegate:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
