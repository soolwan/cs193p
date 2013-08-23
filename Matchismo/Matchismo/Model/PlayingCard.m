//
//  PlayingCard.m
//  Matchismo
//
//  Created by Sean Coleman on 8/7/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

// Override match to work for rank and suit. TODO: Match for three cards
// should find matches in all three cards, not just the third card and one other.
- (int)match:(NSArray *)otherCards
{
    int score = 0;

    // Match two cards.
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards lastObject]; // Returns nil if the array is empty.

        // Score high to low.
        if (otherCard.rank == self.rank) {
            // Give 4 times as many points for matching the rank than matching
            // the suit since there are only 3 cards that will match a given card's
            // rank, but 12 which will match its suit.
            score = 8;
            self.unplayable = YES;
            otherCard.unplayable = YES;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score = 2;
            self.unplayable = YES;
            otherCard.unplayable = YES;
        } else { // No score.
            score = 0;
            otherCard.faceUp = NO;
        }

    // Match card to two other cards.
    } else if ([otherCards count] == 2) {
        NSUInteger rankMatches = 0;
        NSUInteger suitMatches = 0;

        PlayingCard *card2 = otherCards[0];
        PlayingCard *card3 = otherCards[1];

        // Ranks
        if (self.rank == card2.rank ||
            self.rank == card3.rank) {
            // 3/3 possible.
            rankMatches++;
            self.unplayable = YES;

            if (self.rank == card2.rank) {
                rankMatches++;
                card2.unplayable = YES;
            }
            if (self.rank == card3.rank) {
                rankMatches++;
                card3.unplayable = YES;
            }

            //if (!card2.unplayable) card2.faceUp = NO;
            //if (!card3.unplayable) card3.faceUp = NO;
            
        } else if (card2.rank == card3.rank) {
            // Only 2/3 matched.
            rankMatches += 2;
            card2.unplayable = YES;
            card3.unplayable = YES;
            self.faceUp = NO;

        // Suits
        } else if ([self.suit isEqualToString:card2.suit] ||
            [self.suit isEqualToString:card3.suit]) {
            // 3/3 possible.
            suitMatches++;
            self.unplayable = YES;
            
            if ([self.suit isEqualToString:card2.suit]) {
                suitMatches++;
                card2.unplayable = YES;
            }
            if ([self.suit isEqualToString:card3.suit]) {
                suitMatches++;
                card3.unplayable = YES;
            }

            //if (!card2.unplayable) card2.faceUp = NO;
            //if (!card3.unplayable) card3.faceUp = NO;

        } else if ([card2.suit isEqualToString:card3.suit]) {
            // Only 2/3 matched.
            suitMatches += 2;
            card2.unplayable = YES;
            card3.unplayable = YES;
            self.faceUp = NO;
            
        } else { // No score.
            card2.faceUp = NO;
            card3.faceUp = NO;
        }

        // Score high to low.
        if (rankMatches == 3) {
            score = 12; 
        } else if (rankMatches == 2) {
            score = 6;
        } else if (suitMatches == 3) {
            score = 3;
        } else if (suitMatches == 2) {
            score = 1;
        }

    } else {
        NSLog(@"Playing supports matching up to three cards, including itself.");
    }
    
    return score;
}

- (NSString *)contents
{
    //return [NSString stringWithFormat:@"%d%@", self.rank, self.suit];
    NSArray *rankStrings = [PlayingCard rankStrings];
    
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // Because we provide a setter and getter.

+ (NSArray *)validSuits
{
    return @[@"♥", @"♦", @"♣", @"♠"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6",
             @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank { return [[self rankStrings] count] - 1; }

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (NSString *)description {
    return self.contents;
}

@end
