//
//  AppDelegate.h
//  Spoty
//
//  Created by Caroline on 16/02/2017.
//  Copyright © 2017 esgi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "SearchViewController.h"
#import "ConnectionService.h"
#import "WebViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UITabBarController *menuCtrl_;
    WebViewController *wvc_;
    UIWebView *oauthView_;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UITabBarController *menuCtrl;
@property (strong, nonatomic) WebViewController *wvc;
@property (strong, nonatomic) UIWebView *oauthView;

-(BOOL) accessApplication;

@end

