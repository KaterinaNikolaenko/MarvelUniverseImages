//
//  DetailViewController.h
//  MarvelUniverseImages
//
//  Created by Katerina on 22.02.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character+CoreDataClass.h"

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (assign) Character *currentCharacter;

@end
