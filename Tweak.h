//
//  Tweak.h
//  Mitsuha2
//
//  Created by c0ldra1n on 12/10/17.
//  Copyright © 2017 c0ldra1n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "MSHJelloView.h"

@interface MPQueuePlayer : NSObject

@property (nonatomic, readonly) AVPlayer *_player;
@property (nonatomic,readonly) AVPlayerItem * currentItem;

- (AVPlayerItem *)currentItem;

@end

@interface MPAVController : NSObject

@property (nonatomic, readonly) MPQueuePlayer *avPlayer;

@property (assign,nonatomic) float volume;

-(void)togglePlayback;

-(void)play;
-(void)pause;
-(BOOL)isPlaying;

-(void)notifyAVPlayerItemWillChange:(id)arg1;
-(void)notifyAVPlayerItemDidChange:(id)arg1;

-(void)_itemWillChange:(id)arg1 ;
-(void)_itemDidChange:(id)arg1 ;

-(void)_tracksDidChange:(id)arg1 ;

-(void)configureMitsuhaFilter;

@end

@interface MusicNowPlayingControlsViewController : UIViewController

@property (retain,nonatomic) UILabel * titleLabel;
@property (retain,nonatomic) MSHJelloView *mitsuhaJelloView;
@property (retain,nonatomic) CADisplayLink *displayLink;
@end
