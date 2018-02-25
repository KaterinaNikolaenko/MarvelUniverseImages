//
//  ServerManager.h
//  MarvelUniverseImages
//
//  Created by Katerina on 25.02.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerManager : NSObject

+ (ServerManager*) sharedManager;

- (void) getCharacterWithApikey:(NSString*) apikey
                           hash:(NSString*) hash
                           ts:(NSInteger) ts
                      onSuccess: (void(^)(NSArray* sharacters)) success
                      onFailure: (void(^)(NSError* error, NSInteger statusCode)) failure;

@end
