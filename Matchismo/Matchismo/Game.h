//
//  Game.h
//  Matchismo
//
//  Created by Sean Coleman on 10/4/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Deck;
@class Card;

typedef NS_ENUM(NSInteger, ResultStatus) {
    ResultStatusDefault,
    ResultStatusFlip,
    ResultStatusMatch,
    ResultStatusNoMatch
};

@interface Game : NSObject {
    NSMutableArray *_cards;
    NSString *_resultOfMove;
    int _score;
}

@property (strong, nonatomic) NSMutableArray *cards;  // of Card

@property (nonatomic) ResultStatus resultStatus;
@property (nonatomic) NSArray *resultSet;
@property (nonatomic) int currentDelta;

@property (nonatomic) int score;


// Designated initializer.
- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@end
