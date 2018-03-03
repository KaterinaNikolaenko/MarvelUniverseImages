//
//  Character+CoreDataProperties.h
//  MarvelUniverseImages
//
//  Created by Katerina on 27.02.18.
//  Copyright © 2018 Katerina. All rights reserved.
//
//

#import "Character+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Character (CoreDataProperties)

+ (NSFetchRequest<Character *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *avatarUrl;
@property (nullable, nonatomic, copy) NSString *descriptionCharacter;
@property (nonatomic) int64_t idCharacter;
@property (nullable, nonatomic, copy) NSString *name;

- (id) initWithServerResponse:(NSDictionary*) responseObject;

@end

NS_ASSUME_NONNULL_END
