//
//  SetGame.m
//  Matchismo
//
//  Created by Sean Coleman on 10/3/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "SetGame.h"
#import "Deck.h"

@implementation SetGame

#define FLIP_COST 1
#define MISMATCH_PENALTY 6
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

            NSMutableArray *otherCards = [[NSMutableArray alloc] init];

            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {

                    [otherCards addObject:otherCard];

                    if ([otherCards count] == 2) {

                        int matchScore = [card match:otherCards];

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
                                                 MISMATCH_PENALTY];
                            self.score -= MISMATCH_PENALTY;
                        }
                    }
                }

            }
            self.score -= FLIP_COST; // If the card was face-down, flipping costs.
        }
        card.faceUp = !card.isFaceUp; // Just flip the card.
    }
}

@end
