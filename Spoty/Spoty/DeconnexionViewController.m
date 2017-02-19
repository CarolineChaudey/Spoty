//
//  DeconnexionViewController.m
//  Spoty
//
//  Created by Caroline on 17/02/2017.
//  Copyright © 2017 esgi. All rights reserved.
//

#import "DeconnexionViewController.h"
#import "AppDelegate.h"

@interface DeconnexionViewController ()

@end

@implementation DeconnexionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    [appDelegate displayWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
