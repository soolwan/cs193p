//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Sean Coleman on 10/3/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init
{
    self = [super init];
    
    if (self) {

        for (NSString *symbol in [SetCard validSymbols]) {
            for (NSString *shading in [SetCard validShadings]) {
                for (NSString *color in [SetCard validColors]) {
                    for (NSUInteger number = 1; number <= [SetCard maxNumber]; number++) {

                        SetCard *card = [[SetCard alloc] init];
                        card.number = number;
                        card.symbol = symbol;
                        card.shading = shading;
                        card.color = color;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }

    return self;
}

@end
