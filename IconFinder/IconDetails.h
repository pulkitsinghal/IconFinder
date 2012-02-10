//
//  IconDetails.h
//  IconFinder
//
//  Created by Pulkit Singhal on 6/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IconDetails : NSObject {
    NSString* author;
    NSString* authorwebsite;
    NSString* license;
    NSString* licensewebsite;
    NSString* iconsetwebsite;
    NSString* attribution;
    NSString* iconset;
    NSString* iconsetid;
}

@property (nonatomic,retain) NSString* author;
@property (nonatomic,retain) NSString* authorwebsite;
@property (nonatomic,retain) NSString* license;
@property (nonatomic,retain) NSString* licensewebsite;
@property (nonatomic,retain) NSString* iconsetwebsite;
@property (nonatomic,retain) NSString* attribution;
@property (nonatomic,retain) NSString* iconset;
@property (nonatomic,retain) NSString* iconsetid;

@end

