//
//  SuperCardViewController.m
//  SuperCard
//
//  Created by Sean Coleman on 11/1/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "SuperCardViewController.h"
#import "PlayingCardView.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface SuperCardViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;
@property (strong, nonatomic) Deck *deck;
@end

@implementation SuperCardViewController

- (Deck *)deck
{
    if (!_deck) {
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck;
}

- (void)setPlayingCardView:(PlayingCardView *)playingCardView
{
    _playingCardView = playingCardView;
    //playingCardView.rank = 13; // King
    //playingCardView.suit = @"♥";
    [self drawRandomPlayingCard];
    [playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:playingCardView
                                                                                    action:@selector(pinch:)]];
}

- (void)drawRandomPlayingCard
{
    Card *card = [self.deck drawRandomCard];
    if ([card isKindOfClass:[PlayingCard class]]) {
        PlayingCard *playingCard = (PlayingCard *)card;
        self.playingCardView.rank = playingCard.rank;
        self.playingCardView.suit = playingCard.suit;
    }
}

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender
{
    [UIView transitionWithView:self.playingCardView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        if (!self.playingCardView.faceUp) {
                            [self drawRandomPlayingCard];
                        }
                        self.playingCardView.faceUp = !self.playingCardView.faceUp;
                    }
                    completion:nil];
}

@end
