//
//  TPViewController.m
//  Matchisimo
//
//  Created by Timothy Payton on 7/9/13.
//  Copyright (c) 2013 Timothy Payton. All rights reserved.
//

#import "MatchiViewController.h"
#import "PlayingCardDeck.h"

@interface MatchiViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) PlayingCardDeck *deck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation MatchiViewController

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    [sender setTitle:[[self.deck drawRandomCard] contents] forState:UIControlStateSelected];
    self.flipCount++;
}

- (PlayingCardDeck *)deck
{
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

@end
