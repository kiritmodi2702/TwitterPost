//
//  ViewController.m
//  Twitter Demo
//
//  Created by mspsys087 on 12/4/14.
//  Copyright (c) 2014 mspsys087. All rights reserved.
//

#import "ViewController.h"
#import "FHSTwitterEngine.h"

@interface ViewController ()

@end

@implementation ViewController

id response;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[FHSTwitterEngine sharedEngine]permanentlySetConsumerKey:@"Yi91A6xPiHQfxjV5NzWBw" andSecret:@"NJkHm22eWgJROQmdfaod8zVuKfkEnyYmfcmrJu5k"];
    [[FHSTwitterEngine sharedEngine]setDelegate:self];
    [[FHSTwitterEngine sharedEngine]loadAccessToken];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"== %@",[[FHSTwitterEngine sharedEngine] getDetailsForTweet:@"542213881288876032"]);
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)TwitterStatus
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            NSString *tweet = @"This is testing message with image.";
            
            NSData *data=UIImagePNGRepresentation([UIImage imageNamed:@"scan.png"]);
            NSError *returned = [[FHSTwitterEngine sharedEngine]postTweet:tweet withImageData:data];
            
            NSLog(@"== %@",returned);
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            NSString *title = nil;
            NSString *message = nil;
            
            if ([returned isKindOfClass:[NSError class]]) {
                NSError *error = (NSError *)returned;
                title = [NSString stringWithFormat:@"Error %ld",(long)error.code];
                message = error.localizedDescription;
            } else {
                NSLog(@"%@",returned);
                title = @"Tweet Posted";
                message = tweet;
            }
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                @autoreleasepool {
                    UIAlertView *av = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [av show];
                }
            });
        }
    });

}

-(IBAction)tweet:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"SavedAccessHTTPBody"] length] > 0)
    {
        [self TwitterStatus];
    }
    else
    {
        UIViewController *loginController = [[FHSTwitterEngine sharedEngine]loginControllerWithCompletionHandler:^(BOOL success) {
            
            if (success)
            {
                NSLog(@"== %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"SavedAccessHTTPBody"]);
                
                [self TwitterStatus];
            }
            
            NSLog(success?@"L0L success":@"O noes!!! Loggen faylur!!!");
            
            // NSLog(@"Sucess = %d",[success integervalue]);
        }];
        [self presentViewController:loginController animated:YES completion:nil];
    }
}

-(IBAction)Reply:(id)sender
{

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            NSString *tweet = @"reply about soampli testing";
            
            NSData *data=UIImagePNGRepresentation([UIImage imageNamed:@"scan.png"]);
            NSError *returned = [[FHSTwitterEngine sharedEngine]postTweet:tweet withImageData:data inReplyTo:@"542213881288876032"];
            
            NSLog(@"== %@",returned);
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            NSString *title = nil;
            NSString *message = nil;
            
            if ([returned isKindOfClass:[NSError class]]) {
                NSError *error = (NSError *)returned;
                title = [NSString stringWithFormat:@"Error %ld",(long)error.code];
                message = error.localizedDescription;
            } else {
                NSLog(@"%@",returned);
                title = @"Tweet Posted";
                message = tweet;
            }
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                @autoreleasepool {
                    UIAlertView *av = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [av show];
                }
            });
        }
    });

}

-(IBAction)favorite:(id)sender
{
    
    response = [[FHSTwitterEngine sharedEngine] getDetailsForTweet:@"542213881288876032"];
    
    if (response)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @autoreleasepool {
                
                
                NSError *returned;
                
                if ([[response objectForKey:@"favorited"] integerValue] == 0)
                {
                    returned =  [[FHSTwitterEngine sharedEngine] markTweet:@"542213881288876032" asFavorite:TRUE];
                }
                else
                {
                    returned =  [[FHSTwitterEngine sharedEngine] markTweet:@"542213881288876032" asFavorite:FALSE];
                    
                }
                
                
                NSLog(@"== %@",returned);
                
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                
                NSString *title = nil;
                NSString *message = nil;
                
                if ([returned isKindOfClass:[NSError class]]) {
                    NSError *error = (NSError *)returned;
                    title = [NSString stringWithFormat:@"Error %ld",(long)error.code];
                    message = error.localizedDescription;
                } else {
                    NSLog(@"%@",returned);
                    title = @"Tweet Posted";
                    message = @"favorties";
                }
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    @autoreleasepool {
                        UIAlertView *av = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [av show];
                    }
                });
            }
        });

    }
  
}
-(IBAction)retweet:(id)sender
{
    //544745299688689664
    
    // get aboveID from another user and Retweet
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            NSString *tweet = @"reply about soampli testing";
            
            //NSData *data=UIImagePNGRepresentation([UIImage imageNamed:@"scan.png"]);
            NSError *returned = [[FHSTwitterEngine sharedEngine]retweet:@"544745299688689664"];
            
            NSLog(@"== %@",returned);
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            NSString *title = nil;
            NSString *message = nil;
            
            if ([returned isKindOfClass:[NSError class]]) {
                NSError *error = (NSError *)returned;
                title = [NSString stringWithFormat:@"Error %ld",(long)error.code];
                message = error.localizedDescription;
            } else {
                NSLog(@"%@",returned);
                title = @"Tweet Posted";
                message = tweet;
            }
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                @autoreleasepool {
                    UIAlertView *av = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [av show];
                }
            });
        }
    });

}

@end
