//
//  Card.h
//  Matchismo
//
//  Created by Sean Coleman on 6/18/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isFaceUp) BOOL faceUp;
@property (nonatomic, getter=isUnplayable) BOOL unplayable;

- (int)match:(NSArray *)otherCards;

@end
