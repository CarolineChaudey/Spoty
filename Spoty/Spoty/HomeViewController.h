//
//  HomeViewController.h
//  Spoty
//
//  Created by Caroline on 16/02/2017.
//  Copyright © 2017 esgi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController{
    NSMutableDictionary *playlists_;
}

@property (strong, nonatomic) NSMutableDictionary *playlists;

-(void)receivePlaylists:(NSMutableDictionary*)data;

@end
