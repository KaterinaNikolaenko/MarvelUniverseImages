//
//  Character+CoreDataProperties.m
//  MarvelUniverseImages
//
//  Created by Katerina on 27.02.18.
//  Copyright © 2018 Katerina. All rights reserved.
//
//

#import "Character+CoreDataProperties.h"

@implementation Character (CoreDataProperties)

+ (NSFetchRequest<Character *> *)fetchRequest {
    return [[NSFetchRequest alloc] initWithEntityName:@"Character"];
}

- (id) initWithServerResponse:(NSDictionary*) responseObject
{
    self = [super init];
    if (self) {
        self.idCharacter = [[responseObject objectForKey:@"id"] integerValue];
        self.name = [responseObject objectForKey:@"name"];
        self.descriptionCharacter = [responseObject objectForKey:@"description"];
        
        NSDictionary* responseThumbnail = [responseObject objectForKey:@"thumbnail"];
        NSString* responsePath = [responseThumbnail objectForKey:@"path"];
        NSString* responseExtension = [responseThumbnail objectForKey:@"extension"];
        
        self.avatarUrl = [NSString stringWithFormat: @"%@.%@", responsePath, responseExtension];
    }
    return self;
}

@dynamic avatarUrl;
@dynamic descriptionCharacter;
@dynamic idCharacter;
@dynamic name;

@end
