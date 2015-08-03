package extension.dfp;

#if android
import openfl.utils.JNI;
#end

/**
 * ...
 * @author Thomas B
 */
 
class DFP {
	
	public static function initAd(adId : String, x : Int, y : Int, position : Int, testMode : Bool = false) {
		nativ_initAd(adId, x, y, position, testMode);
	}
	
	public static function showAd() {
		nativ_showAd();
	}
	
	public static function hideAd() {
		nativ_hideAd();
	}
	
	public static function initInterstitial(adId : String, testMode : Bool = false) {
		nativ_initInterstitial(adId, testMode);
	}
	
	public static function showInterstitial() {
		nativ_showInterstitial();
	}
	
	public static function setInterstitialListeners(handler : Dynamic, onAdLoaded : String = null, onAdFailed : String = null, onAdClosed : String = null) {
		nativ_setInterstitialListener(handler, onAdLoaded, onAdFailed, onAdClosed);
	}

	#if android
	
	static var nativ_initAd = JNI.createStaticMethod("org.haxe.extension.DFP", "initAd", "(Ljava/lang/String;IIIZ)V");
	static var nativ_showAd = JNI.createStaticMethod("org.haxe.extension.DFP", "showAd", "()V");
	static var nativ_hideAd = JNI.createStaticMethod("org.haxe.extension.DFP", "hideAd", "()V");
	
	static var nativ_initInterstitial = JNI.createStaticMethod("org.haxe.extension.DFP", "initInterstitial", "(Ljava/lang/String;Z)V");
	static var nativ_showInterstitial = JNI.createStaticMethod("org.haxe.extension.DFP", "showInterstitial", "()V");
	
	static var nativ_setInterstitialListener = JNI.createStaticMethod("org.haxe.extension.DFP", "setInterstitialListeners", "(Lorg/haxe/lime/HaxeObject;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V");
	
	#end
	
}