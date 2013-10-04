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

@end

@implementation CardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.resultsLabel.lineBreakMode = NSLineBreakByWordWrapping;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)dealCards:(UIButton *)sender
{
    self.game = nil;
    [self updateUI];
    self.flipCount = 0;
}

@end
