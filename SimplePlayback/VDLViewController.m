/* Copyright (c) 2013, Felix Paul Kühne and VideoLAN
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without 
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, 
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE. */

#import "VDLViewController.h"

@interface VDLViewController ()
{
    VLCMediaPlayer *_mediaplayerTop;
    VLCMediaPlayer *_mediaplayerBottom;
}

@end

@implementation VDLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    /* setup the media player instance, give it a delegate and something to draw into */
    _mediaplayerTop = [[VLCMediaPlayer alloc] initWithOptions:@[@"--ipv4-timeout=10000",
                                                               @"--verbose=1",
                                                               @"--stats",
                                                               @"--rtsp-tcp"]];
    _mediaplayerTop.delegate = self;
    _mediaplayerTop.drawable = self.movieViewTop;
    
    self.movieViewTop.layer.borderColor = [UIColor redColor].CGColor;
    self.movieViewTop.layer.borderWidth = 1.0f;

    /* create a media object and give it to the player */
    _mediaplayerTop.media = [VLCMedia mediaWithURL:[NSURL URLWithString:@"rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov"]];
    
    /* setup the media player instance, give it a delegate and something to draw into */
   _mediaplayerBottom = [[VLCMediaPlayer alloc] initWithOptions:@[@"--ipv4-timeout=10000",
                                                                 @"--verbose=1",
                                                                 @"--stats",
                                                                 @"--rtsp-tcp"]];
    _mediaplayerBottom.delegate = self;
    _mediaplayerBottom.drawable = self.movieViewBottom;
    
    self.movieViewBottom.layer.borderColor = [UIColor redColor].CGColor;
    self.movieViewBottom.layer.borderWidth = 1.0f;
    
    /* create a media object and give it to the player */
    _mediaplayerBottom.media = [VLCMedia mediaWithURL:[NSURL URLWithString:@"rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov"]];
}

- (IBAction)playandPause:(id)sender
{
    [self performSelectorInBackground:@selector(startVideos) withObject:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startVideos {
    
    if (_mediaplayerTop.isPlaying)
        [_mediaplayerTop pause];
    
    [_mediaplayerTop play];
    [NSThread sleepForTimeInterval:10];
    if (_mediaplayerBottom.isPlaying)
        [_mediaplayerBottom pause];
    
    [_mediaplayerBottom play];
    
}

@end
