//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Sean Coleman on 6/18/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;

@end

@implementation CardGameViewController

// We want a PlayingCardDeck, but we do not need to be that
// specific with our pointer because we do not call PlayingCardDeck
// specific methods.
- (Deck *)deck
{
    if (!_deck) { _deck = [[PlayingCardDeck alloc] init]; }
    return _deck;
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected = !sender.isSelected;

    Card *card = [self.deck drawRandomCard];

    // Card has contents, and since it was created in a PlayingCardDeck
    // it is a PlayingCard, and so we are calling PlayingCard's contents.
    [sender setTitle:card.contents forState:UIControlStateSelected];

    self.flipCount++;
}

@end
