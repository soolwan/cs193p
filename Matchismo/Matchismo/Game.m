//
//  Game.m
//  Matchismo
//
//  Created by Sean Coleman on 10/4/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "Game.h"
#import "Card.h"
#import "Deck.h"

@implementation Game

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (NSString *)resultOfMove
{
    if (!_resultOfMove) _resultOfMove = @"";
    return _resultOfMove;
}

- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;
{
    self = [super init];

    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }

    return self;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

@end
