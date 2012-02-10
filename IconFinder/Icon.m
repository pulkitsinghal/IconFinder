//
//  Icon.m
//  IconFinder
//
//  Created by Pulkit Singhal on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Icon.h"


@implementation Icon

@synthesize uniqueID, size, tags, imageUrl;

+ (NSDictionary *)elementToPropertyMappings
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"id",@"uniqueID",
            @"size",@"size",
            @"tags",@"tags",
            @"image",@"imageUrl",
            nil];
}

@end
