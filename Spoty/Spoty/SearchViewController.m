//
//  SearchViewController.m
//  Spoty
//
//  Created by Caroline on 16/02/2017.
//  Copyright © 2017 esgi. All rights reserved.
//

#import "SearchViewController.h"
#import "AppDelegate.h"

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UITableView *searchView;
@end

@implementation SearchViewController

@synthesize searchresults = searchresults_;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Accès au service de connexion via un AppDelegate
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.coService fetchSearchResultWith:self AndType:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.searchresults objectForKey:@"artist"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"unArtiste";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    // Populate the rows with searchresults
    NSString *artistName = [[self.searchresults objectForKey:@"name"] objectAtIndex:indexPath.row];
    NSString *albumName = [[[self.searchresults objectForKey:@"albums"] objectAtIndex:indexPath.row] objectForKey:@"total"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ : %@ morceaux", artistName, albumName];
    
    
    return cell;
}
@end
