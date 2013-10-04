//
//  Game.m
//  Matchismo
//
//  Created by Sean Coleman on 10/4/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "Game.h"

@implementation Game

- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end
