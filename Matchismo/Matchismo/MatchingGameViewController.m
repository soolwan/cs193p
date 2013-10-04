//
//  MatchingGameViewController.m
//  Matchismo
//
//  Created by Sean Coleman on 10/4/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "MatchingGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface MatchingGameViewController ()

@end

@implementation MatchingGameViewController

- (Game *)game
{
    if (!_game) _game =
        [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                          usingDeck:[[PlayingCardDeck alloc] init]];
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


- (void)updateUI
{
    UIImage *cardBackImage = [UIImage imageNamed:@"cardBack.png"];
    
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        // A button shows its normal title whenever it is in a state or combination of
        // states for which you have not set a title. We need the title set when the button is
        // both selected and disabled.
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        
        if (cardButton.selected == NO) {
            [cardButton setBackgroundImage:cardBackImage forState:UIControlStateNormal];
        } else {
            [cardButton setBackgroundImage:nil forState:UIControlStateNormal];
        }
        
        self.resultsLabel.text = self.game.resultOfMove;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

@end
