//
//  Icon.m
//  IconFinder
//
//  Created by Pulkit Singhal on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Icon.h"

@implementation Icon

@synthesize identifier = _identifier;
@synthesize size = _size;
@synthesize tags = _tags;
@synthesize imageUrl = _imageUrl;
//@synthesize iconDetails = _iconDetails;

- (NSString*)tagsAsString
{
    NSString* tagsAsString = nil;
    if ([self.tags count] == 0) {
        tagsAsString = @"No tags available...";
    } else {
        for (int i = 0; i < [self.tags count]; i++) {
            if (!tagsAsString) {
                tagsAsString = [self.tags objectAtIndex:i];
            } else {
                tagsAsString = [tagsAsString stringByAppendingFormat:@",%@",[self.tags objectAtIndex:i]];
            }
        }
    }
    return tagsAsString;
}

@end
