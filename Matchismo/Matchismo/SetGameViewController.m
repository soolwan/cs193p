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
    NSMutableString *titlePreFormat = [card.symbol mutableCopy];

    for (int i = 1; i < card.number; i++)
        [titlePreFormat appendString:card.symbol];

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
    [[NSAttributedString alloc] initWithString:titlePreFormat
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
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;

        if (cardButton.selected == NO) {
        } else {
        }

        self.resultsLabel.text = self.game.resultOfMove;
    }

    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

@end
