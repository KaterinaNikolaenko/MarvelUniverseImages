//
//  ServerManager.m
//  MarvelUniverseImages
//
//  Created by Katerina on 25.02.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

#import "ServerManager.h"
#import "AFNetworking.h"
#import "Character.h"

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
      
        NSDictionary* responseData = [responseObject objectForKey:@"data"];
        NSArray* dictsArray = [responseData objectForKey:@"results"];
       
//        NSLog(@"responseDictNew: %@", dictsArray);
        
        NSMutableArray* objectsArray = [NSMutableArray array];
        for (NSDictionary* dict in dictsArray) {
            Character* character = [[Character alloc] initWithServerResponse:dict];
            [objectsArray addObject:character];
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
