//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Sean Coleman on 8/8/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "MatchingGame.h"
#import "Deck.h"

@interface MatchingGame ()
@end

@implementation MatchingGame

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

// Our game logic.
- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    self.resultStatus = ResultStatusDefault;
    self.resultSet = nil;
    self.currentDelta = 0;

    // Flip playable cards.
    if (!card.isUnplayable) {

        // If the card is face-up, there is no penalty for flipping it down,
        // and there are no side effects either. If it's not face-up, let's see
        // how flipping it up impacts our game.
        if (!card.isFaceUp) {

            self.resultStatus = ResultStatusFlip;
            self.resultSet = @[card];
            self.currentDelta = 0;

            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    
                    int matchScore = [card match:@[otherCard]];

                    self.resultSet = @[card, otherCard];
                    
                    if (matchScore) {
                        self.resultStatus = ResultStatusMatch;
                        NSInteger points = matchScore * MATCH_BONUS;
                        self.currentDelta = points;
                        self.score += points;
                    } else {
                        self.resultStatus = ResultStatusNoMatch;
                        self.currentDelta = -MISMATCH_PENALTY;
                        self.score -= MISMATCH_PENALTY;
                    }
                }

            }
            self.score -= FLIP_COST; // If the card was face-down, flipping costs.
        }
        card.faceUp = !card.isFaceUp; // Just flip the card.
    }
}

@end
