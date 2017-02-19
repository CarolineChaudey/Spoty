//
//  SearchViewController.h
//  Spoty
//
//  Created by Caroline on 16/02/2017.
//  Copyright © 2017 esgi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSMutableDictionary *searchresults_;
}

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;


@property (strong, nonatomic) NSMutableDictionary *searchresults;

-(void)fetchingResults:(NSMutableDictionary*)data;

@end
