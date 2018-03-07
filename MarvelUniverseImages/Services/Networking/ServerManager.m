//
//  ServerManager.m
//  MarvelUniverseImages
//
//  Created by Katerina on 25.02.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

#import "ServerManager.h"
#import "AFNetworking.h"
#import "Character+CoreDataClass.h"

@interface ServerManager()

@property (strong, nonatomic) AFHTTPSessionManager* requestManager;

@end

@implementation ServerManager

+ (ServerManager*) sharedManager {
    static ServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerManager alloc] init];
    });
    return manager;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSURL* url = [NSURL URLWithString:@"https://gateway.marvel.com:443/v1/public/"];
        self.requestManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
         _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void) getCharacterWithApikey:(NSString*) apikey
                           hash:(NSString*) hash
                             ts:(NSInteger) ts
                      onSuccess: (void(^)(NSArray* sharacters)) success
                      onFailure: (void(^)(NSError* error, NSInteger statusCode)) failure
{
    NSDictionary *parameters =
    [NSDictionary dictionaryWithObjectsAndKeys:
     @(ts), @"ts",
     apikey, @"apikey",
     hash, @"hash", nil];
    
    [self.requestManager GET:@"characters" parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Character"];
        NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
        
        NSError *deleteError = nil;
        [_appDelegate.coordinator executeRequest:delete withContext:_appDelegate.managedObjectContext error:&deleteError];
        
        NSDictionary* responseData = [responseObject objectForKey:@"data"];
        NSArray* dictsArray = [responseData objectForKey:@"results"];
        
        NSMutableArray* objectsArray = [NSMutableArray array];
        for (NSDictionary* dict in dictsArray) {
            Character *character = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:_appDelegate.managedObjectContext];
            character.idCharacter = [[dict objectForKey:@"id"] integerValue];
            character.name = [dict objectForKey:@"name"];
            character.descriptionCharacter = [dict objectForKey:@"description"];
            
            NSDictionary* responseThumbnail = [dict objectForKey:@"thumbnail"];
            NSString* responsePath = [responseThumbnail objectForKey:@"path"];
            NSString* responseExtension = [responseThumbnail objectForKey:@"extension"];
            
            character.avatarUrl = [NSString stringWithFormat: @"%@.%@", responsePath, responseExtension];
            [objectsArray addObject:character];
            NSError *error = nil;
            if (![_appDelegate.managedObjectContext save:&error]) {
                NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
            }
        }
        
        if (success) {
            success(objectsArray);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if (failure) {
            NSInteger statusCode = 0;
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)operation.response;
            statusCode = httpResponse.statusCode;
            failure(error, statusCode);
        }
    }];
}

@end
