//
//  HomeViewController.m
//  Spoty
//
//  Created by Caroline on 16/02/2017.
//  Copyright © 2017 esgi. All rights reserved.
//

#import "HomeViewController.h"
#import "ConnectionService.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize coService = coService_;

-(instancetype)initWithService:(ConnectionService *)service {
    self.coService = service;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"HOME VIEW CONTROLLER");
    [self.coService featurePlaylist];
}

- (void)viewDidAppear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
