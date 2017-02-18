//
//  ConnectionService.m
//  Spoty
//
//  Created by Caroline on 16/02/2017.
//  Copyright © 2017 esgi. All rights reserved.
//

#import "ConnectionService.h"

@implementation ConnectionService

NSString *CLIENT_SECRET = @"8fce6078db874efaaf6d17412cf9a95c";
NSString *CLIENT_ID = @"830c60285d82492dab749e02b5864c5e";
NSString *REDIRECT_URI = @"spoty://oauth/callback";
static NSString *code = nil;
static NSString *token = nil;
static NSString *refresh_token = nil;


+ (NSString*) code {
    return code;
}
+ (NSString*) token {
    return token;
}
+ (NSString*) refresh_token {
    return refresh_token;
}

+ (void) setCode:(NSString*)nCode {
    code = nCode;
}
+ (void) setToken:(NSString*)nToken {
    token = nToken;
}
+ (void) setRefresh_token:(NSString*)nRefresh_token {
    refresh_token = nRefresh_token;
}


+ (NSString*) CLIENT_SECRET {
    return CLIENT_SECRET;
}
+ (NSString*) CLIENT_ID {
    return CLIENT_ID;
}
+ (NSString*) REDIRECT_URI {
    return REDIRECT_URI;
}

+ (NSString*)getCodeFrom:(NSURL*)url {
    // récupérer les paramètres de l'URL
    NSArray *queryParams = [[url query] componentsSeparatedByString:@"&"];
    NSArray *codeParam = [queryParams filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF BEGINSWITH %@", @"code="]];
    NSString *codeQuery = [codeParam objectAtIndex:0];
    NSString *code = [codeQuery stringByReplacingOccurrencesOfString:@"code=" withString:@""];
    
    return code;
}


+ (NSData*)encodeDictionary:(NSDictionary*)dictionary {
    // chaque paramètre du dictionnaire est mis dans une list sous la forme "clef=valeur"
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    for (NSString *key in dictionary) {
        NSString *encodedValue = [[dictionary objectForKey:key] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPasswordAllowedCharacterSet]];
        NSString *encodedKey = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPasswordAllowedCharacterSet]];
        
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject:part];
    }
    // on rajoute des & pour avoir la syntaxe des options d'URL
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}


+ (BOOL) setTokens:(AppDelegate*)appDelegate; {
    if (nil == [self code]) {
        return NO;
    }
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://accounts.spotify.com/api/token"]];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary * parameters = [[NSDictionary alloc] initWithObjectsAndKeys:@"authorization_code",@"grant_type",[self code],@"code",[self REDIRECT_URI],@"redirect_uri", [self CLIENT_ID],@"client_id", [self CLIENT_SECRET], @"client_secret", nil ];
    
    // appeler la fonction qui s'occupe d'encoder et construire notre requete
    NSData * requestBodyData = [self encodeDictionary:parameters];
    request.HTTPBody = requestBodyData;
    //  NSLog(@"TOKEN REQUETTE =============> %@", request.HTTPBody = requestBodyData);
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *requestBodyData, NSURLResponse *response, NSError *error) {
        
        if (!error){
            NSString *ret = [[NSString alloc] initWithData:requestBodyData encoding:NSUTF8StringEncoding];
            NSLog(@"REST========>%@", ret);
            
            // recuperer le token et resfresh_token dans un tableau
            NSArray *arrayToken = [ret componentsSeparatedByString:@":"];
            NSString *tokenType = [arrayToken objectAtIndex:1];
            NSArray *arrayT = [tokenType componentsSeparatedByString:@","];
            //token_ = [arrayT objectAtIndex:0];
            [self setToken:[arrayT objectAtIndex:0]];
            //refresh_token_ = [arrayToken objectAtIndex:4];
            [self setRefresh_token:[arrayToken objectAtIndex:4]];
            
            NSLog(@"TOKEN=============>%@\n", [self token]);
            NSLog(@"REFRESH-TOKEN=============>%@\n", [self refresh_token]);
            
            //[appDelegate accessApplication];
        }
        else {
            NSLog(@"ERREUR POST TOKEN %@", error);
        }
        
    }];
    [task resume];
    
    return YES;
}

+(NSArray*) fetchSearchResultWith:(NSString*)keyWords AndType:(NSString*)type {
    NSArray *results = [NSArray new];
    NSString *url = @"https://api.spotify.com/v1/search?q=";
    [url stringByAppendingString:keyWords];
    [url stringByAppendingString:@"&type="];
    [url stringByAppendingString:type];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *requestBodyData, NSURLResponse *response, NSError *error) {
        
        if (!error){
            NSString *ret = [[NSString alloc] initWithData:requestBodyData encoding:NSUTF8StringEncoding];
            NSLog(@"Resultats : %@", ret);
        } else {
            NSLog(@"ERREUR LORS DE LA RECUPERATION");
        }
    }
                                  return results;
}

@end
