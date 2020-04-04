package com.doitflash.text.modules {
import flash.display.MovieClip;
import flash.display.Shape;

/**
 * ...
 *
 * @author Hadi Tavakoli - 3/28/2011 3:21 PM
 */
public class MyMovieClip extends MovieClip {
    public function MyMovieClip():void {

    }
    protected var _bg:Shape;
    private var _listenersArr:Array = [];

    protected var _width:Number = 0;

    override public function get width():Number {
        return _width;
    }

    override public function set width(a:Number):void {
        if (_width != a) {
            _width = a;
            onResize();
        }
    }

    protected var _height:Number = 0;

    override public function get height():Number {
        return _height;
    }

    override public function set height(a:Number):void {
        if (_height != a) {
            _height = a;
            onResize();
        }
    }

    protected var _margin:Number = 0;

    public function get margin():Number {
        return _margin;
    }

    public function set margin(a:Number):void {
        _margin = a;
    }

    protected var _marginX:Number = 0;

    public function get marginX():Number {
        return _marginX;
    }

    public function set marginX(a:Number):void {
        _marginX = a;
    }

    protected var _marginY:Number = 0;

    public function get marginY():Number {
        return _marginY;
    }

    public function set marginY(a:Number):void {
        _marginY = a;
    }

    protected var _embedFonts:Boolean;

    public function get embedFonts():Boolean {
        return _embedFonts;
    }

    public function set embedFonts(a:Boolean):void {
        _embedFonts = a;
    }

    protected var _configXml:XML;

    public function get configXml():XML {
        return _configXml;
    }

    public function set configXml(a:XML):void {
        _configXml = a;
    }

    protected var _xml:XML;

    public function get xml():XML {
        return _xml;
    }

    public function set xml(a:XML):void {
        _xml = a;
    }

    protected var _data:Object = {};

    public function get data():Object {
        return _data;
    }

    public function set data(a:Object):void {
        _data = a;
    }

    protected var _id:int;

    public function get id():int {
        return _id;
    }

    public function set id(a:int):void {
        _id = a;
    }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Getter - Setter
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    protected var _base:Object;

    public function get base():Object {
        return _base;
    }

    public function set base(a:Object):void {
        _base = a;
    }

    protected var _canvas:*;

    public function get canvas():Object {
        return _canvas;
    }

    public function set canvas(a:Object):void {
        _canvas = a;
    }

    protected var _holder:Object;

    public function get holder():Object {
        return _holder;
    }

    public function set holder(a:Object):void {
        _holder = a;
    }

    protected var _bgColor:uint = 0x000000;

    public function get bgColor():uint {
        return _bgColor;
    }

    public function set bgColor(a:uint):void {
        _bgColor = a;
    }

    protected var _bgAlpha:Number = 0;

    public function get bgAlpha():Number {
        return _bgAlpha;
    }

    public function set bgAlpha(a:Number):void {
        _bgAlpha = a;
    }

    protected var _bgStrokeColor:uint = 0x990000;

    public function get bgStrokeColor():uint {
        return _bgStrokeColor;
    }

    public function set bgStrokeColor(a:uint):void {
        _bgStrokeColor = a;
    }

    protected var _bgStrokeThickness:Number = 0;

    public function get bgStrokeThickness():Number {
        return _bgStrokeThickness;
    }

    public function set bgStrokeThickness(a:Number):void {
        _bgStrokeThickness = a;
    }

    protected var _bgStrokeAlpha:Number = 0;

    public function get bgStrokeAlpha():Number {
        return _bgStrokeAlpha;
    }

    public function set bgStrokeAlpha(a:Number):void {
        _bgStrokeAlpha = a;
    }

    protected var _bgTopLeftRadius:Number = 0;

    public function get bgTopLeftRadius():Number {
        return _bgTopLeftRadius;
    }

    public function set bgTopLeftRadius(a:Number):void {
        _bgTopLeftRadius = a;
    }

    protected var _bgTopRightRadius:Number = 0;

    public function get bgTopRightRadius():Number {
        return _bgTopRightRadius;
    }

    public function set bgTopRightRadius(a:Number):void {
        _bgTopRightRadius = a;
    }

    protected var _bgBottomLeftRadius:Number = 0;

    public function get bgBottomLeftRadius():Number {
        return _bgBottomLeftRadius;
    }

    public function set bgBottomLeftRadius(a:Number):void {
        _bgBottomLeftRadius = a;
    }

    protected var _bgBottomRightRadius:Number = 0;

    public function get bgBottomRightRadius():Number {
        return _bgBottomRightRadius;
    }

    public function set bgBottomRightRadius(a:Number):void {
        _bgBottomRightRadius = a;
    }

    protected var _serverPath:String = "";

    public function get serverPath():String {
        return _serverPath;
    }

    public function set serverPath(a:String):void {
        _serverPath = a;
    }

    protected var _flashVars:Object;

    public function get flashVars():Object {
        return _flashVars;
    }

    public function set flashVars(a:Object):void {
        _flashVars = a;
    }

    override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
        super.addEventListener(type, listener, useCapture, priority, useWeakReference);
        _listenersArr.push({type: type, listener: listener});
    }

    public function drawBg():void {
        if (!_bg) {
            _bg = new Shape();
            this.addChildAt(_bg, 0);
        }

        _bg.graphics.clear();
        _bg.graphics.beginFill(_bgColor, _bgAlpha);
        _bg.graphics.lineStyle(_bgStrokeThickness, _bgStrokeColor, _bgStrokeAlpha);
        _bg.graphics.drawRoundRectComplex(0, 0, _width, _height, _bgTopLeftRadius, _bgTopRightRadius, _bgBottomLeftRadius, _bgBottomRightRadius);
        _bg.graphics.endFill();
    }

    public function clearEvents():void {
        if (!_listenersArr) return;

        for (var i:int = 0; i < _listenersArr.length; i++) {
            if (this.hasEventListener(_listenersArr[i].type)) {
                this.removeEventListener(_listenersArr[i].type, _listenersArr[i].listener);
            }
        }

        _listenersArr = null
    }

    protected function onResize(e:* = null):void {
        if (_bg) drawBg();
    }

    protected function toBoolean(a:String):Boolean {
        if (a == "true") return true;

        return false;
    }

    protected function cleanUp($target:*, $freeMemory:Boolean = false):void {
        $target.graphics.clear();

        for (var i:int = $target.numChildren - 1; i >= 0; i--) {
            var child:* = $target.getChildAt(i);

            $target.removeChild(child);
            if ($freeMemory) child = null;
        }
    }
}

}