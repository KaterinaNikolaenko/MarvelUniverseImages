//
//  ViewController.m
//  MarvelUniverseImages
//
//  Created by Katerina on 15.02.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"
#import "Character.h"
#import "CharacterTableViewCell.h"
#import "ServerManager.h"
#import "NSString+MD5.h"
#import "UIImageView+AFNetworking.h"

@implementation MainViewController

static NSString *apiKeyPublic = @"8a500a4f258ff08764dc94dd384f89ba";
static NSString *apiKeyPrivate = @"1";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayCharacters = [[NSMutableArray alloc] init];
    self.tableView.dataSource = self;
    
    [self getCharacterFromServer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *destinationViewController = segue.destinationViewController;
    destinationViewController.currentCharacter = sender;
}

#pragma mark - API

-(void) getCharacterFromServer {
    
    NSString *hashString = [NSString stringWithFormat: @"1%@%@", apiKeyPrivate, apiKeyPublic];
    
    [[ServerManager sharedManager] getCharacterWithApikey:apiKeyPublic hash:[hashString MD5] ts:1 onSuccess:^(NSArray *characters) {
        
        [self.arrayCharacters addObjectsFromArray:characters];
        [self.tableView reloadData];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"error = %@ code = %ld", [error localizedDescription], (long)statusCode);
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayCharacters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";

    CharacterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    Character *character = (self.arrayCharacters)[indexPath.row];
    cell.nameLabel.text = character.name;
    cell.descriptionLabel.text = character.descriptionCharacter;
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",character.avatarUrl]];
    [cell.avatarImageView setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"placeHolder"]];

    cell.accessoryType = YES;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Character *character = (self.arrayCharacters)[indexPath.row];
    [self performSegueWithIdentifier:@"toDetails" sender: character];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
