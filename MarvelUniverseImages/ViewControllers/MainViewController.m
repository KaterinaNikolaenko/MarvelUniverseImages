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

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayCharacters = [[NSMutableArray alloc] init];
    Character *character = [[Character alloc] init];
    character.name = @"Dhoom";
    character.descriptionCharacter = @"reteyeueiieieieueeytetete";
    character.avatarUrl = @"http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg";
    [self.arrayCharacters addObject:character];
    
    character = [[Character alloc] init];
    character.name = @"DedhIshquiya";
    character.descriptionCharacter = @"dhjksdjksdhdshfjhdhsjkd";
    character.avatarUrl = @"http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16.jpg";
    [self.arrayCharacters addObject:character];
    
    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    self.tableView.contentInset = inset;
    self.tableView.scrollIndicatorInsets = inset;
    
    self.tableView.dataSource = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *destinationViewController = segue.destinationViewController;
    destinationViewController.currentCharacter = sender;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayCharacters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    Character *character = (self.arrayCharacters)[indexPath.row];
    cell.textLabel.text = character.name;
    cell.detailTextLabel.text = character.descriptionCharacter;
    cell.accessoryType = YES;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Character *character = (self.arrayCharacters)[indexPath.row];
    [self performSegueWithIdentifier:@"toDetails" sender: character];
}

@end
