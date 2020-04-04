# Apple sign in ANE
Apple sign in ANE for AdobeAIR is a must have ANE if you are already using other Authentication ANEs like Facebook or GoogleSignIn. This ANE makes it easy for your users to sign in to your app using their Apple ID.

**Main Features:**
* Works on iOS 13+ but it won't crash on earlier iOS versions

[find the latest **asdoc** for this ANE here.](https://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/appleSignIn/package-detail.html)  

# AIR Usage

```actionscript
import com.myflashlab.air.extensions.appleSignIn.*;

AppleSignIn.init();

AppleSignIn.listener.addEventListener(AppleSignInEvent.SUCCESS, onSuccess);
AppleSignIn.listener.addEventListener(AppleSignInEvent.FAILURE, onFailure);

// call this when user clicks on the sign in button:
AppleSignIn.authorize();

function onSuccess(event:AppleSignInEvent):void {
    trace("onSuccess: " + JSON.stringify(event.result));
}

function onFailure(event:AppleSignInEvent):void {
    var errorMsg:String;
    switch (event.error.message) {
        case AppleSignInEvent.ERROR_CANCELLED:
            errorMsg = "The user canceled the authorization attempt.";
            break;
        case AppleSignInEvent.ERROR_FAILED:
            errorMsg = "The authorization attempt failed.";
            break;
        case AppleSignInEvent.ERROR_INVALID_RESPONSE:
            errorMsg = "The authorization request received an invalid response.";
            break;
        case AppleSignInEvent.ERROR_NOT_HANDLED:
            errorMsg = "The authorization request wasn’t handled.";
            break;
        case AppleSignInEvent.ERROR_UNKNOWN:
            errorMsg = "The authorization attempt failed for an unknown reason.";
            break;
        case AppleSignInEvent.ERROR_NOT_AVAILABLE:
            errorMsg = "The authorization using apple not available on SDK version.";
            break;
    }
        trace("onFailure: " + errorMsg);
}
```

# AIR .xml manifest

```xml
<!--
FOR iOS:
-->
	<Entitlements>
    <![CDATA[
    	<key>com.apple.developer.team-identifier</key>
        <string>xxxxxxxxx</string>

        <key>com.apple.developer.applesignin</key>
        <array>
        	<string>Default</string>
        </array>
    ]]>
    </Entitlements>



	
<!--
Embedding the ANE:
-->
<extensions>
	<extensionID>com.myflashlab.air.extensions.appleSignIn</extensionID>

    <!-- dependency ANEs https://github.com/myflashlab/common-dependencies-ANE -->
    <extensionID>com.myflashlab.air.extensions.dependency.overrideAir</extensionID>

</extensions>
```

# Requirements 
1. iOS SDK 10.0+ with no crash. but functions on iOS 13+ only
1. Before implementing the ANE, make sure you have already enabled ```Sign In with Apple``` option from your apple console and also make sure you have re-downloaded your *.mobileprovision* files.

![sign in with apple in Adobe AIR app](https://myflashlab.github.io/wiki_img/Apple-sign-in-01.png)

# Commercial Version
Only available through [ANELAB Software](https://github.com/myflashlab/ANE-LAB/)

# Premium Support #
[![Premium Support package](https://www.myflashlabs.com/wp-content/uploads/2016/06/professional-support.jpg)](https://www.myflashlabs.com/product/myflashlabs-support/)
If you are an [active MyFlashLabs club member](https://www.myflashlabs.com/product/myflashlabs-club-membership/), you will have access to our private and secure support ticket system for all our ANEs. Even if you are not a member, you can still receive premium help if you purchase the [premium support package](https://www.myflashlabs.com/product/myflashlabs-support/).