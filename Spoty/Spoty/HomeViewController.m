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

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation HomeViewController

@synthesize playlists = playlists_;

- (void)viewDidLoad {
    [super viewDidLoad];
    // on passe par le AppDeleguate pour accéder au service de connexion pour éviter les circular references
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.coService featurePlaylist:self];
    
}

-(void)receivePlaylists:(NSMutableDictionary*)data {
    self.playlists = data;
    NSLog(@"HomeView has now the data : %@", self.playlists);
    [self.tableView setDataSource:self];
    [self.tableView reloadData];
    NSLog(@"On a les titres : %@", [self.playlists objectForKey:@"name"]);
}


- (void)viewDidAppear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Notre liste doit faire cette taille : %lu", (unsigned long)[[self.playlists objectForKey:@"name"] count]);
    return [[self.playlists objectForKey:@"name"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"unePlaylist";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    // get the names
    NSString *playName = [[self.playlists objectForKey:@"name"] objectAtIndex:indexPath.row];
    NSString *playNumber = [[[self.playlists objectForKey:@"tracks"] objectAtIndex:indexPath.row] objectForKey:@"total"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ : %@ morceaux", playName, playNumber];
    //[cell.textLabel.text stringByAppendingString:@" : %@ tracks", [[self.playlists objectForKey:@"tracks"] objectForKey:@"total"]];
    //NSLog(@"On fait la ligne : %d", indexPath.row);
    
    return cell;
}

@end
