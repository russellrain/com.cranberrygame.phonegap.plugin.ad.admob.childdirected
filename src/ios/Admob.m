// Copyright (c) 2014 cranberrygame
// Email: cranberrygame@yahoo.com
// Phonegap plugin: http://www.github.com/cranberrygame
// Construct2 phonegap plugin: https://www.scirra.com/forum/viewtopic.php?f=153&t=109586
// License: MIT (http://opensource.org/licenses/MIT)
#import "Admob.h"
//
#import "GADAdMobExtras.h"
#import "GADAdSize.h"
#import "GADBannerView.h"
#import "GADInterstitial.h"
#import "MainViewController.h"

@implementation Admob

@synthesize adUnit;
@synthesize adUnitFullScreen;
@synthesize isOverlap;
@synthesize isTest;
//
@synthesize bannerView;
@synthesize interstitialView;
@synthesize interstitialViewCallbackId;
//
@synthesize bannerAdPreloaded;	
@synthesize fullScreenAdPreloaded;	
@synthesize position;
@synthesize size;
@synthesize lastOrientation;

- (CDVPlugin *)initWithWebView:(UIWebView *)theWebView {
    self = (Admob *)[super initWithWebView:theWebView];
    if (self) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(deviceOrientationChangeAdmob:)
         name:UIDeviceOrientationDidChangeNotification
         object:nil];
    }
    return self;
}

- (void)deviceOrientationChangeAdmob:(NSNotification *)notification{
    if (bannerView != nil)
    {
/*	
        CGRect bannerFrame = bannerView.frame;
        if (bannerFrame.origin.y != 0)
        {
            bannerFrame.origin.y = self.webView.frame.size.width - bannerView.frame.size.height;
        }
        bannerFrame.origin.x = self.webView.frame.size.height * 0.5f - bannerView.frame.size.width * 0.5f;
        bannerView.frame = bannerFrame;
*/
    }
}

- (bool)_isLandscape {
    bool landscape = NO;
        
    UIDeviceOrientation currentOrientation = [[UIDevice currentDevice] orientation];
    if (UIInterfaceOrientationIsLandscape(currentOrientation)) {
        landscape = YES;
    }
    return landscape;
}

- (void)setUp: (CDVInvokedUrlCommand*)command {
    //self.viewController
    //
	NSString *adUnit = [command.arguments objectAtIndex: 0];
	NSLog(@"%@", adUnit);
	NSString *adUnitFullScreen = [command.arguments objectAtIndex: 1];
	NSLog(@"%@", adUnitFullScreen);
	BOOL isOverlap = [command.arguments objectAtIndex: 2];
	NSLog(@"%@", isOverlap);
	BOOL isTest = [command.arguments objectAtIndex: 3];
	NSLog(@"%@", isTest);

	[self _setUp:adUnit anAdUnitFullScreen:adUnitFullScreen aIsTest:isTest];
    
	[self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
	//[self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
}

- (void)preloadBannerAd: (CDVInvokedUrlCommand*)command {
    //self.viewController

	self.bannerAdPreloaded = YES;
	
	[self _preloadBannerAd];
    
	[self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
	//[self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
}

- (void)refreshBannerAd: (CDVInvokedUrlCommand*)command {
    //self.viewController

	self.bannerAdPreloaded = YES;	
	
	[self _refreshBannerAd];

	[self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
	//[self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
}

- (void)showBannerAd: (CDVInvokedUrlCommand*)command {
    //self.viewController
    //
	NSString *position = [command.arguments objectAtIndex: 0];
	NSLog(@"%@", position);
	NSString *size = [command.arguments objectAtIndex: 1];
	NSLog(@"%@", size);

	[self _showBannerAd:position aSize:size];

	[self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
	//[self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
}

- (void)hideBannerAd: (CDVInvokedUrlCommand*)command {
    //self.viewController

	[self _hideBannerAd];

	[self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
	//[self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
}
- (void)preloadFullScreenAd: (CDVInvokedUrlCommand*)command {
    //self.viewController

	self.fullScreenAdPreloaded = YES;	
	
	[self _preloadFullScreenAd];

	//[self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
	//[self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
	
	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:command.callbackId];

    self.interstitialViewCallbackId = command.callbackId;	
}

- (void)refreshFullScreenAd: (CDVInvokedUrlCommand*)command {
    //self.viewController

	self.fullScreenAdPreloaded = YES;	
	
	[self _refreshFullScreenAd];

	//[self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
	//[self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
	
	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:command.callbackId];
	
    self.interstitialViewCallbackId = command.callbackId;	
}

- (void)showFullScreenAd: (CDVInvokedUrlCommand*)command {
    //self.viewController
	
	[self _showFullScreenAd];

	//[self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
	//[self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
	
	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:command.callbackId];
    
    self.interstitialViewCallbackId = command.callbackId;
}

//-------------------------------------------------------------------
- (void) _setUp:(NSString *)adUnit anAdUnitFullScreen:(NSString *)adUnitFullScreen aIsOverlay:(BOOL)isOverlap aIsTest:(BOOL)isTest
{
	self.adUnit = adUnit;
	self.adUnitFullScreen = adUnitFullScreen;
	self.isOverlap = isOverlap;
	self.isTest = isTest;
}
- (void) _preloadBannerAd
{
    if (bannerView != nil)
    {
        //https://developer.apple.com/library/ios/documentation/uikit/reference/UIView_Class/UIView/UIView.html#//apple_ref/occ/cl/UIView
        [self.bannerView removeFromSuperview];
	}
	
    //if (bannerView == nil)
    //{
		if(size == nil) {
			size = @"SMART_BANNER";
		}	
		GADAdSize adSize = kGADAdSizeBanner;
		//https://developers.google.com/mobile-ads-sdk/docs/admob/android/banner			
		if ([size isEqualToString:@"BANNER"]) {
			adSize = kGADAdSizeBanner;//Banner (320x50, Phones and Tablets)
		} 
		else if ([size isEqualToString:@"LARGE_BANNER"]) {
			adSize = kGADAdSizeLargeBanner;//Large banner (320x100, Phones and Tablets)
		}
		else if ([size isEqualToString:@"MEDIUM_RECTANGLE"]) {
			adSize = kGADAdSizeMediumRectangle;//Medium rectangle (300x250, Phones and Tablets)
		}
		else if ([size isEqualToString:@"FULL_BANNER"]) {
			adSize = kGADAdSizeFullBanner;//Full banner (468x60, Tablets)
		}
		else if ([size isEqualToString:@"LEADERBOARD"]) {
			adSize = kGADAdSizeLeaderboard;//Leaderboard (728x90, Tablets)
		}
		else if ([size isEqualToString:@"SKYSCRAPER"]) {
			adSize = kGADAdSizeSkyscraper;//Skyscraper (120x600, Tablets)
		}		
		else if ([size isEqualToString:@"SMART_BANNER"]) {
			if([self _isLandscape]) {
				adSize = kGADAdSizeSmartBannerLandscape;//Smart banner (Auto size, Phones and Tablets) //https://developers.google.com/mobile-ads-sdk/docs/admob/android/banner#smart
			}
			else {
				adSize = kGADAdSizeSmartBannerPortrait;
			}			
		}
		else {
			if([self _isLandscape]) {
				adSize = kGADAdSizeSmartBannerLandscape;
			}
			else {
				adSize = kGADAdSizeSmartBannerPortrait;
			}			
		}		
		
		bannerView = [[GADBannerView alloc] initWithAdSize:adSize];
		bannerView.adUnitID = self.adUnit;
		bannerView.delegate = self;
		bannerView.rootViewController = self.viewController;//
	//}
    
    [self _refreshBannerAd];
}
- (void) _refreshBannerAd
{
	if (bannerView != nil)
	{
		GADRequest *request = [GADRequest request];
		if (isTest) {
		/*
			request.testDevices =
			[NSArray arrayWithObjects:
			GAD_SIMULATOR_ID,
			// TODO: Add your device/simulator test identifiers here. They are printed to the console when the app is launched.			
			nil];
		*/
			//https://github.com/acyl/phonegap-plugins-1/blob/master/iOS/AdMobPlugin/AdMobPlugin.m
			request.testing = YES;
		}
		[self.bannerView loadRequest:request];	
	}
}
- (void) _showBannerAd:(NSString *)position aSize:(NSString *)size
{
	self.position = position;
	self.size = size;

	if(bannerAdPreloaded) {
		bannerAdPreloaded = NO;
	}
	else{
		[self _preloadBannerAd];
	}
			
    CGRect bannerFrame = bannerView.frame;
	if ([position isEqualToString:@"top-center"]) {
		    
		bannerFrame.origin.y = 0;
	}
	else {
		bannerFrame.origin.y = self.webView.frame.size.height - bannerView.frame.size.height;
	}
    bannerFrame.origin.x = self.webView.frame.size.width * 0.5f - bannerView.frame.size.width * 0.5f;
    bannerView.frame = bannerFrame;
    //https://developer.apple.com/library/ios/documentation/uikit/reference/UIView_Class/UIView/UIView.html#//apple_ref/occ/cl/UIView
	[self.webView addSubview:bannerView];
}
- (void) _hideBannerAd
{
    if (bannerView != nil)
    {
        //https://developer.apple.com/library/ios/documentation/uikit/reference/UIView_Class/UIView/UIView.html#//apple_ref/occ/cl/UIView
        [self.bannerView removeFromSuperview];
	}
}
- (void) _preloadFullScreenAd
{    
    if (interstitialView == nil || self.interstitialView.hasBeenUsed){//ios only //An interstitial object can only be used once for ios
        self.interstitialView = [[GADInterstitial alloc] init];
        self.interstitialView.adUnitID = adUnitFullScreen;
        self.interstitialView.delegate = self;
    }	

	[self _refreshFullScreenAd];
}
- (void) _refreshFullScreenAd
{
	if (interstitialView != nil) {
		GADRequest *request = [GADRequest request];
		if (isTest) {
			request.testDevices =
			[NSArray arrayWithObjects:
			GAD_SIMULATOR_ID,
			nil];
		}		 
		[self.interstitialView loadRequest:request];
	}
}
- (void) _showFullScreenAd
{
	if(fullScreenAdPreloaded) {
		if (interstitialView == nil || self.interstitialView.hasBeenUsed){
			[self _preloadFullScreenAd];
		}
		
		[self.interstitialView presentFromRootViewController:self.viewController];
		
		fullScreenAdPreloaded = NO;
	}
	else{
		[self _preloadFullScreenAd];
	}		
}

//GADBannerViewDelegate
- (void)adViewDidReceiveAd:(GADBannerView *)view {
	NSLog(@"adViewDidReceiveAd");
	bannerView.hidden = NO;
}
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
	NSLog(@"adView");
	bannerView.hidden = YES;
}
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
	NSLog(@"adViewWillPresentScreen");
}
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
	NSLog(@"adViewWillDismissScreen");
}
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
	NSLog(@"adViewDidDismissScreen");
}
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
	NSLog(@"adViewWillLeaveApplication");
}
//GADInterstitialDelegate
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
	NSLog(@"interstitialDidReceiveAd");

	NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:1];
	[dict setObject:@"onFullScreenAdLoaded" forKey:@"result"];
	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dict];
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:self.interstitialViewCallbackId];	

	if(fullScreenAdPreloaded) {
	}
	else {
		[self.interstitialView presentFromRootViewController:self.viewController];
	}
}
- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
	NSLog(@"interstitial");
}
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
	NSLog(@"interstitialWillPresentScreen");
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:1];
    [dict setObject:@"onFullScreenAdShown" forKey:@"result"];
    CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dict];
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:self.interstitialViewCallbackId];	
}
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
	NSLog(@"interstitialWillDismissScreen");
}
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
	NSLog(@"interstitialDidDismissScreen");
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:1];
    [dict setObject:@"onFullScreenAdClosed" forKey:@"result"];
    CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dict];
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:self.interstitialViewCallbackId];
}
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
	NSLog(@"interstitialWillLeaveApplication");
}

- (void)dealloc {
	[[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
	[[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:UIDeviceOrientationDidChangeNotification
     object:nil];
}

@end