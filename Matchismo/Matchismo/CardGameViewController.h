//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Sean Coleman on 6/18/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "Deck.h"

@interface CardGameViewController : UIViewController

@property (nonatomic) NSUInteger startingCardCount; // Abstract

- (Game *)createGame; // Abstract
- (Deck *)createDeck; // Abstract
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card;

@end
