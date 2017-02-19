//
//  ConnectionService.h
//  Spoty
//
//  Created by Caroline on 16/02/2017.
//  Copyright © 2017 esgi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeViewController.h"

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


- (void)featurePlaylist;

- (NSString*) CLIENT_SECRET;
- (NSString*) CLIENT_ID;
- (NSString*) REDIRECT_URI;

- (NSString*)getCodeFrom:(NSURL*)url;
- (NSData*) encodeDictionary:(NSDictionary*)dictionary;
- (BOOL) setTokens:(id)appDelegate;

- (NSArray*) fetchSearchResultWith:(NSString*)keyWords AndType:(NSString*)type;
- (void)featurePlaylist:(HomeViewController*)homeView;


@end
