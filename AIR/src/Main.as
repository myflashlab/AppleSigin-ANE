package {

import com.doitflash.consts.Direction;
import com.doitflash.consts.Orientation;
import com.doitflash.mobileProject.commonCpuSrc.DeviceInfo;
import com.doitflash.starling.utils.list.List;
import com.doitflash.text.modules.MySprite;
import com.luaye.console.C;
import com.myflashlab.air.extensions.appleSignIn.*;
import com.myflashlab.air.extensions.dependency.OverrideAir;

import flash.desktop.NativeApplication;
import flash.desktop.SystemIdleMode;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.InvokeEvent;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.ui.Keyboard;
import flash.ui.Multitouch;
import flash.ui.MultitouchInputMode;

public class Main extends Sprite {
    private const BTN_WIDTH:Number = 150;
    private const BTN_HEIGHT:Number = 60;
    private const BTN_SPACE:Number = 2;

    public function Main():void {
        Multitouch.inputMode = MultitouchInputMode.GESTURE;
        NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, handleActivate);
        NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, handleDeactivate);
        NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvoke);
        NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, handleKeys);

        stage.addEventListener(Event.RESIZE, onResize);
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        C.startOnStage(this, "`");
        C.commandLine = false;
        C.commandLineAllowed = false;
        C.x = 20;
        C.width = 250;
        C.height = 150;
        C.strongRef = true;
        C.visible = true;
        C.scaleX = C.scaleY = DeviceInfo.dpiScaleMultiplier;

        _txt = new TextField();
        _txt.autoSize = TextFieldAutoSize.LEFT;
        _txt.antiAliasType = AntiAliasType.ADVANCED;
        _txt.multiline = true;
        _txt.wordWrap = true;
        _txt.embedFonts = false;
        _txt.htmlText = "<font face='Arimo' color='#333333' size='20'><b>AppleSignIn ANE V" + AppleSignIn.VERSION + "</font>";
        _txt.scaleX = _txt.scaleY = DeviceInfo.dpiScaleMultiplier;
        this.addChild(_txt);

        _body = new Sprite();
        this.addChild(_body);

        _list = new List();
        _list.holder = _body;
        _list.itemsHolder = new Sprite();
        _list.orientation = Orientation.VERTICAL;
        _list.hDirection = Direction.LEFT_TO_RIGHT;
        _list.vDirection = Direction.TOP_TO_BOTTOM;
        _list.space = BTN_SPACE;

        init();
        onResize();
    }

    private var _txt:TextField;
    private var _body:Sprite;
    private var _list:List;
    private var _numRows:int = 1;

    private function onResize(e:* = null):void {
        if (_txt) {
            _txt.y = 150 * (1 / DeviceInfo.dpiScaleMultiplier);
            _txt.width = stage.stageWidth * (1 / DeviceInfo.dpiScaleMultiplier);

            C.x = 0;
            C.y = _txt.y + _txt.height + 0;
            C.width = stage.stageWidth * (1 / DeviceInfo.dpiScaleMultiplier);
            C.height = 300 * (1 / DeviceInfo.dpiScaleMultiplier);
        }

        if (_list) {
            _numRows = Math.floor(stage.stageWidth / (BTN_WIDTH * DeviceInfo.dpiScaleMultiplier + BTN_SPACE));
            _list.row = _numRows;
            _list.itemArrange();
        }

        if (_body) {
            _body.y = stage.stageHeight - _body.height;
        }
    }

    private function init():void {
        // Remove OverrideAir debugger in production builds
        OverrideAir.enableDebugger(function ($ane:String, $class:String, $msg:String):void {
            trace($ane + " (" + $class + ") " + $msg);
        });

        AppleSignIn.init();
        AppleSignIn.listener.addEventListener(AppleSignInEvent.SUCCESS, onSuccess);
        AppleSignIn.listener.addEventListener(AppleSignInEvent.FAILURE, onFailure);

        //----------------------------------------------------------------------

        var btn1:MySprite = createBtn("Get Authorized");
        btn1.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
            AppleSignIn.authorize();
        });
        _list.add(btn1);

        //----------------------------------------------------------------------

        onResize();
    }
    
    private function onSuccess(event:AppleSignInEvent):void {
    
        trace("onSuccess: " + JSON.stringify(event.result));
        C.log("onSuccess: " + JSON.stringify(event.result));
    }
    
    private function onFailure(event:AppleSignInEvent):void {
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
        C.log("onFailure: " + errorMsg);
    }

    private function createBtn($str:String):MySprite {
        var sp:MySprite = new MySprite();
        sp.addEventListener(MouseEvent.MOUSE_OVER, onOver);
        sp.addEventListener(MouseEvent.MOUSE_OUT, onOut);
        sp.addEventListener(MouseEvent.CLICK, onOut);
        sp.bgAlpha = 1;
        sp.bgColor = 0xDFE4FF;
        sp.drawBg();
        sp.width = BTN_WIDTH * DeviceInfo.dpiScaleMultiplier;
        sp.height = BTN_HEIGHT * DeviceInfo.dpiScaleMultiplier;

        function onOver(e:MouseEvent):void {
            sp.bgAlpha = 1;
            sp.bgColor = 0xFFDB48;
            sp.drawBg();
        }

        function onOut(e:MouseEvent):void {
            sp.bgAlpha = 1;
            sp.bgColor = 0xDFE4FF;
            sp.drawBg();
        }

        var format:TextFormat = new TextFormat("Arimo", 16, 0x666666, null, null, null, null, null, TextFormatAlign.CENTER);

        var txt:TextField = new TextField();
        txt.autoSize = TextFieldAutoSize.LEFT;
        txt.antiAliasType = AntiAliasType.ADVANCED;
        txt.mouseEnabled = false;
        txt.multiline = true;
        txt.wordWrap = true;
        txt.scaleX = txt.scaleY = DeviceInfo.dpiScaleMultiplier;
        txt.width = sp.width * (1 / DeviceInfo.dpiScaleMultiplier);
        txt.defaultTextFormat = format;
        txt.text = $str;

        txt.y = sp.height - txt.height >> 1;
        sp.addChild(txt);

        return sp;
    }

    private function onInvoke(e:InvokeEvent):void {
        NativeApplication.nativeApplication.removeEventListener(InvokeEvent.INVOKE, onInvoke);
    }

    private function handleActivate(e:Event):void {
        NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
    }

    private function handleDeactivate(e:Event):void {
        NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.NORMAL;
    }

    private function handleKeys(e:KeyboardEvent):void {
        if (e.keyCode == Keyboard.BACK) {
            e.preventDefault();
            NativeApplication.nativeApplication.exit();
        }
    }
}
}