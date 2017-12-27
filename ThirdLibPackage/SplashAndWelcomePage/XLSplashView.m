//
//  XLSplashView.m
//  test
//
//  Created by mgfjx on 2017/12/8.
//  Copyright © 2017年 mgfjx. All rights reserved.
//

#import "XLSplashView.h"

#define LinkIdentifier @"LinkIdentifier"

@interface XLSplashView ()

@property (nonatomic, strong) UIImageView *imageView ;
@property (nonatomic, strong) UIButton *skipButton ;
@property (nonatomic, strong) dispatch_source_t timer ;

@property (nonatomic, copy) TapCallback tapCallback ;

@property (nonatomic, strong) NSString *filePath ;

@property (nonatomic, strong) UIWindow *window ;

@end

@implementation XLSplashView

static XLSplashView *singleton = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    if (!singleton) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            singleton = [super allocWithZone:zone];
            
        });
    }
    return singleton;
}

- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [super init];
        [self initViews];
    });
    return singleton;
}

- (id)copyWithZone:(NSZone *)zone{
    return singleton;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    return singleton;
}

+ (instancetype)shareInstance {
    return [[self alloc] init];
}

- (void)initViews {
    
    _countNumber = 5;
    
    self.frame = [UIScreen mainScreen].bounds;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:imageView];
    _imageView = imageView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tap];
    
    CGFloat width = self.bounds.size.width ;
    
    CGFloat buttonSize = 0.11*width;
    CGFloat fontSize = 0.034*width;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(width - buttonSize - 20, 20, buttonSize, buttonSize);
    button.layer.cornerRadius = button.size.width / 2;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(skip:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    button.backgroundColor = [UIColor grayColor];
    
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    [self addSubview:button];
    _skipButton = button;
    
    [self listenAppEvents];
}

- (void)listenAppEvents {
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(start) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)skip:(UIButton *)sender {
    
    [self removeSelf];
    
}

- (void)showOnWindow:(UIWindow *)window countDownCompleted:(TapCallback)callback {
    
    if (callback ) {
        self.tapCallback = callback;
    }
    
    _window = window;
    
    [self start];
}

- (void)start {
    
    UIImage *image = [UIImage imageWithContentsOfFile:self.filePath];
    
    if (!image) {
        return;
    }else{
        _window.windowLevel = UIWindowLevelStatusBar;
        [_window addSubview:self];
        self.imageView.image = image;
    }
    
    __block NSInteger time = _countNumber;
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    _timer = timer;
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        NSString *title = [NSString stringWithFormat:@"跳过\n%lds", time];
        [_skipButton setTitle:title forState:UIControlStateNormal];
        if (time == 0) {
            [self removeSelf];
            dispatch_source_cancel(timer);
        }
        time--;
    });
    dispatch_resume(timer);
}

- (void)removeSelf {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(finishedAnimated)];
    self.alpha = 0.0;
    self.transform = CGAffineTransformScale(self.transform, 1.2, 1.2);
    [UIView commitAnimations];
}

- (void)finishedAnimated {
    _window.windowLevel = UIWindowLevelNormal;
    [self removeFromSuperview];
    self.alpha = 1.0;
    self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

- (void)tapImage:(UITapGestureRecognizer *)tap {
    if (self.tapCallback) {
        NSString *link = [[NSUserDefaults standardUserDefaults] objectForKey:LinkIdentifier];
        self.tapCallback(link);
    }
    [self removeSelf];
}

- (void)setImgUrl:(NSString *)imgUrl {
    _imgUrl = imgUrl;
    [self downloadImageAndSave];
}

- (NSString *)filePath {
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [document stringByAppendingPathComponent:@"XLSplashView.jpg"];
    
    return filePath;
}

- (void)downloadImageAndSave {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:[NSURL URLWithString:_imgUrl] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *data = [NSData dataWithContentsOfURL:location];
        if (data) {
            [[NSFileManager defaultManager] createFileAtPath:self.filePath contents:data attributes:nil];
            [[NSUserDefaults standardUserDefaults] setObject:_link forKey:LinkIdentifier];
        }
    }];
    [task resume];
}

- (void)setLink:(NSString *)link {
    _link = link;
}

@end

