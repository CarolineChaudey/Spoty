//
//  ConnectionService.h
//  Spoty
//
//  Created by Caroline on 16/02/2017.
//  Copyright © 2017 esgi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeViewController.h"
#import "TracksViewController.h"
#import "SearchViewController.h"

@class ConnectionService;
@interface ConnectionService : NSObject {
    NSString *code_;
    NSString *token_;
    NSString *refreshToken_;
}

extern const NSString *CLIENT_SECRET;
extern const NSString *CLIENT_ID;
extern const NSString *REDIRECT_URI;

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *refreshToken;


- (NSString*) CLIENT_SECRET;
- (NSString*) CLIENT_ID;
- (NSString*) REDIRECT_URI;

- (NSString*)getCodeFrom:(NSURL*)url;
- (NSData*) encodeDictionary:(NSDictionary*)dictionary;
- (BOOL) setTokens:(id)appDelegate;

/*- (void) fetchSearchResultWith:(NSString*)keyWords AndType:(NSString*)type;*/
- (void)featurePlaylist:(HomeViewController*)homeView;

- (void)getTracksForPlaylist:(NSString*)href andForView:(TracksViewController*)tracksView;
- (void)searchData:(SearchViewController*)searchView;


@end
