//
//  MSHUtils.h
//  Mitsuha
//
//  Created by c0ldra1n on 2/6/17.
//  Copyright © 2017 c0ldra1n. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MSHColorFlowInstalled [%c(CFWPrefsManager) class]
#define MSHColorFlowMusicEnabled MSHookIvar<BOOL>([%c(CFWPrefsManager) sharedInstance], "_musicEnabled")
#define MSHColorFlowSpotifyEnabled MSHookIvar<BOOL>([%c(CFWPrefsManager) sharedInstance], "_spotifyEnabled")
#define MSHCustomCoverInstalled [%c(CustomCoverAPI) class]
#define MSHPreferencesDirectory @"/var/mobile/Library/Preferences/io.c0ldra1n.mitsuha-prefs.plist"
#define MSHDatastreamPath @"/Library/Application\ Support/Mitsuha/io.c0ldra1n.mitsuha.datastream"
