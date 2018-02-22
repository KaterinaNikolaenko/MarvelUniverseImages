//
//  Character.h
//  MarvelUniverseImages
//
//  Created by Katerina on 16.02.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Character : NSObject

@property (nonatomic, assign) int *idCharacter;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *descriptionCharacter;
@property (nonatomic, strong) NSString *avatarUrl;

@end
