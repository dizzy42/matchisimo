//
//  ThreeCardMatchingGame.m
//  Matchisimo
//
//  Created by Timothy Payton on 7/11/13.
//  Copyright (c) 2013 Timothy Payton. All rights reserved.
//

#import "ThreeCardMatchingGame.h"
#import "_CardMatchingGame.h"

@implementation ThreeCardMatchingGame

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            NSIndexSet *indexSet = [self.cards indexesOfObjectsPassingTest:
                                    ^ BOOL(id obj, NSUInteger idx, BOOL *stop) {
                                        if ([obj isFaceUp] && ![obj isUnplayable]) {
                                            return YES;
                                        } else
                                            return NO;
                                    } ];

            if (indexSet.count == 2) {
                NSArray *result = [[NSArray alloc] initWithArray:[self.cards objectsAtIndexes:indexSet]];
                int matchScore = [card match:result];
                if (matchScore) {
                    [result[0] setUnplayable:YES];
                    [result[1] setUnplayable:YES];
                    card.unplayable = YES;
                    self.score += matchScore * MATCH_BONUS;
                } else {
                    [result[0] setFaceUp:NO];
                    [result[1] setFaceUp:NO];
                    self.score -= MISMATCH_PENALTY;
                }
                
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

@end
