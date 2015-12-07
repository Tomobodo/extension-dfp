#ifndef EXTENSION_DFP
#define EXTENSION_DFP

#import <hx/CFFI.h>
#import <UIKit/UIKit.h>

#import "GoogleMobileAds/DFPRequest.h"
#import "GoogleMobileAds/DFPBannerView.h"
#import "GoogleMobileAds/DFPInterstitial.h"
#import "GoogleMobileAds/GADRequestError.h"

@interface InterstitialDelegate : NSObject

- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial;
- (void)interstitial:(GADInterstitial *)interstitial didFailToReceiveAdWithError:(GADRequestError *)error;
- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial;

@end

namespace extension_dfp {
    
    NSMutableDictionary* banners;
    
    DFPInterstitial* interstitial;
    InterstitialDelegate* interstitialDelegate;
    
    AutoGCRoot* onAdLoadedCB;
    AutoGCRoot* onAdFailedCB;
    AutoGCRoot* onAdClosedCB;
    
    void initAd(value adId, value hPos, value vPos, value size, value testMode);
    void showAd(value adId);
    void hideAd(value adId);
    
    void initInterstitial(value adId, value testMode);
    void showInterstitial();
    void setInterstitialListeners(value onLoaded, value onFailed, value onClosed);
    
    DEFINE_PRIM(initAd, 5);
    DEFINE_PRIM(showAd, 1);
    DEFINE_PRIM(hideAd, 1);
    
    DEFINE_PRIM(initInterstitial, 2);
    DEFINE_PRIM(showInterstitial, 0);
    DEFINE_PRIM(setInterstitialListeners, 3);
    
    UIViewController* getRootView();
    
}

#endif