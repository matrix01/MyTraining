//
//  ViewController.m
//  AVPlayer
//
//  Created by Md. Milan Mia on 11/17/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    AVAsset *anAsset;
    __weak IBOutlet UIImageView *imageView;
    NSMutableArray *imageArray;
    NSOperationQueue *opQ;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    opQ = [NSOperationQueue new];
    imageArray = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view, typically from a nib.
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    //__block NSBlockOperation *operationBlock;
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        // NSLog(@"Running on %@ thread", [NSThread currentThread]);
        [group setAssetsFilter:[ALAssetsFilter allVideos]];
        [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:0] options:0 usingBlock:^(ALAsset *alAsset, NSUInteger index, BOOL *stop) {
             //NSLog(@"Running on %@ thread", [NSThread currentThread]);
            if(alAsset){
                ALAssetRepresentation *representation = [alAsset defaultRepresentation];
                NSURL *url = [representation url];
                AVAsset *avAsset = [AVURLAsset URLAssetWithURL:url options:nil];
                NSLog(@"URL: %@ AVASSET: %@", url, avAsset);
                NSArray *keys = @[@"duration"];
                anAsset = avAsset;
                [avAsset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
                    NSError *error = nil;
                    AVKeyValueStatus durationStatus = [avAsset statusOfValueForKey:@"duration" error:&error];
                    switch (durationStatus) {
                        case AVKeyValueStatusLoaded:
                            //[self imageGenerator];
                            [self videoExport];
                            break;
                        case AVKeyValueStatusFailed:
                            NSLog(@"Failed");
                            break;
                        case AVKeyValueStatusCancelled:
                            // Do whatever is appropriate for cancelation.
                            break;
                    }
                }];
            }
        }];
    } failureBlock:^(NSError *error) {
        NSLog(@"No Asset Found!");
    }];
}

- (void)videoExport{
    
    NSArray *compitablePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:anAsset];
    if ([compitablePresets containsObject:AVAssetExportPresetLowQuality]) {
        // 4 - Get path
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:
                                 [NSString stringWithFormat:@"FinalVideo-%d.mov",arc4random() % 1000]];
        NSURL *url = [NSURL fileURLWithPath:myPathDocs];
        
        // 5 - Create exporter
        AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:anAsset
                                                                          presetName:AVAssetExportPresetHighestQuality];
        
        CMTime start = CMTimeMakeWithSeconds(5.0, 600);
        CMTime duration = CMTimeMakeWithSeconds(10.0, 600);
        CMTimeRange range = CMTimeRangeMake(start, duration);
        exporter.timeRange = range;
        
        exporter.outputURL=url;
        exporter.outputFileType = AVFileTypeQuickTimeMovie;
        [exporter exportAsynchronouslyWithCompletionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self exportDidFinish:exporter];
            });
        }];
    }
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

- (void)imageGenerator {
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:anAsset];
    Float64 durationSeconds = CMTimeGetSeconds([anAsset duration]);
    CMTime firstThird = CMTimeMakeWithSeconds(durationSeconds/3.0, 600);
    CMTime secondThird = CMTimeMakeWithSeconds(durationSeconds*2.0/3.0, 600);
    CMTime end = CMTimeMakeWithSeconds(durationSeconds, 600);
    NSArray *times = @[[NSValue valueWithCMTime:firstThird], [NSValue valueWithCMTime:secondThird], [NSValue valueWithCMTime:end]];
    [imageGenerator generateCGImagesAsynchronouslyForTimes:times completionHandler:^(CMTime requestedTime, CGImageRef image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error) {
        NSString *requestedTimeString = (NSString*)CFBridgingRelease(CMTimeCopyDescription(NULL, requestedTime));
        NSString *actualTimeString = (NSString*)CFBridgingRelease(CMTimeCopyDescription(NULL, actualTime));
        NSLog(@"Requested: %@; actual %@", requestedTimeString,
              actualTimeString);
        if (result == AVAssetImageGeneratorSucceeded) {
            UIImage *img = [UIImage imageWithCGImage:image];
            [imageArray addObject:img];
            dispatch_async(dispatch_get_main_queue(), ^{
                imageView.image = img;
            });
            //sleep(5);
        }
        if (result == AVAssetImageGeneratorFailed) {
            NSLog(@"Failed with error: %@", [error localizedDescription]);
        }
        if (result == AVAssetImageGeneratorCancelled) {
            NSLog(@"Canceled");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
