//
//  YPLaunchMovieController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/24.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPLaunchMovieController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "Masonry.h"

#define ScreenWidth  (int)[[UIScreen mainScreen] bounds].size.width
#define ScreenHeight (int )[[UIScreen mainScreen] bounds].size.height
#define ISIPHONE_S   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREEN_MAX_LENGTH_S (MAX(ScreenWidth, ScreenHeight))
#define ISIPHONE_X_S  (ISIPHONE_S && SCREEN_MAX_LENGTH_S == 812.0f)
#define STATUSBAR_HEIGHT_S  (ISIPHONE_X_S ? (50) : 20 )

@interface YPLaunchMovieController ()<AVPlayerViewControllerDelegate>

@property (nonatomic, strong) AVPlayerLayer *avPlayer;

@end

@implementation YPLaunchMovieController

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupMovieView];
}

- (void)setupMovieView{
    
    UIButton *intoHomeBtn = [[UIButton alloc]initWithFrame:CGRectMake(36, ScreenHeight*0.5+150+50, ScreenWidth-72, 56)];
    [intoHomeBtn setImage:[UIImage imageNamed:@"intoHomeBtn"] forState:UIControlStateNormal];
    [intoHomeBtn setImage:[UIImage imageNamed:@"intoHomeBtn"] forState:UIControlStateHighlighted];
    [intoHomeBtn addTarget:self action:@selector(intoHomeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:intoHomeBtn];
    
    //播放单位
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:self.movieURL];
    
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    
    //player
    self.avPlayer = [AVPlayerLayer playerLayerWithPlayer:player];
    self.avPlayer.frame = CGRectMake(0, ScreenHeight*0.5-150, ScreenWidth, 300);
    //layer 填充方式
    self.avPlayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    self.avPlayer.player = player;
    [self.view.layer addSublayer:self.avPlayer];
    
    //19-01-29 解决真机测试时没有声音的问题
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord
             withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker
                   error:nil];
    
    //开始播放
    [self.avPlayer.player play];
    
    //重复播放
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:nil];
    
}

#pragma mark - target
//播放完成代理
- (void)playDidEnd:(NSNotification *)notif{
    //播放完成后,设置播放进度为0 重新播放
    [self.avPlayer.player seekToTime:CMTimeMake(0, 1)];
    [self.avPlayer.player play];
}

- (void)intoHomeBtn{
    [UIApplication sharedApplication].keyWindow.rootViewController = self.VC;
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
