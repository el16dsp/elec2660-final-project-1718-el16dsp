//
//  GameController.h
//  FinalProjectGame
//
//  Created by Daniel Piper [el16dsp] on 14/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayerClass.h"

@interface GameController : NSObject

@property (strong, nonatomic) PlayerClass *Player; // Stores current player data but is initiated by copying one from DataStore
@property (nonatomic) NSInteger Coins; // Stores the points gained in the runthrough
@property (nonatomic) NSInteger ClicksPressed; // Stores the number of buttons pressed in this runthrough
@property (strong, nonatomic) NSMutableArray *ObstacleArray; // Stores the obstacles that the player has to overcome. Is regenerated upon overcoming the last one
@property (nonatomic) NSInteger RoomInteger;
@property (nonatomic) NSInteger CurrentObstacle;

-(NSInteger)GenerateObstacleArray; // (Re)creates the ObstacleArray to have a number of encounters equal to the tick counter % a constant. Last encounter is always a door
-(void)OnAnyTick; // Does stuff like auto-loads obstacle and player abilities. If any of those abilities are at full charge, damage is done.

-(void)OnObstacleClick; // If player has a weapon, it will do damage
-(void)OnButton1Click; // Player ability amount will be incremented and label updated
-(void)OnButton2Click; // Same as above
-(void)ObstacleImageUpdate: (NSString *)NewImageName; // Change obstacle image with the image that has the same name as NewImageName
-(void)PlayerImageUpdate: (NSString *)NewImageName; // Same as above but for the player image

/*
 Stuff to send back to the view controller:
   * String of Player Health values (@"%ld/%ld", Current, Max)
   * String of Button1 values (@"%ld/%ld", Current, Max)
   * String of Button2 values (@"%ld/%ld", Current, Max)
   * String of Player image names
   * String of Obstacle image names
 */

@end
