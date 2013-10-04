//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Sean Coleman on 10/3/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "SetGame.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (Game *)game
{
    if (!_game) _game =
        [[SetGame alloc] initWithCardCount:[self.cardButtons count]
                                 usingDeck:[[SetCardDeck alloc] init]];
    return _game;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSAttributedString *)formatTitleForCard:(SetCard *)card
{
    // Color and Shading attributes.
    CGFloat strokeWidth = -4.0f;
    UIColor *strokeColor;

    if ([card.color isEqualToString:@"red"]) {
        strokeColor = [UIColor redColor];
    } else if ([card.color isEqualToString:@"green"]) {
        strokeColor = [UIColor greenColor];
    } else if ([card.color isEqualToString:@"purple"]) {
        strokeColor = [UIColor purpleColor];
    }

    UIColor *fillColor = strokeColor;

    if ([card.shading isEqualToString:@"striped"]) {
        fillColor = [fillColor colorWithAlphaComponent:0.3f];
    } else if ([card.shading isEqualToString:@"open"]) {
        strokeWidth = -strokeWidth;
    }

    NSAttributedString *title =
    [[NSAttributedString alloc] initWithString:card.contents
                                    attributes:@{ NSStrokeWidthAttributeName : [NSNumber numberWithFloat:strokeWidth],
                                                  NSStrokeColorAttributeName : strokeColor,
                                                  NSForegroundColorAttributeName : fillColor }];
    return title;
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        SetCard *card = (SetCard *)[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];

        [cardButton setAttributedTitle:[self formatTitleForCard:card] forState:UIControlStateNormal];

        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.0f : 1.0f;

        if (cardButton.selected == NO) {
            cardButton.backgroundColor = [UIColor clearColor];
        } else {
            cardButton.backgroundColor = [UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:0.3f];
        }

        // Set the result label text.
        if (self.game.resultStatus == ResultStatusDefault) {
            self.resultsLabel.attributedText = nil;

        } else if (self.game.resultStatus == ResultStatusFlip) {
            NSMutableAttributedString *formattedText = [[NSMutableAttributedString alloc] initWithString:@"Flipped "];
            [formattedText appendAttributedString:[self formatTitleForCard:self.game.resultSet[0]]];
            self.resultsLabel.attributedText = formattedText;

        } else if (self.game.resultStatus == ResultStatusMatch || self.game.resultStatus == ResultStatusNoMatch) {

            NSString *matchStatus = self.game.resultStatus == ResultStatusMatch ? @"Matched " : @"Didn't Match ";
            NSMutableAttributedString *formattedText = [[NSMutableAttributedString alloc] initWithString:matchStatus];

            [formattedText appendAttributedString:[self formatTitleForCard:self.game.resultSet[0]]];
            [formattedText appendAttributedString:[[NSAttributedString alloc] initWithString:@", "]];
            [formattedText appendAttributedString:[self formatTitleForCard:self.game.resultSet[1]]];
            [formattedText appendAttributedString:[[NSAttributedString alloc] initWithString:@", & "]];
            [formattedText appendAttributedString:[self formatTitleForCard:self.game.resultSet[2]]];

            NSString *delta = [NSString stringWithFormat:@": %+d", self.game.currentDelta];
            [formattedText appendAttributedString:[[NSAttributedString alloc] initWithString:delta]];

            self.resultsLabel.attributedText = formattedText;
        }
    }

    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

@end
