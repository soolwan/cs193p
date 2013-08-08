//
//  PlayingCard.m
//  Matchismo
//
//  Created by Sean Coleman on 8/7/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

// Override match to work for rank and suit.
- (int)match:(NSArray *)otherCards
{
    int score = 0;

    if (otherCards.count == 1) { // NOTE: More matches in HW1.
        PlayingCard *otherCard = [otherCards lastObject]; // Returns nil if the array is empty.

        if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        } else if (otherCard.rank == self.rank) {
            // Give 4 times as many points for matching the rank than matching
            // the suit since there are only 3 cards that will match a given card's
            // rank, but 12 which will match its suit.
            score = 4;
        }
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

@end
