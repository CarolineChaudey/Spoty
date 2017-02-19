//
//  HomeViewController.m
//  Spoty
//
//  Created by Caroline on 16/02/2017.
//  Copyright © 2017 esgi. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize playlists = playlists_;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"HOME VIEW CONTROLLER");
    //[self.coService featurePlaylist];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.coService featurePlaylist:self];
    
}

-(void)receivePlaylists:(NSMutableDictionary*)data {
    self.playlists = data;
    NSLog(@"HomeView has now the data : %@", self.playlists);
}


- (void)viewDidAppear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
