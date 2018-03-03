//
//  AppDelegate.h
//  MarvelUniverseImages
//
//  Created by Katerina on 15.02.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (void)saveContext;


@end

