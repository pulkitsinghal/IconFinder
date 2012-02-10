//
//  IconFinderTableViewController.h
//  IconFinder
//
//  Created by Pulkit Singhal on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface IconFinderTableViewController : UITableViewController <RKObjectLoaderDelegate, UISearchBarDelegate> {
    NSArray* _icons;
    int _size;
    UISearchBar* _searchBar;
    UILabel* _sliderLabel;
}

@property (nonatomic,retain) NSArray* icons;
@property (readonly) int size;
@property (retain) IBOutlet UISearchBar* searchBar;
@property (retain) IBOutlet UISlider* slider;

- (IBAction) sliderValueChanged:(id)sender;

@end
