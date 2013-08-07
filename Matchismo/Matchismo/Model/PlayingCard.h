//
//  PlayingCard.h
//  Matchismo
//
//  Created by Sean Coleman on 8/7/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
