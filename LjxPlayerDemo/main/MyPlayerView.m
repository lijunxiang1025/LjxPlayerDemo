//
//  MyPlayerView.m
//  LjxPlayerDemo
//
//  Created by lijunxiang on 16/1/3.
//  Copyright © 2016年 LjxProduct. All rights reserved.
//

#import "MyPlayerView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MyPlayerView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
     
        _isPlay = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.frame = frame;
        _number=0.0015;
        [self createView];
        //[self createAnimation];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(stopTime) name:@"playTimeStop" object:nil];
    }
    return self;
}
- (void)createView{
    
    _imageView = [LjxUi createImageView:CGRectMake(0, 0, ScreenWidth, ScreenWidth) andName:@"ljx"];
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.cornerRadius = ScreenWidth/2;
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeStart)];
    
    [_imageView addGestureRecognizer:ges];
    [self addSubview:_imageView];
//    
//    NSInvocation * invo = [NSInvocation invocationWithMethodSignature:[[self class] instanceMethodSignatureForSelector:@selector(init)]];
//    [invo setSelector:@selector(xz)];

    //[invo setTarget:self];
    self.time = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(xz) userInfo:nil repeats:YES];
    //[NSTimer timerWithTimeInterval:0.1 invocation:invo repeats:YES];
    //[[NSRunLoop mainRunLoop]addTimer:_time forMode:NSDefaultRunLoopMode];
    [self.time fire];
}

- (void)xz{
    
    if (_number ==1) {
        _number = 0.0015;
    }
    [self.imageView setTransform:CGAffineTransformMakeRotation(M_PI*_number)];
    _number+=0.0015;
}
- (void)stopTime{
    
    [self.time invalidate];
    self.time = nil;
    
}
- (void)changeStart{
    
    if (_isPlay) {
        [self.time invalidate];
        self.time = nil;
        self.stopBlcok();
        _isPlay= NO;
    }else{
        self.time = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(xz) userInfo:nil repeats:YES];
        self.startBlcok();
        _isPlay= YES;

    }
    
}
/*****
-(void)drawRect:(CGRect)rect{
    UIColor * color = [UIColor blueColor];
    [color set];
    self.path  = [UIBezierPath  bezierPathWithRoundedRect:CGRectMake(30, 30, WIDTH-60, WIDTH-60) cornerRadius:(WIDTH-60)/2];
    self.path.lineWidth = 1;
    [self.path stroke];
}
- (void)createAnimation{
    
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];

    CGMutablePathRef thePath = CGPathCreateMutableCopy(self.path.CGPath);

//    CGPathAddEllipseInRect(thePath, nil, CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, CGFloat height))
    CGPathMoveToPoint(thePath, NULL, WIDTH/2, 30);
    bounceAnimation.duration = 2;
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-15, 15, 30, 30)];
    imageV.layer.masksToBounds = YES;
    imageV.layer.cornerRadius = 15;
     UIImage * image1 = [UIImage imageNamed:@"sy.jpg"];
    
    
    CAKeyframeAnimation *imageAnimation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];

    imageAnimation.duration = 1.0;
    imageAnimation.repeatCount = HUGE_VALF;
    imageAnimation.calculationMode = kCAAnimationDiscrete;

    imageAnimation.values = [NSArray arrayWithObjects:
                              (id)image1.CGImage,
                              (id)image1.CGImage,
                              nil];
    [self.layer addAnimation:bounceAnimation forKey:@"position"];
    
}
 ******/
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
