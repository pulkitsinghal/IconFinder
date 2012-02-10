//
//  IconFinderTableViewController.m
//  IconFinder
//
//  Created by Pulkit Singhal on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IconFinderTableViewController.h"
#import <RestKit/RestKit.h>
#import "UIImageView+WebCache.h"
#import "SearchResults.h"
#import "Icon.h"
#import "IconDetails.h"
#import "IconDetailsViewController.h"

@implementation IconFinderTableViewController

@synthesize searchBar = _searchBar;
@synthesize slider = _slider;
@synthesize icons = _icons;
@synthesize size = _size;

- (int) size
{
    float value = [self.slider value];
    if (value == 0) {
        _size = 0;
    } else if (value == 1) {
        _size = 12;
    } else if (value == 2) {
        _size = 16;
    } else if (value == 3) {
        _size = 24;
    } else if (value == 4) {
        _size = 32;
    } else if (value == 5) {
        _size = 48;
    } else if (value == 6) {
        _size = 64;
    } else if (value == 7) {
        _size = 128;
    } else if (value == 8) {
        _size = 256;
    } else {
        _size = 512;
    }
    return _size;
}

- (IBAction) sliderValueChanged:(UISlider *)sender {
    float value = [sender value];
    if (value < 0.5) {
        value = 0;
    } else if (value > 0.5 && value <1.5) {
        value = 1;
    } else if (value > 1.5 && value <2.5) {
        value = 2;
    } else if (value > 2.5 && value <3.5) {
        value = 3;
    } else if (value > 3.5 && value <4.5) {
        value = 4;
    } else if (value > 4.5 && value <5.5) {
        value = 5;
    } else if (value > 5.5 && value <6.5) {
        value = 6;
    } else if (value > 6.5 && value <7.5) {
        value = 7;
    } else if (value > 7.5 && value <8.5) {
        value = 8;
    } else {
        value = 9;
    }
    self.slider.value = value;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    if([searchBar canResignFirstResponder]) {
        [searchBar resignFirstResponder];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.title = searchBar.text;

    RKObjectManager* objectManager = [RKObjectManager sharedManager];
    
    RKObjectMapping* objectMappingForIcon = [RKObjectMapping mappingForClass:[Icon class]];
    [objectMappingForIcon
     mapKeyPathsToAttributes:
     @"size", @"size",
     @"tags", @"tags",
     @"id", @"identifier",
     @"image", @"imageUrl",
     nil];
    
    RKObjectMapping* objectMappingForSearchResults = [RKObjectMapping mappingForClass:[SearchResults class]];
    [objectMappingForSearchResults mapKeyPath:@"searchresults.searchTerms" toAttribute:@"searchTerms"];
    [objectMappingForSearchResults mapKeyPath:@"searchresults.startPage" toAttribute:@"startPage"];
    [objectMappingForSearchResults mapKeyPath:@"searchresults.totalResults" toAttribute:@"totalResults"];
    [objectMappingForSearchResults mapKeyPath:@"searchresults.startIndex" toAttribute:@"startIndex"];
    [objectMappingForSearchResults mapKeyPath:@"searchresults.itemsPerPage" toAttribute:@"itemsPerPage"];
    [objectMappingForSearchResults mapKeyPath:@"searchresults.icons"
                               toRelationship:@"icons"
                            withObjectMapping:objectMappingForIcon];
    
    [objectManager.mappingProvider setMapping:objectMappingForSearchResults forKeyPath:@""];
    
    /*
     Params
     q: Search term
     p: Specify result page (index). Starts from 0
     c: Number of icons per page. (Takes values between 1 and 100)
     l: Filter on license (0 include all icons. 1 includes only icons with commercial licenses)
     min: Specify minimum size of icons
     max: Specify maximum size of icons
     api_key: An Iconfinder API key
     callback: Name of callback function (JSONP)
     */
    NSString* searchTerms = [@"q=" stringByAppendingString:searchBar.text];
    NSString* resultsPageIndex = @"p=0";
    NSString* iconsPerPage = @"c=20";
    NSString* licenseFilter = @"l:0";
    NSString* minIconSize = @"min=1";
    NSString* maxIconSize = [@"max="stringByAppendingString:[NSString stringWithFormat:@"%i", self.size]];
    NSString* apiKey = @"api_key=59b993a7c3815736836ff0a9242434e0";
    
    NSString* repo = [@"/search/?"
                      stringByAppendingFormat:@"%@&%@&%@&%@&%@&%@&%@",
                      searchTerms,
                      resultsPageIndex,
                      iconsPerPage,
                      licenseFilter,
                      minIconSize,
                      maxIconSize,
                      apiKey];
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:repo
                                                      delegate:self];
    
    [searchBar resignFirstResponder];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects
{
    //if ([[objects lastObject] isKindOfClass:[SearchResults class]]) {
        SearchResults* searchResults = [objects lastObject];
        self.icons = searchResults.icons;
        [self.tableView reloadData];
    /*} else if ([[objects lastObject] isKindOfClass:[IconDetails class]]) {
        IconDetails* iconDetails = [objects lastObject];
    }*/
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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_icons release];
    [_searchBar release];
    [_sliderLabel release];
    [_slider release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    //[self addSearchBar];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.icons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"IconFinderTableViewControllerCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    Icon* icon = [self.icons objectAtIndex:indexPath.row];
    cell.textLabel.text = [icon tagsAsString];
    cell.detailTextLabel.text = icon.imageUrl;
    NSString* normalizedImageUrl = [icon.imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    /*
    cell.imageView.image =
        [[UIImage alloc] initWithData:
            [NSData dataWithContentsOfURL:
                [NSURL URLWithString:normalizedImageUrl]]];
    */
    // Here we use the new provided setImageWithURL: method to load the web image
    [cell.imageView setImageWithURL:[NSURL URLWithString:normalizedImageUrl]
                   placeholderImage:[UIImage imageNamed:@"empty_48x48.png"]];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Icon* selectedIcon = [self.icons objectAtIndex:indexPath.row];

    // Navigation logic may go here. Create and push another view controller.
    IconDetailsViewController *detailViewController =
    [[IconDetailsViewController alloc] initWithNibName:@"IconDetailsViewController"
                                                bundle:nil];
    detailViewController.icon = selectedIcon;
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

@end
