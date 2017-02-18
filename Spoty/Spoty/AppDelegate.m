//
//  AppDelegate.m
//  Spoty
//
//  Created by Caroline on 16/02/2017.
//  Copyright © 2017 esgi. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "SearchViewController.h"
#import "WebViewController.h"
#import "DeconnexionViewController.h"
#import "ConnectionService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize menuCtrl = menuCtrl_;
@synthesize wvc = wvc_;
@synthesize oauthView  = oauthView_;
@synthesize coService = coService_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.coService = [ConnectionService new];
    
    // on prepare la fenetre
    CGRect screenRect = [UIScreen mainScreen].bounds;
    self.window = [[UIWindow alloc] initWithFrame:screenRect];
    
    // création de la requête de demande de token
    NSURL *authURL = [NSURL URLWithString:@"https://accounts.spotify.com/authorize?client_id=830c60285d82492dab749e02b5864c5e&response_type=code&redirect_uri=spoty://oauth/callback"];
    NSURLRequest *request = [NSURLRequest requestWithURL:authURL];
    
    
    // on créé la vue web qui affichera la page d'authentification de spotify
    self.oauthView = [[UIWebView alloc] initWithFrame:screenRect];
    [self.oauthView loadRequest:request];
    self.wvc = [[WebViewController alloc] init];
    
    [self displayWebView];
    
    return YES;
}
/*
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"La valeur de token a changee");
    [self spotifyConnection];
}
*/
-(void)displayWebView {
    NSLog(@"displayWebView");
    [self.oauthView setDelegate:self.wvc];
    [self.wvc.view addSubview:self.oauthView];
    self.window.rootViewController = self.wvc;
    [self.window makeKeyAndVisible];
}

-(void)spotifyConnection {
    
    // on prepare les "vues" du menu
    HomeViewController *homeCtrl = [[HomeViewController alloc] initWithService:self.coService];
    SearchViewController *searchCtrl = [SearchViewController new];
    DeconnexionViewController *decoCtrl = [DeconnexionViewController new];
    NSLog(@"Les 3 options sont creees");
    
    // on créé le menu et on le remplit avec les "vues"
    self.menuCtrl = [[UITabBarController alloc] init];
    self.menuCtrl.viewControllers = [NSArray arrayWithObjects:homeCtrl , searchCtrl, decoCtrl, nil];
    
    // customization des items de la tab bar
    [[self.menuCtrl.tabBar items] objectAtIndex:0].title = @"Home";
    [[self.menuCtrl.tabBar items] objectAtIndex:1].title = @"Search";
    [[self.menuCtrl.tabBar items] objectAtIndex:2].title = @"Quit";
    
    //NSLog(@"On tente le main thread");
    [self performSelectorOnMainThread:@selector(accessApplication) withObject:nil waitUntilDone:NO];
}

- (BOOL)accessApplication {
    
    NSLog(@"On accede a l'application.");
    [self.oauthView removeFromSuperview];
    self.window.rootViewController = self.menuCtrl;
    [self.menuCtrl setSelectedIndex:0];
    
    return YES;
}

// "attrape" la réponse de l'API, agit comme une route dans une application web
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    NSLog(@"On a renvoyé une réponse ---------------------->: %@", url);
    
    if ([url.absoluteString rangeOfString:@"spoty://oauth/callback?code="].location != NSNotFound) {
        [self.coService setCode:[self.coService getCodeFrom:url]];
        [self.coService setTokens:self];
        // attendre que  le token ai changé
        
        return YES;
    }
    return NO;
}

-(NSString*)getCodeFrom:(NSURL*)url {
    // récupérer les paramètres de l'URL
    NSArray *queryParams = [[url query] componentsSeparatedByString:@"&"];
    NSArray *codeParam = [queryParams filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF BEGINSWITH %@", @"code="]];
    NSString *codeQuery = [codeParam objectAtIndex:0];
    NSString *code = [codeQuery stringByReplacingOccurrencesOfString:@"code=" withString:@""];
    
    return code;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
