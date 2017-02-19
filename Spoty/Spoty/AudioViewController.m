//
//  AudioViewController.m
//  Spoty
//
//  Created by Caroline on 19/02/2017.
//  Copyright © 2017 esgi. All rights reserved.
//

#import "AudioViewController.h"

@interface AudioViewController ()

@end

@implementation AudioViewController

@synthesize audioPlayer = audioPlayer_;
@synthesize soundPath = soundPath_;

-(instancetype)initWithSound:(NSString*)sound {
    self = [super init];
    self.soundPath = sound;
    return self;
}
- (IBAction)touchReturn:(id)sender {
    [self.view removeFromSuperview];
}

- (IBAction)touchPlay:(id)sender {
    NSLog(@"On demande à écouter");
    [self.audioPlayer play];
}
- (IBAction)touchStop:(id)sender {
    NSLog(@"On demande le silence");
    [self.audioPlayer stop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Construct URL to sound file
    //NSString *path = [NSString stringWithFormat:@"%@/drum01.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:self.soundPath];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
