//
//  Card.m
//  Matchismo
//
//  Created by Sean Coleman on 6/18/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

- (int)match:(NSArray *)otherCards
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSString *)description {
    return self.contents;
}

@end
