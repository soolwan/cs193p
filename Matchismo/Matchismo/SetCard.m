//
//  SetCard.m
//  Matchismo
//
//  Created by Sean Coleman on 10/3/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize symbol = _symbol;
@synthesize shading = _shading;
@synthesize color = _color;

- (void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (NSString *)symbol
{
    return _symbol ? _symbol : @"?";
}

- (void)setShading:(NSString *)shading
{
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

- (NSString *)shading
{
    return _shading ? _shading : @"?";
}

- (void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (NSString *)color
{
    return _color ? _color : @"?";
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;

    // Match card to two other cards.
    if ([otherCards count] == 2) {
        BOOL numberMatches = NO;
        BOOL symbolMatches = NO;
        BOOL shadingMatches = NO;
        BOOL colorMatches = NO;

        SetCard *card2 = otherCards[0];
        SetCard *card3 = otherCards[1];

        // Same number or 3 different numbers
        if ((self.number == card2.number && self.number == card3.number) ||
            (self.number != card2.number && self.number != card3.number && card2.number != card3.number)) {

            numberMatches = YES;
            self.unplayable = card2.unplayable = card3.unplayable = YES;

            // Same symbol or 3 different symbols
        } else if (([self.symbol isEqualToString:card2.symbol] && [self.symbol isEqualToString:card3.symbol]) ||
                   (![self.symbol isEqualToString:card2.symbol] && ![self.symbol isEqualToString:card3.symbol] && ![card2.symbol isEqualToString:card3.symbol])) {

            symbolMatches = YES;
            self.unplayable = card2.unplayable = card3.unplayable = YES;

            // Same shading or 3 different shadings
        } else if (([self.shading isEqualToString:card2.shading] && [self.shading isEqualToString:card3.shading]) ||
                   (![self.shading isEqualToString:card2.shading] && ![self.shading isEqualToString:card3.shading] && ![card2.shading isEqualToString:card3.shading])) {

            shadingMatches = YES;
            self.unplayable = card2.unplayable = card3.unplayable = YES;

            // Same color or 3 different colors
        } else if (([self.color isEqualToString:card2.color] && [self.color isEqualToString:card3.color]) ||
                   (![self.color isEqualToString:card2.color] && ![self.color isEqualToString:card3.color] && ![card2.color isEqualToString:card3.color])) {

            colorMatches = YES;
            self.unplayable = card2.unplayable = card3.unplayable = YES;


        } else { // No score.
            card2.faceUp = NO;
            card3.faceUp = NO;
        }

        // Tally the score.
        if (numberMatches || symbolMatches || shadingMatches || colorMatches) {
            score = 3;
        }

    } else {
        NSLog(@"SetCard supports matchings three cards, including itself.");
    }

    return score;
}

- (NSString *)contents
{
    //NSArray *rankStrings = [PlayingCard rankStrings];
    //return [rankStrings[self.rank] stringByAppendingString:self.suit];
    return @"";
}

+ (NSUInteger)maxNumber { return 3; }

+ (NSArray *)validSymbols
{
    return @[@"○", @"□", @"△"];
}

+ (NSArray *)validShadings
{
    return @[@"solid", @"striped", @"open"];
}

+ (NSArray *)validColors
{
    return @[@"red", @"green", @"purple"];
}

@end
