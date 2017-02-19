//
//  TracksViewController.m
//  Spoty
//
//  Created by Caroline on 19/02/2017.
//  Copyright © 2017 esgi. All rights reserved.
//

#import "TracksViewController.h"
#import "AppDelegate.h"
#import "AudioViewController.h"

@interface TracksViewController ()

@property (nonatomic, strong) NSString *playlistHref;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) AudioViewController *audioView;

@end

@implementation TracksViewController

@synthesize parent = parent_;
@synthesize tracksData = tracksData_;


- (IBAction)clickReturn:(id)sender {
    NSLog(@"On demande le retour");
    [self.view removeFromSuperview];
}

- (instancetype)initWithParent:(HomeViewController *)parent andPlaylist:(NSString*)href {
    self = [super init];
    self.parent = parent;
    self.playlistHref = href;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.userInteractionEnabled = YES;
    [self.backButton addTarget:self action:@selector(clickReturn:) forControlEvents:UIControlEventTouchUpInside];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.coService getTracksForPlaylist:self.playlistHref andForView:self];
}

- (void) receiveData:(NSDictionary*)tracksData {
    self.tracksData = tracksData;
    NSLog(@"Receive track data : %@", self.tracksData);
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%lu", (unsigned long)[[self.tracksData objectForKey:@"name"] count]);
    return [[self.tracksData objectForKey:@"name"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [[self.tracksData objectForKey:@"name" ] objectAtIndex:indexPath.row];
    //NSLog(@"Cellule name : %@", [[self.tracksData objectForKey:@"name" ] objectAtIndex:indexPath.row]);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *trackUrl = [[self.tracksData objectForKey:@"url"] objectAtIndex:indexPath.row];
    self.audioView = [[AudioViewController alloc] initWithSound:trackUrl];
    [self.view addSubview:self.audioView.view];
}

@end
