//
//  TracksViewController.h
//  Spoty
//
//  Created by Caroline on 19/02/2017.
//  Copyright © 2017 esgi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface TracksViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    HomeViewController *parent_;
    NSDictionary *tracksData_;
}

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (nonatomic, strong) HomeViewController *parent;
@property (nonatomic, strong) NSDictionary *tracksData;

- (instancetype)initWithParent:(HomeViewController*)parent andPlaylist:(NSString*)href;
- (void) receiveData:(NSDictionary*)tracksData;

@end
