//
//  Character.m
//  MarvelUniverseImages
//
//  Created by Katerina on 16.02.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

#import "Character.h"

@implementation Character

- (id) initWithServerResponse:(NSDictionary*) responseObject
{
    self = [super init];
    if (self) {
        self.idCharacter = [responseObject objectForKey:@"id"];
        self.name = [responseObject objectForKey:@"name"];
        self.descriptionCharacter = [responseObject objectForKey:@"description"];
        
        NSDictionary* responseThumbnail = [responseObject objectForKey:@"thumbnail"];
        NSString* responsePath = [responseThumbnail objectForKey:@"path"];
        NSString* responseExtension = [responseThumbnail objectForKey:@"extension"];

        self.avatarUrl = [NSString stringWithFormat: @"%@.%@", responsePath, responseExtension];
    }
    return self;
}

@end
