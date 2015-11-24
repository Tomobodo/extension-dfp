#import "extensionDFP.h"

#import <Foundation/Foundation.h>

#import "GoogleMobileAds/GADAdSize.h"

@implementation InterstitialDelegate

-(void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
    if(extension_dfp::onAdLoadedCB != NULL)
        val_call0(extension_dfp::onAdLoadedCB->get());
}

-(void)interstitial:(GADInterstitial *)interstitial didFailToReceiveAdWithError:(GADRequestError *)error {
    if(extension_dfp::onAdFailedCB != NULL){
        NSInteger errorCode = [error code];
        val_call1(extension_dfp::onAdFailedCB->get(), alloc_int((int)errorCode));
    }
}

-(void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    if(extension_dfp::onAdClosedCB != NULL)
        val_call0(extension_dfp::onAdClosedCB->get());
}

@end

namespace extension_dfp {
    
    void initAd(value adId, value hPos, value vPos, value size, value testMode){
        NSString* adUnitID = [[NSString alloc] initWithUTF8String:val_string(adId)];
        
        int bannerSize = val_int(size);
        int bannerHpos = val_int(hPos);
        int bannerVpos = val_int(vPos);
        
        int xPos = 0;
        int yPos = 0;
        
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        
        // init banner with size
        switch (bannerSize) {
            case 0:
                banner = [[DFPBannerView alloc] initWithAdSize:kGADAdSizeBanner];
                break;
                
            case 1:
                banner = [[DFPBannerView alloc] initWithAdSize:kGADAdSizeFullBanner];
                break;
                
            case 2:
                banner = [[DFPBannerView alloc] initWithAdSize:kGADAdSizeLargeBanner];
                break;
                
            case 3:
                banner = [[DFPBannerView alloc] initWithAdSize:kGADAdSizeLeaderboard];
                break;
                
            case 4:
                banner = [[DFPBannerView alloc] initWithAdSize:kGADAdSizeMediumRectangle];
                break;
                
            case 5:
                if(UIDeviceOrientationIsLandscape(orientation))
                    banner = [[DFPBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerLandscape];
                else
                    banner = [[DFPBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
                break;
                
            default:
                banner = [[DFPBannerView alloc] initWithAdSize:kGADAdSizeBanner];
                break;
        }
        
        // set banner posisiton
        if (bannerHpos == 1)
            xPos = getRootView().view.frame.size.width - banner.bounds.size.width;
        else if(bannerHpos == 2)
            xPos = (getRootView().view.frame.size.width - banner.bounds.size.width) / 2;
        
        if (bannerVpos == 1)
            yPos = getRootView().view.frame.size.height - banner.bounds.size.height;
        else if(bannerVpos == 2)
            yPos = (getRootView().view.frame.size.height - banner.bounds.size.height) / 2;
        
        
        [banner setFrame: CGRectMake ( xPos, yPos, banner.bounds.size.width, banner.bounds.size.height)];
        banner.adUnitID = adUnitID;
        banner.rootViewController = getRootView();

        [banner loadRequest:[DFPRequest request]];
    }
    
    void showAd(){
        [getRootView().view addSubview:banner];
    }
    
    void hideAd(){
        [banner removeFromSuperview];
    }
    
    void initInterstitial(value adId, value testMode){
        NSString* interstitialId = [[NSString alloc] initWithUTF8String:val_string(adId)];
        
        interstitial = [[DFPInterstitial alloc] initWithAdUnitID:interstitialId];
        
        if(interstitialDelegate == NULL)
            interstitialDelegate = [[InterstitialDelegate alloc] init];
        interstitial.delegate = interstitialDelegate;
        
        [interstitial loadRequest:[DFPRequest request]];
    }
    
    void showInterstitial(){
        [interstitial presentFromRootViewController:getRootView()];
    }
    
    void setInterstitialListeners(value onLoaded, value onFailed, value onClosed){
        NSLog(@"setting lsiteners");
        if(onLoaded != NULL)
            onAdLoadedCB = new AutoGCRoot(onLoaded);
        else
            onAdLoadedCB = NULL;
        
        if(onFailed != NULL)
            onAdFailedCB = new AutoGCRoot(onFailed);
        else
            onAdFailedCB = NULL;
        
        if(onClosed != NULL)
            onAdClosedCB = new AutoGCRoot(onClosed);
        else
            onAdClosedCB = NULL;
    }
    
    UIViewController* getRootView(){
        return [[[UIApplication sharedApplication] keyWindow] rootViewController];
    }
}

extern "C" {
    
    void dfp_main(){
        val_int(0);
    }
    DEFINE_ENTRY_POINT(dfp_main);
    
    int extension_dfp_register_prims(){return 0;}
    
}