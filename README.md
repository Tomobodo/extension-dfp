# exension-dfp
extension to use dfp in your game

## Use

First include the following extension in your project.xml : google-play-service.
You can find it [here](https://github.com/TBaudon/google-play-services-openfl).

```xml
<haxelib name="google-play-service" if="android"/>
```

Then include the extension.

```xml
<haxelib name="dfp" />
```

## Sample

```haxe
import org.extension.dfp.DFP;
import org.extension.dfp.AdPosition;
import org.extension.dfp.AdSize;

import openfl.events.MouseEvent;
import openfl.display.Sprite;

class MyGame extends Sprite {
    
    public function new(){
        super();
        
        DFP.initAd("/45698/YOUR_DFP_TAG", AdPosition.CENTER, AdPosition.BOTTOM, AdSize.BANNER);
        DFP.showAd();
        
        var btnTest = new Sprite();
        btnTest.graphics.beginFill(0x0000ff);
        btnTest.graphics.drawRect(0,0,200,100);
        addChild(btnTest);
        
        btnTest.addEventListener(MouseEvent.CLICK, onClick);
    }
    
    function onClick(e : Event){
        DFP.setInterstitialListeners(this, "onInterstitialLoaded", "onInterstitialError", "onInterstitialClosed");
        DFP.initInterstitial("/45698/YOUR_DFP_INTERSTIAL");
    }
    
    function onInterstitialClosed() {
		trace("adClosed");
	}
	
	function onInterstitialError(errorCode : Int) {
		trace(errorCode);
	}
	
	function onInterstitialLoaded() {
		trace("adLoaded" );
		DFP.showInterstitial();
	}
    
}
```