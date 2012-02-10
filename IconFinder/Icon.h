//
//  Icon.h
//  IconFinder
//
//  Created by Pulkit Singhal on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "IconDetails.h"

@interface Icon : NSObject {
    NSString* _identifier;
    NSString* _size;
    NSArray* _tags;
    NSString* _imageUrl;
    //IconDetails* _iconDetails;
}

@property (nonatomic,retain) NSString* identifier;
@property (nonatomic,retain) NSString* size;
@property (nonatomic,retain) NSArray* tags;
@property (nonatomic,retain) NSString* imageUrl;
//@property (nonatomic,retain) IconDetails* iconDetails;

- (NSString*)tagsAsString;

@end
