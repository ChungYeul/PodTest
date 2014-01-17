//
//  ViewController.m
//  PodTest
//
//  Created by T on 2014. 1. 17..
//  Copyright (c) 2014년 T. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *ipLabel;

@end

@implementation ViewController
- (IBAction)captureScreen:(id)sender {
    UIImage *image = [self screenshot];
    
    UIImageWriteToSavedPhotosAlbum(
                                   image,
                                   self,
                                   @selector(image:didFinishSavingWithError:contextInfo:), 
                                   nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
	NSLog(@"finished saving %@", [error localizedDescription]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [UIDevice currentDevice].identifierForVendor;
    // iCloud -> 안써
    // 서버로 보내요
    // 앱을 지운다
    // 다시 설치
    // 서버로 보내요 (의도치 않은 초기화)
    // 회원 ID 별도로 필요
	// Do any additional setup after loading the view, typically from a nib.
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://ip.jsontest.com" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject[@"ip"]);
        NSString *ipAddress = responseObject[@"ip"];
//        self.ipLabel.text = ipAddress;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (UIImage *) screenshot {
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.ipLabel.font = [UIFont fontWithName:@"NanumBrushOTF" size:30.0];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
