//
//  HomeViewController.h
//  Spoty
//
//  Created by Caroline on 16/02/2017.
//  Copyright © 2017 esgi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionService.h"

@interface HomeViewController : UIViewController{
    ConnectionService *coService_;
}

@property (strong, nonatomic) ConnectionService *coService;

-(instancetype)initWithService:(ConnectionService*)service;

@end
