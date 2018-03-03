//
//  ViewController.h
//  MarvelUniverseImages
//
//  Created by Katerina on 15.02.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface MainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *arrayCharacters;
@property(retain,nonatomic)AppDelegate *appDelegate;

@end

