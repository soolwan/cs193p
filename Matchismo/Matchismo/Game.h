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

@interface Game : NSObject {
    NSMutableArray *_cards;
    NSString *_resultOfMove;
    int _score;
}

@property (strong, nonatomic) NSMutableArray *cards;  // of Card

// Result of move is calculated in the model because
// it is a disclosure of the game logic. The controller
// will handle passing the result on to the view.
@property (nonatomic) NSString *resultOfMove;

@property (nonatomic) int score;


// Designated initializer.
- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@end
