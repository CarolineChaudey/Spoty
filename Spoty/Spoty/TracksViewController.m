//
//  TracksViewController.m
//  Spoty
//
//  Created by Caroline on 19/02/2017.
//  Copyright © 2017 esgi. All rights reserved.
//

#import "TracksViewController.h"

@interface TracksViewController ()

@end

@implementation TracksViewController

@synthesize parent = parent_;


- (IBAction)clickReturn:(id)sender {
    NSLog(@"On demande le retour");
}

- (instancetype)initWithParent:(HomeViewController *)parent {
    self = [super init];
    self.parent = parent;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.userInteractionEnabled = YES;
    [self.backButton addTarget:self action:@selector(clickReturn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
