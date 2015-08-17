//
//  ViewController.m
//  OovooTest
//
//  Created by Young One Park on 2015. 8. 17..
//  Copyright (c) 2015 young1park. All rights reserved.
//

#import <ooVooSDK/ooVooSDK.h>
#import "ViewController.h"
#import "KGModal.h"

#define OOVOO_TOKEN @"your app token"

@interface ViewController () <ooVooAVChatDelegate, ooVooVideoControllerDelegate>

@property (nonatomic, strong) ooVooClient *oovooClient;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.oovooClient = [ooVooClient sharedInstance];
	[self.oovooClient authorizeClient:OOVOO_TOKEN completion:^(SdkResult *result) {
		[self.oovooClient.Account login:@"tester" completion:^(SdkResult *result) {
			VideoPanel *videoPanel = [[VideoPanel alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
			self.oovooClient.AVChat.delegate = self;
			self.oovooClient.AVChat.VideoController.delegate = self;
			[self.oovooClient.AVChat.VideoController bindVideoRender:nil render:videoPanel];
			[self.oovooClient.AVChat.VideoController openCamera];
			[[KGModal sharedInstance] showWithContentView:videoPanel];
		}];
	}];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - ooVooAVChatDelegate

- (void)didParticipantJoin:(id<ooVooParticipant>)participant user_data:(NSString *)user_data {
	
}

- (void)didParticipantLeave:(id<ooVooParticipant>)participant {
	
}

- (void)didConferenceStateChange:(ooVooAVChatState)state error:(sdk_error)code {
	if (state == ooVooAVChatStateJoined) {
		
	} else if (state == ooVooAVChatStateDisconnected) {
		
	}
}

- (void)didReceiveData:(NSString *)uid data:(NSData *)data {
	
}

- (void)didConferenceError:(sdk_error)code {
	
}

- (void)didNetworkReliabilityChange:(NSNumber*)score {
	
}

#pragma mark - ooVooVideoControllerDelegate

- (void)didRemoteVideoStateChange:(NSString *)uid state:(ooVooAVChatRemoteVideoState)state width:(const int)width height:(const int)height error:(sdk_error)code {
	
}

- (void)didCameraStateChange:(BOOL)state devId:(NSString *)devId width:(const int)width height:(const int)height fps:(const int)fps error:(sdk_error)code {
	NSLog(@"didCameraStateChange -> state [%@], code = [%d]", state ? @"Opened" : @"Fail", code);
	if (state) {
//		[self.oovooClient.AVChat.VideoController openPreview];
	}
}

- (void)didVideoTransmitStateChange:(BOOL)state devId:(NSString *)devId error:(sdk_error)code {
	
}

- (void)didVideoPreviewStateChange:(BOOL)state devId:(NSString *)devId error:(sdk_error)code {
	NSLog(@"didVideoPreviewStateChange -> state [%@], code = [%d]", state ? @"Opened" : @"Fail", code);
}

@end
