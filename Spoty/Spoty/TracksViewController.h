//
//  TracksViewController.h
//  Spoty
//
//  Created by Caroline on 19/02/2017.
//  Copyright © 2017 esgi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface TracksViewController : UIViewController {
    HomeViewController *parent_;
}

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (nonatomic, strong) HomeViewController *parent;

- (instancetype)initWithParent:(HomeViewController*)parent;

@end
