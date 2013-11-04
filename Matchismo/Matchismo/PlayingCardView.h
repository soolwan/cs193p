//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Sean Coleman on 11/1/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

// We do not own a model object here so we can be
// model agnostic.

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;

@property (nonatomic) BOOL faceUp;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
