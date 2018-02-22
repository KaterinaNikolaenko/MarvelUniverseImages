//
//  DetailViewController.m
//  MarvelUniverseImages
//
//  Created by Katerina on 22.02.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"currentCharacter = %@", self.currentCharacter.name);
    self.nameLabel.text = self.currentCharacter.name;

    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.currentCharacter.avatarUrl]];
    dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(q, ^{
        NSData *data = [NSData dataWithContentsOfURL:imgUrl];
        UIImage *img = [[UIImage alloc] initWithData:data];

        dispatch_async(dispatch_get_main_queue(), ^{

            [self.avatarImageView setImage:img];
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
