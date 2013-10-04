//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Sean Coleman on 10/3/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
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

- (void)updateUI
{
    
}

@end
