//
//  TPViewController.m
//  Matchisimo
//
//  Created by Timothy Payton on 7/9/13.
//  Copyright (c) 2013 Timothy Payton. All rights reserved.
//

#import "MatchiViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "ThreeCardMatchingGame.h"

@interface MatchiViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeSwitchButton;

@end

@implementation MatchiViewController

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (IBAction)resetGame:(UIButton *)sender {
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.gameTypeSwitchButton addTarget:self
                                  action:@selector(resetGame:)
                        forControlEvents:UIControlEventValueChanged];
}

- (CardMatchingGame *)game
{
    if (!_game) {
        if ([self.gameTypeSwitchButton selectedSegmentIndex] == 0) {
            _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                      usingDeck:[[PlayingCardDeck alloc] init]];
        } else {
            NSLog(@"3 card game");
            _game = [[ThreeCardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                      usingDeck:[[PlayingCardDeck alloc] init]];            
        }
    }
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.7 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

@end
