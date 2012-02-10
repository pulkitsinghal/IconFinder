//
//  SearchResult.h
//  IconFinder
//
//  Created by Pulkit Singhal on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface SearchResult : RKObject {
    NSString *searchTerms;
    NSNumber *startPage;
    NSNumber *totalResults;
    NSNumber *startIndex;
    NSNumber *itemsPerPage;
    NSArray *icons;
}

@property (nonatomic,retain) NSString *searchTerms;
@property (nonatomic,retain) NSNumber *startPage;
@property (nonatomic,retain) NSNumber *totalResults;
@property (nonatomic,retain) NSNumber *startIndex;
@property (nonatomic,retain) NSNumber *itemsPerPage;
@property (nonatomic,retain) NSArray *icons;

@end
