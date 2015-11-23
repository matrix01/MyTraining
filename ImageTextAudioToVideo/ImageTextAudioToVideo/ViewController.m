//
//  ViewController.m
//  ImageTextAudioToVideo
//
//  Created by Md. Milan Mia on 11/19/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//
@import AVFoundation;
@import Foundation;
@import AssetsLibrary;

#import "ViewController.h"

@interface ViewController () {
    AVAsset *anAsset;
    NSMutableArray *imageArray;
    NSURL *assetUrl;
    CMTime frameTime;
    AVAssetWriter *assetWriter;
    AVAssetWriterInput *assetWriterInput;
    AVAssetWriterInputPixelBufferAdaptor *adaptor;
    NSDictionary *settings;
    NSString *subtitle;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    subtitle = @"This is a test. This is another test....";
}
//- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
//    UIGraphicsBeginImageContext(size);
//    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return destImage;
//}
-(void) initialization {
    //Initialize the imageArray
    imageArray = [[NSMutableArray alloc]init];
    //CGSize size = self.view.frame.size;
    for(int j=0; j<3; j++){
        for(int i=1; i<83; i++){
            NSString *tempName = [NSString stringWithFormat:@"image%i", i];
            UIImage* image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:tempName ofType:@"png"]];
            //UIImage *convImage = [self imageWithImage:image convertToSize:size];
            [imageArray addObject:image];
        }
    }
    
    //Settings for video
    settings = [self videoSettingsWithCodec:AVVideoCodecH264 withWidth:480 andHeight:640];
    NSError *error;
    
    //Get a temp path to save video
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *tempPath = [documentsDirectory stringByAppendingFormat:@"/temp_01.mov"];
    
    //If already exits a video with same name remove
    if ([[NSFileManager defaultManager] fileExistsAtPath:tempPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:tempPath error:&error];
        if (error) {
            NSLog(@"Error: %@", error.debugDescription);
        }
    }
    //Initialize asset url and assetwriter
    assetUrl = [NSURL fileURLWithPath:tempPath];
    NSLog(@"ASSET URL: %@",assetUrl);
    assetWriter = [[AVAssetWriter alloc]initWithURL:assetUrl fileType:AVFileTypeQuickTimeMovie error:&error];
    if (error) {
        NSLog(@"Error: %@", error.debugDescription);
    }
    //Set permissions
    NSParameterAssert(assetWriter);
    assetWriterInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo
                                                          outputSettings:settings];
    NSParameterAssert(assetWriterInput);
    NSParameterAssert([assetWriter canAddInput:assetWriterInput]);
    [assetWriter addInput:assetWriterInput];
    
    //Set buffer attributes
    NSDictionary *bufferAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithInt:kCVPixelFormatType_32ARGB], kCVPixelBufferPixelFormatTypeKey, nil];
    adaptor = [[AVAssetWriterInputPixelBufferAdaptor alloc] initWithAssetWriterInput:assetWriterInput sourcePixelBufferAttributes:bufferAttributes];
    //Set frameTime
    frameTime = CMTimeMake(1, 4);
}

-(void)createAndSaveVideo {
    [assetWriter startWriting];
    [assetWriter startSessionAtSourceTime:kCMTimeZero];
    dispatch_queue_t mediaInputQueue = dispatch_queue_create("media input Queue", NULL);
    
    NSInteger frameNumber = [imageArray count];
    NSLog(@"Frame Number!! %ld", (long)frameNumber);
    __block NSInteger imageIndex = 0;
    [assetWriterInput requestMediaDataWhenReadyOnQueue:mediaInputQueue usingBlock:^{
        while (true) {
            //NSLog(@"Image Index: %ld", (long)imageIndex);
            if(imageIndex>=frameNumber)break;
            if(assetWriterInput.isReadyForMoreMediaData){
                CVPixelBufferRef buffer = [self newPixelBufferFromCGImage:[[imageArray objectAtIndex:imageIndex] CGImage]];
                if(buffer){
                    if(imageIndex == 0){
                        [adaptor appendPixelBuffer:buffer withPresentationTime:kCMTimeZero];
                    }
                    else{
                        CMTime lastTime = CMTimeMake(imageIndex-1, frameTime.timescale);
                        CMTime presentTime = CMTimeAdd(lastTime, frameTime);
                        [adaptor appendPixelBuffer:buffer withPresentationTime:presentTime];
                    }
                    CFRelease(buffer);
                    imageIndex++;
                    //NSLog(@"Image Index: %ld", (long)imageIndex);
                }
            }
        }
        NSLog(@"Image FInished: %ld", (long)imageIndex);
        [assetWriterInput markAsFinished];
        [assetWriter finishWritingWithCompletionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self addAudioToVideo];
            });
        }];
    }];
    
}
- (CVPixelBufferRef)newPixelBufferFromCGImage:(CGImageRef)image
{
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGImageCompatibilityKey,
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGBitmapContextCompatibilityKey,
                             nil];
    
    CVPixelBufferRef pxbuffer = NULL;
    
    CGFloat frameWidth = [[settings objectForKey:AVVideoWidthKey] floatValue];
    CGFloat frameHeight = [[settings objectForKey:AVVideoHeightKey] floatValue];
    
    
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,
                                          frameWidth,
                                          frameHeight,
                                          kCVPixelFormatType_32ARGB,
                                          (__bridge CFDictionaryRef) options,
                                          &pxbuffer);
    
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    NSParameterAssert(pxdata != NULL);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(pxdata,
                                                 frameWidth,
                                                 frameHeight,
                                                 8,
                                                 4 * frameWidth,
                                                 rgbColorSpace,
                                                 (CGBitmapInfo)kCGImageAlphaNoneSkipFirst);
    NSParameterAssert(context);
    CGContextConcatCTM(context, CGAffineTransformIdentity);
    CGContextDrawImage(context, CGRectMake(0,
                                           0,
                                           CGImageGetWidth(image),
                                           CGImageGetHeight(image)),
                       image);
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    return pxbuffer;
}

- (void)exportDidFinish:(AVAssetExportSession*)session {
    NSLog(@"Session Status: %ld", (long)AVAssetExportSessionStatusCompleted);
    if (session.status == AVAssetExportSessionStatusCompleted) {
        NSURL *outputURL = session.outputURL;
        NSLog(@"%@ Here To Save", outputURL);

        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:outputURL]) {
            [library writeVideoAtPathToSavedPhotosAlbum:outputURL completionBlock:^(NSURL *assetURL, NSError *error){
                NSLog(@"%@ Here To Save", outputURL);
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (error) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Video Saving Failed"
                                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                    } else {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Video Saved" message:@"Saved To Photo Album"
                                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                    }
                });
            }];
        }
    }
    else if(session.status == AVAssetExportSessionStatusFailed){
        NSLog(@"Error: %@", session.error);
    }
}

-(void)addAudioToVideo {
    //////////////  OK now add an audio file to move file  /////////////////////
    
    
    NSString *bundleDirectory = [[NSBundle mainBundle] bundlePath];
    // audio input file...
    NSString *audio_inputFilePath = [bundleDirectory stringByAppendingPathComponent:@"Prapty.mp3"];
    NSURL    *audio_inputFileUrl = [NSURL fileURLWithPath:audio_inputFilePath];
    
//    NSString *sub_inputFilePath = [bundleDirectory stringByAppendingPathComponent:@"edge.srt"];
//    NSURL    *sub_inputFileUrl = [NSURL fileURLWithPath:sub_inputFilePath];
    
    // this is the video file that was just written above, full path to file is in --> videoOutputPath
    NSURL    *video_inputFileUrl = assetUrl;
    
    // create the final video output file as MOV file - may need to be MP4, but this works so far...
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:
                             [NSString stringWithFormat:@"FinalVideo-%d.mov",arc4random() % 1000]];
    NSURL *outputFileUrl = [NSURL fileURLWithPath:myPathDocs];
    
    CMTime nextClipStartTime = kCMTimeZero;
    

    
    //nextClipStartTime = CMTimeAdd(nextClipStartTime, a_timeRange.duration);
    
    AVMutableComposition* mixComposition = [AVMutableComposition composition];
    
    //Video And Audio Composition track
    AVMutableCompositionTrack *a_compositionVideoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    AVMutableCompositionTrack *b_compositionAudioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
//    AVMutableCompositionTrack *c_compositionSubTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeSubtitle preferredTrackID:kCMPersistentTrackID_Invalid];
    
    
    //Video and Audio Asset
    AVURLAsset* videoAsset = [[AVURLAsset alloc]initWithURL:video_inputFileUrl options:nil];
    AVURLAsset* audioAsset = [[AVURLAsset alloc]initWithURL:audio_inputFileUrl options:nil];
//    AVURLAsset* subAsset = [[AVURLAsset alloc]initWithURL:sub_inputFileUrl options:nil];
    
    // Get the first video track from each asset.
    AVAssetTrack *videoAssetTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    AVAssetTrack *audioAssetTrack = [[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
//    AVAssetTrack *subAssetTrack = [[subAsset tracksWithMediaType:AVMediaTypeSubtitle] objectAtIndex:0];
    
    //Get time duration
    CMTimeRange video_timeRange = CMTimeRangeMake(kCMTimeZero,videoAsset.duration);
//    CMTimeRange audio_timeRange = CMTimeRangeMake(kCMTimeZero, audioAsset.duration);
    
    //add assetTrack to composition
    [a_compositionVideoTrack insertTimeRange:video_timeRange ofTrack:videoAssetTrack atTime:nextClipStartTime error:nil];
    [b_compositionAudioTrack insertTimeRange:video_timeRange ofTrack:audioAssetTrack atTime:nextClipStartTime error:nil];
//    [c_compositionSubTrack insertTimeRange:video_timeRange ofTrack:subAssetTrack atTime:nextClipStartTime error:nil];
    
    //instructions
    AVMutableVideoCompositionInstruction *mainInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
   // CMTimeRange time = CMTimeRangeMake(kCMTimeZero,CMTimeMake(5, 1));
    mainInstruction.timeRange = video_timeRange;
    
    //Instruction Layer
    AVMutableVideoCompositionLayerInstruction *videolayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:a_compositionVideoTrack];
    
    UIImageOrientation videoAssetOrientation_  = UIImageOrientationUp;
    BOOL isVideoAssetPortrait_  = NO;
    CGAffineTransform videoTransform = videoAssetTrack.preferredTransform;
    if (videoTransform.a == 0 && videoTransform.b == 1.0 && videoTransform.c == -1.0 && videoTransform.d == 0) {
        videoAssetOrientation_ = UIImageOrientationRight;
        isVideoAssetPortrait_ = YES;
    }
    if (videoTransform.a == 0 && videoTransform.b == -1.0 && videoTransform.c == 1.0 && videoTransform.d == 0) {
        videoAssetOrientation_ =  UIImageOrientationLeft;
        isVideoAssetPortrait_ = YES;
    }
    if (videoTransform.a == 1.0 && videoTransform.b == 0 && videoTransform.c == 0 && videoTransform.d == 1.0) {
        videoAssetOrientation_ =  UIImageOrientationUp;
    }
    if (videoTransform.a == -1.0 && videoTransform.b == 0 && videoTransform.c == 0 && videoTransform.d == -1.0) {
        videoAssetOrientation_ = UIImageOrientationDown;
    }
    //CMTime subTime = CMTimeAdd(kCMTimeZero, frameTime);
    [videolayerInstruction setTransform:videoAssetTrack.preferredTransform atTime:kCMTimeZero];

    [videolayerInstruction setOpacity:0.0 atTime:videoAsset.duration];
    
    mainInstruction.layerInstructions = [NSArray arrayWithObjects:videolayerInstruction,nil];
    
    AVMutableVideoComposition *mainCompositionInst = [AVMutableVideoComposition videoComposition];
    
    CGSize naturalSize;
    if(isVideoAssetPortrait_){
        naturalSize = CGSizeMake(videoAssetTrack.naturalSize.height, videoAssetTrack.naturalSize.width);
    } else {
        naturalSize = videoAssetTrack.naturalSize;
    }
    
    float renderWidth, renderHeight;
    renderWidth = naturalSize.width;
    renderHeight = naturalSize.height;
    mainCompositionInst.renderSize = CGSizeMake(renderWidth, renderHeight);
    mainCompositionInst.instructions = [NSArray arrayWithObject:mainInstruction];
    mainCompositionInst.frameDuration = CMTimeMake(1, 4);
    
    [self applyVideoEffectsToComposition:mainCompositionInst size:naturalSize];
    
    //Export Session
    AVAssetExportSession* _assetExport = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetHighestQuality];
    
    //Export
    _assetExport.outputURL=outputFileUrl;
    _assetExport.outputFileType = AVFileTypeQuickTimeMovie;
    _assetExport.shouldOptimizeForNetworkUse = YES;
    _assetExport.videoComposition = mainCompositionInst;
    [_assetExport exportAsynchronouslyWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self exportDidFinish:_assetExport];
        });
    }];

    
}
- (void)applyVideoEffectsToComposition:(AVMutableVideoComposition *)composition size:(CGSize)size {
    // 1 - Set up the text layer
    CATextLayer *subtitle1Text = [[CATextLayer alloc] init];
    [subtitle1Text setFont:@"Helvetica-Bold"];
    [subtitle1Text setFontSize:36];
    [subtitle1Text setFrame:CGRectMake(0, 0, size.width, 100)];
    [subtitle1Text setString:subtitle];
    [subtitle1Text setAlignmentMode:kCAAlignmentCenter];
    [subtitle1Text setForegroundColor:[[UIColor whiteColor] CGColor]];
    
    // 2 - The usual overlay
    CALayer *overlayLayer = [CALayer layer];
    [overlayLayer addSublayer:subtitle1Text];
    overlayLayer.borderColor = [[UIColor redColor] CGColor];
    overlayLayer.borderWidth = 2.0;
    overlayLayer.frame = CGRectMake(0, 0, size.height, size.width);
    [overlayLayer setMasksToBounds:YES];
    
    CATransition* transition = [CATransition animation];
    transition.startProgress = 0;
    transition.endProgress = -1.0;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    transition.beginTime = AVCoreAnimationBeginTimeAtZero;
    transition.duration = 5.0;
    
    [overlayLayer addAnimation:transition forKey:@"transition"];
//    CABasicAnimation *animation
//    =[CABasicAnimation animationWithKeyPath:@"opacity"];
//    animation.duration=3.0;
//    animation.repeatCount=5;
//    animation.autoreverses=YES;
//    // animate from fully visible to invisible
//    animation.fromValue=[NSNumber numberWithFloat:1.0];
//    animation.toValue=[NSNumber numberWithFloat:0.0];
//    animation.beginTime = AVCoreAnimationBeginTimeAtZero;
//    [overlayLayer addAnimation:animation forKey:@"animateOpacity"];
    
//    CABasicAnimation *animation =
//    [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    animation.duration=1.0;
//    animation.repeatCount=20;
//    animation.autoreverses=YES;
//    // animate from half size to full size
//    animation.fromValue=[NSNumber numberWithFloat:0.5];
//    animation.toValue=[NSNumber numberWithFloat:1.0];
//    animation.beginTime = AVCoreAnimationBeginTimeAtZero;
//    [overlayLayer addAnimation:animation forKey:@"scale"];
    
    CALayer *parentLayer = [CALayer layer];
    CALayer *videoLayer = [CALayer layer];
    parentLayer.frame = CGRectMake(0, 0, size.width, size.height);
    videoLayer.frame = CGRectMake(0, 0, size.width, size.height);
    [parentLayer addSublayer:videoLayer];
    [parentLayer addSublayer:overlayLayer];
    
    composition.animationTool = [AVVideoCompositionCoreAnimationTool
                                 videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer inLayer:parentLayer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)createAndSave:(UIButton *)sender {
    [self initialization];
    [self createAndSaveVideo];
}
- (NSDictionary *)videoSettingsWithCodec:(NSString *)codec withWidth:(CGFloat)width andHeight:(CGFloat)height {
    if ((int)width % 16 != 0 ) {
        NSLog(@"Warning: video settings width must be divisible by 16.");
    }
    NSDictionary *videoSettings = @{AVVideoCodecKey : AVVideoCodecH264,
                                    AVVideoWidthKey : [NSNumber numberWithInt:(int)width],
                                    AVVideoHeightKey : [NSNumber numberWithInt:(int)height]};
    return videoSettings;
}


@end
