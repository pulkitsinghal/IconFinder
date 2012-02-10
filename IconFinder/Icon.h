//
//  Icon.h
//  IconFinder
//
//  Created by Pulkit Singhal on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface Icon : RKObject {
    NSNumber *uniqueId;
    NSNumber *size;
    NSArray *tags;
    NSURL *imageUrl;
}

//TODO: Find out the significance behind making these "nonatomic"

@property (nonatomic,retain) NSNumber *uniqueID;
@property (nonatomic,retain) NSNumber *size;
@property (nonatomic,retain) NSArray *tags;
@property (nonatomic,retain) NSURL *imageUrl;

@end
