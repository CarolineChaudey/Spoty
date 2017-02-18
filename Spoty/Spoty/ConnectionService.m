//
//  ConnectionService.m
//  Spoty
//
//  Created by Caroline on 16/02/2017.
//  Copyright © 2017 esgi. All rights reserved.
//

#import "ConnectionService.h"
#import "AppDelegate.h"

@implementation ConnectionService

NSString *CLIENT_SECRET = @"8fce6078db874efaaf6d17412cf9a95c";
NSString *CLIENT_ID = @"830c60285d82492dab749e02b5864c5e";
NSString *REDIRECT_URI = @"spoty://oauth/callback";
static NSMutableDictionary *playlist = nil;

@synthesize code = code_;
@synthesize token = token_;
@synthesize refreshToken = refreshToken_;


- (NSString*) CLIENT_SECRET {
    return CLIENT_SECRET;
}
- (NSString*) CLIENT_ID {
    return CLIENT_ID;
}
- (NSString*) REDIRECT_URI {
    return REDIRECT_URI;
}

- (NSString*)getCodeFrom:(NSURL*)url {
    // récupérer les paramètres de l'URL
    NSArray *queryParams = [[url query] componentsSeparatedByString:@"&"];
    NSArray *codeParam = [queryParams filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF BEGINSWITH %@", @"code="]];
    NSString *codeQuery = [codeParam objectAtIndex:0];
    NSString *code = [codeQuery stringByReplacingOccurrencesOfString:@"code=" withString:@""];
    
    return code;
}


- (NSData*)encodeDictionary:(NSDictionary*)dictionary {
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


- (BOOL) setTokens:(AppDelegate*)appDelegate {
    if (nil == self.code) {
        return NO;
    }
    NSLog(@"Je suis dans setTokens");
    
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
        NSLog(@"On a envoye la requete");
        if (!error){
            NSString *ret = [[NSString alloc] initWithData:requestBodyData encoding:NSUTF8StringEncoding];
            NSLog(@"REPONSE POUR LES TOKENS========>%@", ret);
            
            // recuperer le token et resfresh_token dans un tableau
            NSArray *arrayToken = [ret componentsSeparatedByString:@":"];
            NSString *tokenType = [arrayToken objectAtIndex:1];
            NSArray *arrayT = [tokenType componentsSeparatedByString:@","];
            [self setToken:[arrayT objectAtIndex:0]];
            self.refreshToken = [arrayToken objectAtIndex:4];
            
            [appDelegate spotifyConnection];
        }
        else {
            NSLog(@"ERREUR POST TOKEN %@", error);
        }
        
    }];
    [task resume];
    
    return YES;
    
}

-(NSArray*) fetchSearchResultWith:(NSString*)keyWords AndType:(NSString*)type {
    NSArray *results = [NSArray new];
    NSString *url = @"https://api.spotify.com/v1/search?q=";
    [url stringByAppendingString:keyWords];
    [url stringByAppendingString:@"&type="];
    [url stringByAppendingString:type];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *requestBodyData, NSURLResponse *response, NSError *error) {
        
        if (!error){
            NSString *ret = [[NSString alloc] initWithData:requestBodyData encoding:NSUTF8StringEncoding];
            NSLog(@"Resultats : %@", ret);
        } else {
            NSLog(@"ERREUR LORS DE LA RECUPERATION");
        }
    }];
    return results;
}

- (void)featurePlaylist
{
    NSLog(@"je suis dans featured ====> ");
    NSString *urlFearture = @"https://api.spotify.com/v1/browse/featured-playlists";
    
    NSURL *url = [NSURL URLWithString:urlFearture];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    
    NSString *headersAuth = [NSString stringWithFormat:@"Bearer %@", self.token];
    NSLog(@"TOKEN RECUPERE = %@", self.token);
    
    [urlRequest setValue:headersAuth forHTTPHeaderField:@"Authorization"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error)
        {
            NSLog(@"ERROR FEATURE PLAYLIST");
        }
        else
        {
            NSError *err = nil;
            NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
            
            NSLog(@"REST========>%@", jsonResult);
            /*NSString *rets = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];*/
            //NSLog(@"REST========>%@", jsonResult);
            
            if( !err && [jsonResult objectForKey:@"playlists"] ) {
                NSArray *list  = [[jsonResult objectForKey:@"playlists"] objectForKey:@"items"];
                NSMutableDictionary *playlist = [[NSMutableDictionary alloc] init];
                //for (NSDictionary *playlistObj in list) {
                //NSError *error=nil;
                //if(!error) {
                // [results addObject:playlist];
                
                //   NSLog(@"PPPPPP=======> %@", playlistObj);
                //NSLog(@"%@ lisst==>", list);
                /*   NSLog(@"IIIIMMMMMMMMAAGGESS ==> %@, nnnaammmee ===> %@, traakkk ===> %@", [list valueForKey:@"images"], [list valueForKey:@"name"], [list valueForKey:@"tracks"]);*/
                [playlist setObject:[list valueForKey:@"images"] forKey:@"image"];
                [playlist setObject:[list valueForKey:@"name"] forKey:@"name"];
                [playlist setObject:[list valueForKey:@"tracks"] forKey:@"tracks"];
                
                //image = [list valueForKey:@"images"];
                // NSLog(@"RESSUULLTTT =====> %@", [result[0] objectForKey:@"name"]);
                //return (result);
                //  NSArray *arrayT  = [[jsonResult objectForKey:@"name"]
                
                
                //NSString* revname = [result componentsJoinedByString:@", "];
                //NSLog(@"%@", err);
                //    }
                // }
            }
        }
    }];
    
    /*   NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: @"http://myurl/mypic.jpg"]];
     cell.image = [UIImage imageWithData: imageData];
     [imageData release];*/
}

@end
