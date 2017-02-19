//
//  AudioViewController.h
//  Spoty
//
//  Created by Caroline on 19/02/2017.
//  Copyright © 2017 esgi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioViewController : UIViewController {
    AVAudioPlayer *audioPlayer_;
    NSString *soundPath_;
}

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) NSString *soundPath;

-(instancetype)initWithSound:(NSString*)sound;

@end
