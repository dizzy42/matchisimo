//
//  CardMatchingGame__CardMatchingGame_h.h
//  Matchisimo
//
//  Created by Timothy Payton on 7/11/13.
//  Copyright (c) 2013 Timothy Payton. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

@end