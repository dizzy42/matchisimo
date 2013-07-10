//
//  Deck.h
//  Matchisimo
//
//  Created by Timothy Payton on 7/10/13.
//  Copyright (c) 2013 Timothy Payton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
