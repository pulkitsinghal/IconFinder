//
//  IconDetailsViewController.h
//  IconFinder
//
//  Created by Pulkit Singhal on 6/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "IconDetails.h"
#import "Icon.h"

@interface IconDetailsViewController : UIViewController <RKObjectLoaderDelegate> {
    Icon* _icon;
    IconDetails* _iconDetails;

    UILabel* _authorLabel;
    UILabel* _licenseLabel;
    UITextView* _attributionTextView;
    UILabel* _iconidLabel;
    UILabel* _iconsetLabel;
    UILabel* _iconsetidLabel;
    
    UIButton* _licenseButton;
    UIButton* _authorButton;
    UIButton* _iconsetButton;

    UIImageView* _imageView;
    UITabBar* _tabBar;
}

@property (nonatomic,retain) Icon* icon;
@property (nonatomic,retain) IconDetails* iconDetails;

@property (nonatomic,retain) IBOutlet UILabel* authorLabel;
@property (nonatomic,retain) IBOutlet UILabel* licenseLabel;
@property (nonatomic,retain) IBOutlet UITextView* attributionTextView;
@property (nonatomic,retain) IBOutlet UILabel* iconidLabel;
@property (nonatomic,retain) IBOutlet UILabel* iconsetLabel;
@property (nonatomic,retain) IBOutlet UILabel* iconsetidLabel;

@property (nonatomic,retain) IBOutlet UIButton* licenseButton;
@property (nonatomic,retain) IBOutlet UIButton* authorButton;
@property (nonatomic,retain) IBOutlet UIButton* iconsetButton;

@property (nonatomic,retain) IBOutlet UIImageView* imageView;
@property (nonatomic,retain) IBOutlet UITabBar* tabBar;

- (IBAction) gotoAuthorWebsite:(UIButton*)sender;
- (IBAction) gotoLicenseWebsite:(UIButton*)sender;
- (IBAction) gotoIconSetWebsite:(UIButton*)sender;

- (UIImage*)imageWithImage:(UIImage*)image 
              scaledToSize:(CGSize)newSize;

@end
