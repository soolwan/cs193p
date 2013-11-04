//
//  MatchingGameViewController.m
//  Matchismo
//
//  Created by Sean Coleman on 10/4/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "MatchingGameViewController.h"
#import "MatchingGame.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardCollectionViewCell.h"

@implementation MatchingGameViewController

#define STARTING_CARD_COUNT 20

- (NSUInteger)startingCardCount
{
    return STARTING_CARD_COUNT;
}

- (Game *)createGame
{
    return [[MatchingGame alloc] initWithCardCount:self.startingCardCount
                                             usingDeck:[self createDeck]];
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

#define TRANSPARENT_CARD 0.3
#define OPAQUE_CARD  1.0

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    if ([cell isKindOfClass:[PlayingCardCollectionViewCell class]]) {
        PlayingCardView *playingCardView = ((PlayingCardCollectionViewCell *)cell).playingCardView;
        if ([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *playingCard = (PlayingCard *)card;
            playingCardView.rank = playingCard.rank;
            playingCardView.suit = playingCard.suit;
            playingCardView.faceUp = playingCard.isFaceUp;
            playingCardView.alpha = playingCard.isUnplayable ? TRANSPARENT_CARD : OPAQUE_CARD;

            // Flip the card here if animate:(BOOL)animate is yes. Only set to yes for updateUI.
        }
    }
}

//- (void)updateUI
//{
//        // Set the result label text.
//        if (self.game.resultStatus == ResultStatusDefault) {
//            self.resultsLabel.text = @"";
//        } else if (self.game.resultStatus == ResultStatusFlip) {
//            self.resultsLabel.text = [NSString stringWithFormat:@"Flipped %@", self.game.resultSet[0]];
//        } else if (self.game.resultStatus == ResultStatusMatch) {
//            self.resultsLabel.text = [NSString stringWithFormat:@"Matched %@ & %@: %+d",
//                                      self.game.resultSet[0],
//                                      self.game.resultSet[1],
//                                      self.game.currentDelta];
//        } else if (self.game.resultStatus == ResultStatusNoMatch) {
//            self.resultsLabel.text = [NSString stringWithFormat:@"Didn't match %@ & %@: %+d",
//                                      self.game.resultSet[0],
//                                      self.game.resultSet[1],
//                                      self.game.currentDelta];
//        }
    
    //self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
//}

@end
