//
//  ConnectionService.h
//  Spoty
//
//  Created by Caroline on 16/02/2017.
//  Copyright © 2017 esgi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface ConnectionService : NSObject

extern const NSString *CLIENT_SECRET;
extern const NSString *CLIENT_ID;
extern const NSString *REDIRECT_URI;

+ (NSString*) code;
+ (NSString*) token;
+ (NSString*) refresh_token;



+ (void) setCode:(NSString*)nCode;
+ (void) setToken:(NSString*)nToken;
+ (void) setRefresh_token:(NSString*)nRefresh_token;
+ (void)featurePlaylist;

+ (NSString*) CLIENT_SECRET;
+ (NSString*) CLIENT_ID;
+ (NSString*) REDIRECT_URI;

+ (NSString*)getCodeFrom:(NSURL*)url;
+ (NSData*) encodeDictionary:(NSDictionary*)dictionary;
+ (BOOL) setTokens:(id)appDelegate;

+(NSArray*) fetchSearchResultWith:(NSString*)keyWords AndType:(NSString*)type;

@end
