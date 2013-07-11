//
//  CardMatchingGame.m
//  Matchisimo
//
//  Created by tim_payton on 7/11/13.
//  Copyright (c) 2013 Timothy Payton. All rights reserved.
//

#import "CardMatchingGame.h"
#import "_CardMatchingGame.h"

@implementation CardMatchingGame


- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    self.lastFlipDescription = nil;
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        self.lastFlipDescription = [NSString stringWithFormat:@"%@ and %@ for %i points", card.contents, otherCard.contents, matchScore * MATCH_BONUS];
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.lastFlipDescription = [NSString stringWithFormat:@"%@ and %@ don't match! %i point penalty", card.contents, otherCard.contents, MISMATCH_PENALTY];
                        
                    }
                    break;
                }
            }
            if (!self.lastFlipDescription) {
                self.lastFlipDescription = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }

}


@end
