package extension.dfp;

#if android
import openfl.utils.JNI;
#end

#if ios
import cpp.Lib;
#end

/**
 * ...
 * @author Thomas B
 */
 
class DFP {
	
	public static function initAd(adId : String, x : Int, y : Int, position : Int, testMode : Bool = false) {
		#if android
		jni_initAd(adId, x, y, position, testMode);
		#elseif ios
		objC_initAd(adId, x, y, position, testMode);
		#end
	}
	
	public static function showAd(adId : String) {
		#if android
		jni_showAd();
		#elseif ios
		objC_showAd(adId);
		#end
	}
	
	public static function hideAd(adId : String) {
		#if android
		jni_hideAd();
		#elseif ios
		objC_hideAd(adId);
		#end
	}
	
	public static function initInterstitial(adId : String, testMode : Bool = false) {
		#if android
		jni_initInterstitial(adId, testMode);
		#elseif ios
		objC_initInterstitial(adId, testMode);
		#end
	}
	
	public static function showInterstitial() {
		#if android
		jni_showInterstitial();
		#elseif ios
		objC_showInterstitial();
		#end
	}
	
	public static function setInterstitialListeners(handler : Dynamic, onAdLoaded : String = null, onAdFailed : String = null, onAdClosed : String = null) {
		#if android
		jni_setInterstitialListener(handler, onAdLoaded, onAdFailed, onAdClosed);
		#elseif ios
		var loadedFunction = Reflect.field(handler, onAdLoaded);
		var failedFunction = Reflect.field(handler, onAdFailed);
		var closedFunction = Reflect.field(handler, onAdClosed);
		objC_setInterstitialLiteners(loadedFunction, failedFunction, closedFunction);
		#end
	}
	
	public static function removeInterstitialListeners(handler) {
		setInterstitialListeners(handler, null, null, null);
	}
	
	public static function setTestDevice(hash : String) {
		#if android
		jni_setTestDevice(hash);
		#elseif ios
		#end
	}

	#if android
	
	static var jni_initAd = JNI.createStaticMethod("org.haxe.extension.dfp.DFP", "initAd", "(Ljava/lang/String;IIIZ)V");
	static var jni_showAd = JNI.createStaticMethod("org.haxe.extension.dfp.DFP", "showAd", "()V");
	static var jni_hideAd = JNI.createStaticMethod("org.haxe.extension.dfp.DFP", "hideAd", "()V");
	
	static var jni_initInterstitial = JNI.createStaticMethod("org.haxe.extension.dfp.DFP", "initInterstitial", "(Ljava/lang/String;Z)V");
	static var jni_showInterstitial = JNI.createStaticMethod("org.haxe.extension.dfp.DFP", "showInterstitial", "()V");
	static var jni_setInterstitialListener = JNI.createStaticMethod("org.haxe.extension.dfp.DFP", "setInterstitialListeners", "(Lorg/haxe/lime/HaxeObject;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V");
	
	static var jni_setTestDevice = JNI.createStaticMethod("org.haxe.extension.dfp.DFP", "setTestDevice", "(Ljava/lang/String;)V");
	
	#elseif ios
	
	static var objC_initAd = Lib.load("extension_dfp", "initAd", 5);
	static var objC_showAd = Lib.load("extension_dfp", "showAd", 1);
	static var objC_hideAd = Lib.load("extension_dfp", "hideAd", 1);
	
	static var objC_initInterstitial = Lib.load("extension_dfp", "initInterstitial", 2);
	static var objC_showInterstitial = Lib.load("extension_dfp", "showInterstitial", 0);
	static var objC_setInterstitialLiteners = Lib.load("extension_dfp", "setInterstitialListeners", 3);
	
	#end
	
}