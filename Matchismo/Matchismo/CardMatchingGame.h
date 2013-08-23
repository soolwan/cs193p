//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Sean Coleman on 8/8/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

typedef NS_ENUM(NSUInteger, GameMode) {
    TwoCardMode,
    ThreeCardMode
};

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) int score;

// Result of move is calculated in the model because
// it is a disclosure of the game logic. The controller
// will handle passing the result on to the view.
@property (nonatomic, readonly) NSString *resultOfMove;

// Designated initializer.
- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck
             inGameMode:(GameMode)mode;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@end
