//
//  MSHJelloView.xmi
//  Mitsuha
//
//  Created by c0ldra1n on 2/5/17.
//  Copyright © 2017 c0ldra1n. All rights reserved.
//

#import "MSHJelloView.h"
#import "MSHUtils.h"
#import <substrate.h>

static CGPoint midPointForPoints(CGPoint p1, CGPoint p2) {
    return CGPointMake((p1.x + p2.x) / 2, (p1.y + p2.y) / 2);
}

static CGPoint controlPointForPoints(CGPoint p1, CGPoint p2) {
    CGPoint controlPoint = midPointForPoints(p1, p2);
    CGFloat diffY = fabs(p2.y - controlPoint.y);
    
    if (p1.y < p2.y)
        controlPoint.y += diffY;
    else if (p1.y > p2.y)
        controlPoint.y -= diffY;
    
    return controlPoint;
}

@implementation MSHJelloViewConfig

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    
    if (self) {
        _enabled = [([dict objectForKey:@"enabled"] ?: @(YES)) boolValue];
        _enableDisplayLink = [([dict objectForKey:@"enableDisplayLink"] ?: @(YES)) boolValue];
        _enableDynamicGain = [([dict objectForKey:@"enableDynamicGain"] ?: @(NO)) boolValue];
        _ignoreColorFlow = [([dict objectForKey:@"ignoreColorFlow"] ?: @(NO)) boolValue];
        _enableCircleArtwork = [([dict objectForKey:@"enableCircleArtwork"] ?: @(NO)) boolValue];
        
        UIColor * (*LCPParseColorString)(NSString *, NSString *) = (UIColor * (*)(NSString *, NSString *))dlsym(RTLD_DEFAULT, "LCPParseColorString");
        
        NSLog(@"[Mitsuha]: Reading Preferences...:%@", dict);
        
        if([dict objectForKey:@"waveColor"]){
            if([[dict objectForKey:@"waveColor"] isKindOfClass:[UIColor class]]){
                _waveColor = [dict objectForKey:@"waveColor"];
            }else if([[dict objectForKey:@"waveColor"] isKindOfClass:[NSString class]]){
                _waveColor = LCPParseColorString([dict objectForKey:@"waveColor"], @"#000000:0.5");
            }
        }else{
            _waveColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        }
        
        if([dict objectForKey:@"subwaveColor"]){
            if([[dict objectForKey:@"subwaveColor"] isKindOfClass:[UIColor class]]){
                _subwaveColor = [dict objectForKey:@"subwaveColor"];
            }else if([[dict objectForKey:@"subwaveColor"] isKindOfClass:[NSString class]]){
                _subwaveColor = LCPParseColorString([dict objectForKey:@"subwaveColor"], @"#000000:0.5");
            }
        }else{
            _subwaveColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        }
        
        _gain = [([dict objectForKey:@"gain"] ?: @(100)) doubleValue];
        _limiter = [([dict objectForKey:@"limiter"] ?: @(0)) doubleValue];
        _numberOfPoints = [([dict objectForKey:@"numberOfPoints"] ?: @(8)) unsignedIntegerValue];
        _waveOffset = [([dict objectForKey:@"waveOffset"] ?: @(0)) doubleValue];
        _waveOffset = ([([dict objectForKey:@"negateOffset"] ?: @(false)) boolValue] ? _waveOffset * -1 : _waveOffset);
    }
    
    return self;
}

+(MSHJelloViewConfig *)loadConfigForApplication:(NSString *)name{
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:MSHPreferencesDirectory];
    
    if(!prefs){
        prefs = [@{} mutableCopy];
    }
    
    for (NSString *key in [prefs allKeys]) {
        NSString *removedKey = [key stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"MSH%@", name] withString:@""];
        NSString *loweredFirstChar = [[removedKey substringWithRange:NSMakeRange(0, 1)] lowercaseString];
        NSString *newKey = [removedKey stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:loweredFirstChar];

        [prefs setValue:[prefs objectForKey:key] forKey:newKey];
    }
    
    if ([name isEqualToString:@"Music"]) {
        prefs[@"waveColor"] = [prefs objectForKey:@"waveColor"] ?: [UIColor colorWithRed:0.99 green:0.19 blue:0.35 alpha:0.1];
        prefs[@"subwaveColor"] = [prefs objectForKey:@"subwaveColor"] ?: [UIColor colorWithRed:0.99 green:0.19 blue:0.35 alpha:0.1];
        
        if ([(prefs[@"useDefaultColors"] ?: @(NO)) boolValue]) {
            prefs[@"waveColor"] = [UIColor colorWithRed:0.99 green:0.19 blue:0.35 alpha:0.1];
            prefs[@"subwaveColor"] = [UIColor colorWithRed:0.99 green:0.19 blue:0.35 alpha:0.1];
        }
        
        prefs[@"waveOffset"] = ([prefs objectForKey:@"waveOffset"] ?: @(0));
    }
    
    if([name isEqualToString:@"Spotify"]){
        prefs[@"waveColor"] = [prefs objectForKey:@"waveColor"] ?: [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:0.2];
        prefs[@"subwaveColor"] = [prefs objectForKey:@"subwaveColor"] ?: [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:0.2];
        
        if ([(prefs[@"useDefaultColors"] ?: @(NO)) boolValue]) {
            prefs[@"waveColor"] = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:0.2];
            prefs[@"subwaveColor"] = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:0.2];
        }
        
        prefs[@"waveOffset"] = ([prefs objectForKey:@"waveOffset"] ?: @(0));
    }
    
    return [[MSHJelloViewConfig alloc] initWithDictionary:prefs];
}

@end

@implementation MSHJelloLayer

- (id<CAAction>)actionForKey:(NSString *)event {
    if(self.shouldAnimate){
        if ([event isEqualToString:@"path"]) {
            
            CABasicAnimation *animation = [CABasicAnimation
                                           animationWithKeyPath:event];
            animation.duration = 0.15f;
            
            return animation;
        }
    }
    return [super actionForKey:event];
}

@end

@implementation MSHJelloView

-(instancetype)initWithFrame:(CGRect)frame andConfig:(MSHJelloViewConfig *)config{
    self = [super initWithFrame:frame];
    if (self) {
        self.config = config;
        [self initializeWaveLayers];
    }
    return self;
}

-(void)initializeWaveLayers{
    self.waveLayer = [MSHJelloLayer layer];
    self.subwaveLayer = [MSHJelloLayer layer];
    
    self.waveLayer.frame = self.subwaveLayer.frame = self.bounds;
    
    [self updateWaveColor:self.config.waveColor subwaveColor:self.config.subwaveColor];
    
    [self.layer addSublayer:self.waveLayer];
    [self.layer addSublayer:self.subwaveLayer];
    
    self.waveLayer.zPosition = 0;
    self.subwaveLayer.zPosition = -1;
    
    if(self.config.enableDisplayLink){
        [self configureDisplayLink];
    }
    
    [self resetWaveLayers];
}

-(void)resetWaveLayers{
    if (!self.waveLayer || !self.subwaveLayer) {
        [self initializeWaveLayers];
    }
    
    CGPathRef path = [self createPathWithPoints:self.points
                                     pointCount:0
                                         inRect:self.bounds];
    
    NSLog(@"[Mitsuha]: Resetting Wave Layers...");
    
    self.waveLayer.path = path;
    self.subwaveLayer.path = path;
}

-(void)configureDisplayLink{
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(redraw)];
    
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [self.displayLink setPaused:false];
    
    self.waveLayer.shouldAnimate = true;
    self.subwaveLayer.shouldAnimate = true;
}

-(void)updateWaveColor:(UIColor *)waveColor subwaveColor:(UIColor *)subwaveColor{
    self.waveLayer.fillColor = waveColor.CGColor;
    self.subwaveLayer.fillColor = subwaveColor.CGColor;
}

- (void)redraw{
    CGPathRef path = [self createPathWithPoints:self.points
                                     pointCount:self.config.numberOfPoints
                                         inRect:self.bounds];
    self.waveLayer.path = path;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.subwaveLayer.path = path;
        CGPathRelease(path);
    });
}


- (CGPathRef)createPathWithPoints:(CGPoint *)points
                       pointCount:(NSUInteger)pointCount
                           inRect:(CGRect)rect {
    UIBezierPath *path;
    
    if (pointCount > 0){
        path = [UIBezierPath bezierPath];
        
        [path moveToPoint:CGPointMake(0, self.frame.size.height)];
        
        CGPoint p1 = self.points[0];
        
        [path addLineToPoint:p1];
        
        for (int i = 0; i<self.config.numberOfPoints; i++) {
            CGPoint p2 = self.points[i];
            CGPoint midPoint = midPointForPoints(p1, p2);
            
            [path addQuadCurveToPoint:midPoint controlPoint:controlPointForPoints(midPoint, p1)];
            [path addQuadCurveToPoint:p2 controlPoint:controlPointForPoints(midPoint, p2)];
            
            p1 = self.points[i];
        }
        
        [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
        [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
    }else{
        float pixelFixer = self.bounds.size.width/self.config.numberOfPoints;
        
        if(cachedLength != self.config.numberOfPoints){
            self.points = (CGPoint *)malloc(sizeof(CGPoint) * self.config.numberOfPoints);
            cachedLength = self.config.numberOfPoints;
            
            for (int i = 0; i < self.config.numberOfPoints; i++){
                self.points[i].x = i*pixelFixer;
                self.points[i].y = self.config.waveOffset; //self.bounds.size.height/2;
            }
            
            self.points[self.config.numberOfPoints - 1].x = self.bounds.size.width;
            self.points[0].y = self.points[self.config.numberOfPoints - 1].y = self.config.waveOffset; //self.bounds.size.height/2;
        }
        
        return [self createPathWithPoints:self.points
                               pointCount:self.config.numberOfPoints
                                   inRect:self.bounds];
    }
    
    CGPathRef convertedPath = path.CGPath;
    
    return CGPathCreateCopy(convertedPath);
}

-(void)updateBuffer:(float *)bufferData withLength:(int)length{
    [self setSampleData:bufferData length:length];
}

- (void)setSampleData:(float *)data length:(int)length{
    NSUInteger compressionRate = length/self.config.numberOfPoints;
    
    float pixelFixer = self.bounds.size.width/self.config.numberOfPoints;
    
    if(cachedLength != self.config.numberOfPoints){
        self.points = (CGPoint *)malloc(sizeof(CGPoint) * self.config.numberOfPoints);
        cachedLength = self.config.numberOfPoints;
    }

#ifdef Sigma
    
    for (int i = 0; i<length; i++) {
        self.points[(int)(i/8)].y += data[i];
    }
    
#else
    
    for (int i = 0; i < self.config.numberOfPoints; i++){
        self.points[i].x = i*pixelFixer;
        double pureValue = data[i*compressionRate] * self.config.gain;
        
        if(self.config.limiter != 0){
            pureValue = (fabs(pureValue) < self.config.limiter ? pureValue : (pureValue < 0 ? -1*self.config.limiter : self.config.limiter));
        }
        
        self.points[i].y = pureValue + self.config.waveOffset;// + self.bounds.size.height/2;
    }
    
#endif
    
    self.points[self.config.numberOfPoints - 1].x = self.bounds.size.width;
    self.points[0].y = self.points[self.config.numberOfPoints - 1].y = self.config.waveOffset; //self.bounds.size.height/2;
    
    if(!self.config.enableDisplayLink){
        //  Do the animation here
        [self redraw];
    }
}

@end