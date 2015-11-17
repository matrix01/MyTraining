//
//  VideoPlayVC.m
//  AVFoundationCheck
//
//  Created by Md. Milan Mia on 11/17/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#import "VideoPlayVC.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>

#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CMTime.h>
#import <CoreMedia/CMTimeRange.h>
#import <CoreMedia/CMSync.h>
#import <Foundation/Foundation.h>

@class AVPlayer;
@interface VideoPlayVC (){
    AVPlayer *avPlayer;
}

@end

@implementation VideoPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)videoPlay:(id)sender {
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}
#pragma mark - UIImagePickerDelegate
-(BOOL)startMediaBrowserFromViewController:(UIViewController*)controller usingDelegate:(id )delegate {
    // 1 - Validations
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        || (delegate == nil)
        || (controller == nil)) {
        return NO;
    }
    // 2 - Get image picker
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    mediaUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, kUTTypeImage, nil];
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = YES;
    mediaUI.delegate = delegate;
    // 3 - Display image picker
    [controller presentViewController:mediaUI animated:YES completion:nil];
    //[controller presentModalViewController:mediaUI animated:YES];
    return YES;
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // 1 - Get media type
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    // 2 - Dismiss image picker
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    //[self dismissModalViewControllerAnimated:NO];
    // Handle a movie capture
    /*if (CFStringCompare ((__bridge_retained CFStringRef)mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        // 3 - Play the video
        MPMoviePlayerViewController *theMovie = [[MPMoviePlayerViewController alloc]
                                                 initWithContentURL:[info objectForKey:UIImagePickerControllerMediaURL]];
        [self presentMoviePlayerViewControllerAnimated:theMovie];
        // 4 - Register for the playback finished notification
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myMovieFinishedCallback:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
    }*/
    avPlayer = [AVPlayer playerWithURL:[info objectForKey:UIImagePickerControllerMediaURL]];
    
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
    avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    layer.frame = CGRectMake(0, 0, 1024, 768);
    
    
    AVPlayerViewController *theMovie = (AVPlayerViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"avPlayerVC"];
    [self presentViewController:theMovie animated:YES completion:nil];
    [self.view.layer addSublayer: layer];
    [avPlayer play];
}
-(void)myMovieFinishedCallback:(NSNotification*)aNotification {
    [self dismissMoviePlayerViewControllerAnimated];
    MPMoviePlayerController* theMovie = [aNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
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
