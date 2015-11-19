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
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void) initialization {
    //Initialize the imageArray
    imageArray = [[NSMutableArray alloc]init];
    UIImage *image = [UIImage imageNamed:@"maxresdefault.jpg"];
    UIImage *image1 = [UIImage imageNamed:@"maxresdefault1.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"gradient-background.jpg"];
    UIImage *image3 = [UIImage imageNamed:@"images.jpg"];
    for (int i=0; i<150; i++) {
        [imageArray addObject:image];
        [imageArray addObject:image1];
        [imageArray addObject:image2];
        [imageArray addObject:image3];
        [imageArray addObject:image];
        [imageArray addObject:image1];
        [imageArray addObject:image2];
        [imageArray addObject:image3];
    }
    NSLog(@"Image Count: %d", [imageArray count]);
    
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
    frameTime = CMTimeMake(1, 10);
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
            NSLog(@"Image Index: %ld", (long)imageIndex);
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
                    NSLog(@"Image Index: %ld", (long)imageIndex);
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
    if (session.status == AVAssetExportSessionStatusCompleted) {
        NSURL *outputURL = session.outputURL;
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:outputURL]) {
            [library writeVideoAtPathToSavedPhotosAlbum:outputURL completionBlock:^(NSURL *assetURL, NSError *error){
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
}

-(void)addAudioToVideo {
    //////////////  OK now add an audio file to move file  /////////////////////
    AVMutableComposition* mixComposition = [AVMutableComposition composition];
    
    NSString *bundleDirectory = [[NSBundle mainBundle] bundlePath];
    // audio input file...
    NSString *audio_inputFilePath = [bundleDirectory stringByAppendingPathComponent:@"Prapty.mp3"];
    NSURL    *audio_inputFileUrl = [NSURL fileURLWithPath:audio_inputFilePath];
    
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
    
    AVURLAsset* audioAsset = [[AVURLAsset alloc]initWithURL:audio_inputFileUrl options:nil];
    CMTime presentTime = CMTimeAdd(kCMTimeZero, frameTime);
    CMTimeRange audio_timeRange = CMTimeRangeMake(kCMTimeZero, audioAsset.duration);
    AVMutableCompositionTrack *b_compositionAudioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    [b_compositionAudioTrack insertTimeRange:audio_timeRange ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:nextClipStartTime error:nil];
    
    AVURLAsset* videoAsset = [[AVURLAsset alloc]initWithURL:video_inputFileUrl options:nil];
    CMTimeRange video_timeRange = CMTimeRangeMake(kCMTimeZero,videoAsset.duration);
    AVMutableCompositionTrack *a_compositionVideoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    [a_compositionVideoTrack insertTimeRange:audio_timeRange ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:nextClipStartTime error:nil];
    
    AVAssetExportSession* _assetExport = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetHighestQuality];
    //_assetExport.outputFileType = @"com.apple.quicktime-movie";
    _assetExport.outputURL=outputFileUrl;
    _assetExport.outputFileType = AVFileTypeQuickTimeMovie;
    [_assetExport exportAsynchronouslyWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self exportDidFinish:_assetExport];
        });
    }];

    
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
