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
	
	public static function removeInterstitialListeners(handler) {
		setInterstitialListeners(handler, null, null, null);
	}
	
	public static function setTestDevice(hash : String) {
		native_setTestDevice(hash);
	}

	#if android
	
	static var nativ_initAd = JNI.createStaticMethod("org.haxe.extension.dfp.DFP", "initAd", "(Ljava/lang/String;IIIZ)V");
	static var nativ_showAd = JNI.createStaticMethod("org.haxe.extension.dfp.DFP", "showAd", "()V");
	static var nativ_hideAd = JNI.createStaticMethod("org.haxe.extension.dfp.DFP", "hideAd", "()V");
	
	static var nativ_initInterstitial = JNI.createStaticMethod("org.haxe.extension.dfp.DFP", "initInterstitial", "(Ljava/lang/String;Z)V");
	static var nativ_showInterstitial = JNI.createStaticMethod("org.haxe.extension.dfp.DFP", "showInterstitial", "()V");
	static var nativ_setInterstitialListener = JNI.createStaticMethod("org.haxe.extension.dfp.DFP", "setInterstitialListeners", "(Lorg/haxe/lime/HaxeObject;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V");
	
	static var native_setTestDevice = JNI.createStaticMethod("org.haxe.extension.dfp.DFP", "setTestDevice", "(Ljava/lang/String;)V");
	#end
	
}