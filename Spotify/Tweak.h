//
//  Tweak.h
//  Mitsuha
//
//  Created by c0ldra1n on 2/17/17.
//  Copyright © 2017 c0ldra1n. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>
#import <AudioUnit/AudioUnit.h>

#import <substrate.h>
#import "../MSHUtils.h"
#import "../MSHJelloView.h"

@interface SPTImageBlurView : UIView

@property(retain, nonatomic) UIView *tintView; // @synthesize tintView=_tintView;

- (void)updateBlurredImageIfNeeded;
- (void)updateBlurIntensity;

-(void)applyCustomLayout;
-(void)updateGradientDark:(BOOL)darkbackground;

@end

@interface SPTCarouselBlurBackgroundView : UIView

@property(retain, nonatomic) SPTImageBlurView *backgroundImageBlurView; // @synthesize backgroundImageBlurView=_backgroundImageBlurView;

@end

@interface SPTNowPlayingBackgroundMusicViewController : UIViewController

@property(retain, nonatomic) SPTCarouselBlurBackgroundView *backgroundView; // @synthesize backgroundView=_backgroundView;

@property (nonatomic, retain) MSHJelloView *mitsuhaJelloView;

-(void)applyCustomLayout;

@end


@interface SPTNowPlayingCoverArtViewCell : UIView

@property(nonatomic) CGSize cellSize; // @synthesize cellSize=_cellSize;
@property(retain, nonatomic) UIView *contentView; // @synthesize contentView=_contentView;

@end


@interface SPTNowPlayingCoverArtView : UIView

@end


@interface SPTNowPlayingCarouselContentUnitView : UIView

@property(retain, nonatomic) SPTNowPlayingCoverArtView *coverArtView; // @synthesize coverArtView=_coverArtView;

@end

@interface SPTNowPlayingCarouselAreaViewController : UIViewController

@property(retain, nonatomic) SPTNowPlayingCarouselContentUnitView *view; // @dynamic view;

@end

@interface SPTPlayerImpl : NSObject

- (id)skipToNextTrackWithOptions:(id)arg1 track:(id)arg2;
- (id)skipToPreviousTrackWithOptions:(id)arg1 track:(id)arg2;
- (id)skipToNextTrackWithOptions:(id)arg1;
- (id)skipToPreviousTrackWithOptions:(id)arg1;

@end

@interface SpotifyAppDelegate : NSObject <UIApplicationDelegate>

@end


@interface SPTNowPlayingModel : NSObject
- (void)player:(id)arg1 stateDidChange:(id)arg2 fromState:(id)arg3;
- (void)updateWithPlayerState:(id)arg1;

-(void)applyColorChange;

@end

@interface CFWColorInfo : NSObject


+ (id)colorInfoWithAnalyzedInfo:(struct AnalyzedInfo)arg1;
@property(nonatomic, getter=isBackgroundDark) _Bool backgroundDark; // @synthesize backgroundDark=_backgroundDark;
@property(retain, nonatomic) UIColor *secondaryColor; // @synthesize secondaryColor=_secondaryColor;
@property(retain, nonatomic) UIColor *primaryColor; // @synthesize primaryColor=_primaryColor;
@property(retain, nonatomic) UIColor *backgroundColor; // @synthesize backgroundColor=_backgroundColor;
- (void)dealloc;
- (id)description;
- (_Bool)isEqual:(id)arg1;
- (id)initWithAnalyzedInfo:(struct AnalyzedInfo)arg1;

@end


@interface CFWSpotifyStateManager : NSObject

+ (id)sharedManager;

@property(readonly, retain, nonatomic) CFWColorInfo *barColorInfo; // @synthesize barColorInfo=_barColorInfo;
@property(readonly, retain, nonatomic) NSString *barIdentifier; // @synthesize barIdentifier=_barIdentifier;
@property(readonly, retain, nonatomic) CFWColorInfo *mainColorInfo; // @synthesize mainColorInfo=_mainColorInfo;
@property(readonly, retain, nonatomic) NSString *mainIdentifier; // @synthesize mainIdentifier=_mainIdentifier;
- (void)analysisCompletedForIdentifier:(id)arg1 colorInfo:(id)arg2;
- (void)mainIdentifierPossiblyChanged:(id)arg1 colorInfo:(id)arg2;
- (void)barIdentifierPossiblyChanged:(id)arg1 colorInfo:(id)arg2;
- (void)dealloc;

@end