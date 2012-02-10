//
//  SearchResult.m
//  IconFinder
//
//  Created by Pulkit Singhal on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchResult.h"


@implementation SearchResult

@synthesize searchTerms, startPage, totalResults, startIndex, itemsPerPage, icons;

+ (NSDictionary *)elementToPropertyMappings
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"searchTerms",@"searchTerms",
            @"startPage",@"startPage",
            @"totalResults",@"totalResults",
            @"startIndex",@"startIndex",
            @"itemsPerPage",@"itemsPerPage",
            nil];
}

+ (NSDictionary *)elementToRelationshipMappings
{
    return [NSDictionary dictionaryWithObject:@"icons" forKey:@"icons"];
}

@end
