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
        self.Ability = [[WeaponClass alloc] init];
        self.StunnedFor = 0;
        self.Ability.StunDuration = 0;
        self.ImageBasis = @"placeholder";
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
    self.ImageBasis = @"chest_idle";
    self.Level = DesiredLevel;
    self.MaxHealth = (6+(arc4random() % 5))*self.Level; // (6 to 10) * level
    self.CurrentHealth = self.MaxHealth;
    self.Armour = 0;
    self.Reward = 0;
    
    self.Ability = [[WeaponClass alloc] init];
    self.Ability.Type = @"A";
    self.Ability.DamagePerClick = 0;
    self.Ability.AutoClickLoadRate = 0;
    
    NSLog(@"Generated chest of level %ld", DesiredLevel);
}

-(void) GenerateChestDead:(NSInteger)DesiredLevel {
    self.Name = @"Chest";
    self.ImageBasis = @"chest_dead";
    self.Level = DesiredLevel;
    self.MaxHealth = 1; // (6 to 10) * level
    self.CurrentHealth = self.MaxHealth;
    self.Armour = 0;
    self.Reward = (10+(arc4random() % 5))*self.Level; // (11 to 20) * level
    
    self.Ability = [[WeaponClass alloc] init];
    self.Ability.Type = @"A";
    self.Ability.DamagePerClick = 0;
    self.Ability.AutoClickLoadRate = 0;
    
    NSLog(@"Generated dead chest of level %ld", DesiredLevel);
}

-(void) GenerateDoor:(NSInteger)DesiredLevel {
    self.Name = @"Door";
    self.ImageBasis = @"door_idle";
    self.Level = DesiredLevel;
    self.MaxHealth = (6+(arc4random() % 5))*self.Level; // (6 to 10) * level
    self.CurrentHealth = self.MaxHealth;
    self.Armour = 0;
    self.Reward = 0;
    
    self.Ability = [[WeaponClass alloc] init];
    self.Ability.Type = @"A";
    self.Ability.DamagePerClick = 0;
    self.Ability.AutoClickLoadRate = 0;
    
    NSLog(@"Generated door of level %ld", DesiredLevel);
}

-(void) GenerateDoorDead:(NSInteger)DesiredLevel {
    self.Name = @"Door";
    self.ImageBasis = @"door_dead";
    self.Level = DesiredLevel;
    self.MaxHealth = 1;
    self.CurrentHealth = self.MaxHealth;
    self.Armour = 0;
    self.Reward = ((arc4random() % 5) + 1)*self.Level; // (1 to 5) * level
    
    self.Ability = [[WeaponClass alloc] init];
    self.Ability.Type = @"A";
    self.Ability.DamagePerClick = 0;
    self.Ability.AutoClickLoadRate = 0;
    
    NSLog(@"Generated dead door of level %ld", DesiredLevel);
}

-(void) GenerateEnemy:(NSInteger)DesiredLevel {
    self.Name = @"Enemy";
    self.ImageBasis = @"enemy_idle";
    self.Level = DesiredLevel;
    self.MaxHealth = (6+(arc4random() % 5))*self.Level; // (6 to 10) * level
    self.CurrentHealth = self.MaxHealth;
    self.Armour = arc4random() % self.Level; // (0 to level)
    self.Reward = ((arc4random() % 5) + 1)*self.Level; // (1 to 5) * level
    
    self.Ability = [[WeaponClass alloc] init];
    self.Ability.Level = DesiredLevel;
    self.Ability.Type = @"A";
    self.Ability.ClicksPerClip = 1 + ((float)self.Level / ((arc4random() % self.Level) + 1));
    self.Ability.DamagePerClick = roundf((float)(self.Level / ((arc4random() % self.Level) + 1)));
    self.Ability.ClickAmount = arc4random() % self.Ability.ClicksPerClip; // Random amount of readiness
    self.Ability.StunDuration = 0;
    self.Ability.AutoClickLoadRate = 1;
    
    NSLog(@"Generated enemy of level %ld", DesiredLevel);
}

-(NSInteger) GetClickAmount {
    return self.Ability.ClickAmount;
}

-(BOOL) IsStunned {
    BOOL Stunned;
    if (self.StunnedFor > 0) {
        // Is stunned
        Stunned = YES;
        self.StunnedFor -= 1;
    } else {
        Stunned = NO;
    }
    NSLog(@"Obstacle stunned: %d for %ld turns", Stunned, self.StunnedFor +1);
    return Stunned;
}

-(NSString *) TakeDamage:(NSInteger)DamageAmount
                        :(NSInteger)StunAmount {
    // Handle stuns. Only apply larger stun
    NSLog(@"Current obstacle stun %ld", self.StunnedFor);
    if (self.StunnedFor < StunAmount) {
        self.StunnedFor = StunAmount;
    }
    NSLog(@"Obstacle Stunned for %ld to %ld", StunAmount, self.StunnedFor);
    
    NSLog(@"Obstacle taking damage of %ld from %ld to %ld", DamageAmount, self.CurrentHealth, self.CurrentHealth - DamageAmount);
    self.CurrentHealth -= DamageAmount;
    if (self.CurrentHealth < 0) {
        self.CurrentHealth = 0;
    }
    
    NSString *HealthLabel = [NSString stringWithFormat:@"%ld/%ld", self.CurrentHealth, self.MaxHealth];
    NSLog(@"Obstacle health is %@", HealthLabel);
    return HealthLabel;
}

-(NSString *) GetName {
    return self.Name;
}

-(NSString *) GetImageName {
    return self.ImageBasis;
}

-(NSInteger) GetMaxClicks {
    return self.Ability.ClicksPerClip;
}

-(NSInteger) GetAutoClicks {
    return self.Ability.AutoClickLoadRate;
}

@end
