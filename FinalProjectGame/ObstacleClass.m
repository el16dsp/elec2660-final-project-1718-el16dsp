//
//  ObstacleClass.m
//  FinalProjectGame
//
//  Created by Daniel Piper [el16dsp] on 13/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "ObstacleClass.h"

@implementation ObstacleClass

- (instancetype)init:(NSInteger) InputLevel
{
    self = [super init];
    if (self) {
        NSInteger RandomResult = arc4random() % 3;
        
        self.Ability = [[WeaponClass alloc] init];
        
        if (RandomResult == 0) { // Door
            [self GenerateDoor:InputLevel];
        } else if (RandomResult == 1) { // Chest
            [self GenerateChest:InputLevel];
        } else { // Enemy
            [self GenerateEnemy:InputLevel];
        }
    }
    return self;
}

-(NSInteger) ReturnHealth {
    if (self.CurrentHealth < 0) {
        self.CurrentHealth = 0;
    }
    return self.CurrentHealth;
}

-(void) GenerateChest:(NSInteger)DesiredLevel {
    self.Name = @"Chest";
    self.ImageBasis = @"chest";
    self.Level = DesiredLevel;
    self.MaxHealth = (6+(arc4random() % 5))*self.Level; // (6 to 10) * level
    self.CurrentHealth = self.MaxHealth;
    self.Armour = 0;
    self.Reward = (10+(arc4random() % 5))*self.Level; // (11 to 20) * level
    
    self.Ability.DamagePerClick = 0;
    self.Ability.AutoClickLoadRate = 0;
}

-(void) GenerateDoor:(NSInteger)DesiredLevel {
    self.Name = @"Door";
    self.ImageBasis = @"door";
    self.Level = DesiredLevel;
    self.MaxHealth = (6+(arc4random() % 5))*self.Level; // (6 to 10) * level
    self.CurrentHealth = self.MaxHealth;
    self.Armour = 0;
    self.Reward = ((arc4random() % 5) + 1)*self.Level; // (1 to 5) * level
    
    self.Ability.DamagePerClick = 0;
    self.Ability.AutoClickLoadRate = 0;
}

-(void) GenerateEnemy:(NSInteger)DesiredLevel {
    self.Name = @"Enemy";
    self.ImageBasis = @"enemy";
    self.Level = DesiredLevel;
    self.MaxHealth = (6+(arc4random() % 5))*self.Level; // (6 to 10) * level
    self.CurrentHealth = self.MaxHealth;
    self.Armour = arc4random() % self.Level; // (0 to level)
    self.Reward = ((arc4random() % 5) + 1)*self.Level; // (1 to 5) * level
    
    self.Ability.Level = DesiredLevel;
    self.Ability.ClicksPerClip = roundf((float)(self.Level / ((arc4random() % self.Level) + 1)));
    self.Ability.DamagePerClick = roundf((float)(self.Level / ((arc4random() % self.Level) + 1)));
    self.Ability.ClickAmount = arc4random() % self.Ability.ClicksPerClip; // Random amount of readiness
    self.Ability.StunDuration = 0;
    self.Ability.AutoClickLoadRate = 1;
}

@end