//
//  MSHUtils.h
//  Mitsuha
//
//  Created by c0ldra1n on 2/6/17.
//  Copyright © 2017 c0ldra1n. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "xctheos.h"

#define MSHColorFlowInstalled [GET_CLASS(CFWPrefsManager) class]

#define MSHColorFlowMusicEnabled MSHookIvar<BOOL>([GET_CLASS(CFWPrefsManager) sharedInstance], "_musicEnabled")

#define MSHColorFlowSpotifyEnabled MSHookIvar<BOOL>([GET_CLASS(CFWPrefsManager) sharedInstance], "_spotifyEnabled")

#define MSHCustomCoverInstalled [GET_CLASS(CustomCoverAPI) class]

#define MSHPreferencesDirectory @"/var/mobile/Library/Preferences/io.c0ldra1n.mitsuha-prefs.plist"

#define MSHDatastreamPath @"/Library/Application\ Support/Mitsuha/io.c0ldra1n.mitsuha.datastream"
