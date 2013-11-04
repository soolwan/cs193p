//
//  PlayingCardCollectionViewCell.h
//  Matchismo
//
//  Created by Sean Coleman on 11/4/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardView.h"

@interface PlayingCardCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;
@end