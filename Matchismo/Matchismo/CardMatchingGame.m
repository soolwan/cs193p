//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Sean Coleman on 8/8/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()

@property (strong, nonatomic) NSMutableArray *cards;  // of Card
@property (nonatomic) int score; // Not readonly in implementation.
@property (nonatomic) NSString *resultOfMove;
@property (nonatomic) GameMode gameMode;
@property (nonatomic) NSMutableArray *otherFaceUpPlayableCards;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)otherFaceUpPlayableCards
{
    if (!_otherFaceUpPlayableCards) _otherFaceUpPlayableCards = [[NSMutableArray alloc] init];
    return _otherFaceUpPlayableCards;
}

- (NSString *)resultOfMove
{
    if (!_resultOfMove) _resultOfMove = @"";
    return _resultOfMove;
}

- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck
             inGameMode:(GameMode)mode;
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

    self.gameMode = mode;

    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

#define FLIP_COST 1
#define TWO_CARD_MISMATCH_PENALTY 2
#define THREE_CARD_MISMATCH_PENALTY 3
#define MATCH_BONUS 4

// Our game logic.
- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    self.resultOfMove = @"";

    // Flip playable cards.
    if (!card.isUnplayable) {

        // If the card is face-up, there is no penalty for flipping it down,
        // and there are no side effects either. If it's not face-up, let's see
        // how flipping it up impacts our game.
        if (!card.isFaceUp) {

            self.resultOfMove = [NSString stringWithFormat:@"Flipped up %@", card.contents];

            // Collect the other face-up, playable cards. For two-card mode, this array of cards
            // should only be around for one card flip. Either we match another face-up playable
            // card or do not, and we know on this turn. For three-card mode, we need to wait until
            // we have a full set to find out our score.
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    // Only add otherCard once across multiple function calls.
                    if (![self.otherFaceUpPlayableCards containsObject:otherCard]) {
                        [self.otherFaceUpPlayableCards addObject:otherCard];
                    }
                };
            }

            if (self.gameMode == TwoCardMode && [self.otherFaceUpPlayableCards count] == 1) {

                int matchScore = [card match:self.otherFaceUpPlayableCards];

                Card *otherCard = [self.otherFaceUpPlayableCards lastObject];

                if (matchScore) {
                    NSInteger points = matchScore * MATCH_BONUS;
                    self.resultOfMove = [NSString stringWithFormat:@"Matched %@ & %@. +%d",
                                         card,
                                         otherCard,
                                         points];
                    self.score += points;
                } else {
                    self.resultOfMove = [NSString stringWithFormat:@"%@ & %@ don't match. -%d",
                                         card,
                                         otherCard,
                                         TWO_CARD_MISMATCH_PENALTY];
                    self.score -= TWO_CARD_MISMATCH_PENALTY;
                }

                self.otherFaceUpPlayableCards = nil;

            } else if (self.gameMode == ThreeCardMode && [self.otherFaceUpPlayableCards count] == 2) {
                // We have arrived here with a set of three cards.
                int matchScore = [card match:self.otherFaceUpPlayableCards];

                if (matchScore) {
                    NSInteger points = matchScore * MATCH_BONUS;
                    self.resultOfMove = [NSString stringWithFormat:@"A match in %@, %@ & %@. +%d",
                                         card,
                                         self.otherFaceUpPlayableCards[0],
                                         self.otherFaceUpPlayableCards[1],
                                         points];
                    self.score += points;
                } else {
                    self.resultOfMove = [NSString stringWithFormat:@"No match in %@, %@ & %@. -%d",
                                         card,
                                         self.otherFaceUpPlayableCards[0],
                                         self.otherFaceUpPlayableCards[1],
                                         THREE_CARD_MISMATCH_PENALTY];
                    self.score -= THREE_CARD_MISMATCH_PENALTY;
                }

                self.otherFaceUpPlayableCards = nil;
            }
            self.score -= FLIP_COST; // If the card was face-down, flipping costs.
        }
        card.faceUp = !card.isFaceUp; // Just flip the card.
    }
}

@end
