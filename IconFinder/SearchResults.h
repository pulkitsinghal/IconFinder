//
//  SearchResult.h
//  IconFinder
//
//  Created by Pulkit Singhal on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResults : NSObject {
    NSString* _searchTerms;
    NSNumber* _startPage;
    NSNumber* _totalResults;
    NSNumber* _startIndex;
    NSNumber* _itemsPerPage;
    //Icons* _icons;
    NSArray* _icons;
}

@property (nonatomic,retain) NSString* searchTerms;
@property (nonatomic,retain) NSNumber* startPage;
@property (nonatomic,retain) NSNumber* totalResults;
@property (nonatomic,retain) NSNumber* startIndex;
@property (nonatomic,retain) NSNumber* itemsPerPage;
@property (nonatomic,retain) NSArray*  icons;

@end
