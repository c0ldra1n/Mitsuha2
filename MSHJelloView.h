//
//  MSHJelloView.h
//  Mitsuha
//
//  Created by c0ldra1n on 2/5/17.
//  Copyright © 2017 c0ldra1n. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSHJelloViewConfig : NSObject

@property BOOL enabled;

@property BOOL enableDisplayLink;
@property BOOL enableDynamicGain;
@property double gain;
@property double limiter;

@property (nonatomic, retain) UIColor *waveColor;
@property (nonatomic, retain) UIColor *subwaveColor;

@property NSUInteger numberOfPoints;

@property CGFloat waveOffset;

@property BOOL ignoreColorFlow;

@property BOOL enableCircleArtwork;

-(instancetype)initWithDictionary:(NSDictionary *)dict;

+(MSHJelloViewConfig *)loadConfigForApplication:(NSString *)name;

@end

@interface MSHJelloLayer : CAShapeLayer

@property BOOL shouldAnimate;

@end

@interface MSHJelloView : UIView{
    NSUInteger cachedLength;
}

@property (nonatomic, strong) MSHJelloViewConfig *config;

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGPoint *points;

@property (nonatomic, strong) MSHJelloLayer *waveLayer;
@property (nonatomic, strong) MSHJelloLayer *subwaveLayer;

-(void)updateWaveColor:(UIColor *)waveColor subwaveColor:(UIColor *)subwaveColor;

-(void)initializeWaveLayers;
-(void)resetWaveLayers;
-(void)redraw;

-(CGPathRef)createPathWithPoints:(CGPoint *)points pointCount:(NSUInteger)pointCount inRect:(CGRect)rect;

-(void)updateBuffer:(float *)bufferData withLength:(int)length;

-(void)setSampleData:(float *)data length:(int)length;

-(instancetype)initWithFrame:(CGRect)frame andConfig:(MSHJelloViewConfig *)config;

@end
