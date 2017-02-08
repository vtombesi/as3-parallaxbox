﻿package {

	import flash.display.MovieClip; 
	import flash.events.Event; 
	import flash.utils.Dictionary;
	import flash.filters.BlurFilter; 
	
	dynamic public class ParallaxBox extends MovieClip {
		
		// private properties
		private var theObjects:Array; 
		private var theMode:Number;
		private var theState:Number; 
		private var theStarts:Dictionary; 
		
		// user definable properties
		private var _blurred:Boolean = false;
		private var _xrate:Number = 1; 
		private var _yrate:Number = 1; 
		private var _autodetect:Boolean = false; 
		
		// public constants for parallax movement
		public static const HORIZONTAL:Number = 1; 
		public static const VERTICAL:Number = 2; 
		public static const BOTH:Number = 3; 
		
		// debug mode (use it to trace errors)
		public static const DEBUG:Boolean = false; 
		
		public function ParallaxBox() {
			theObjects = new Array(); 
			theStarts = new Dictionary(); 
			addEventListener(Event.ADDED_TO_STAGE, init); 
		}
		
		private function init(e:Event):void {
			if (DEBUG) {
				trace("init ok"); 
			}
			theState = 0; 
		}
		
		public function set mode (v:Number):void {
			theMode = v; 
			if (DEBUG) {
				trace("mode selected: " + v); 
			}
		}
		
		public function set xrate (m:Number):void {
			_xrate = m; 
		}
		
		public function set yrate (m:Number):void {
			_yrate = m; 
		}		
		
		public function set blurred (m:Boolean):void {
			_blurred = m; 
		}
		
		public function set autowing (m:Boolean):void {
			_autodetect = m; 
		}
		
		public function addItem(s:String, wingx:Number, wingy:Number, pixelHinting:Boolean = false):void {
			var clip:MovieClip = this.getChildByName(s) as MovieClip; 
			theObjects.push( { movie: clip, wingx: wingx, wingy: wingy, startx: clip.x, starty:clip.y, pixelhinting: pixelHinting } ); 
			if (DEBUG) {
				trace("object added to render list: " + clip); 
			}
		}
		
		public function start():void {
			addEventListener(Event.ENTER_FRAME, onFrame); 
		}
		
		public function pause():void {
			removeEventListener(Event.ENTER_FRAME, onFrame); 
		}
		
		private function onFrame(e:Event):void {
			var xP:Number = -(100 / (stage.stageWidth * .5) * this.mouseX); 
			var yP:Number = -(100 / (stage.stageHeight * .5) * this.mouseY); 	
			
			var hwing:Number;  
			var vwing:Number;
			
			for (var m:Number = 0; m < theObjects.length; m++) {
				var clip:MovieClip = theObjects[m].movie; 
				
				hwing = theObjects[m].wingx; 
				vwing = theObjects[m].wingy; 
				
				if (_autodetect == true) {
					//hwing = (clip.width * .5) - (stage.stageWidth * .5); 
				}
				
				if (theMode == 1 || theMode == 3) {
					var targetx:Number = theObjects[m].startx + ((hwing / 100) * xP); 
					var xdiff:Number = clip.x - targetx; 
					var xamount:Number = (xdiff / _xrate); 
					var xblur:Number = Math.abs(xamount) * 1.2; 
					clip.x -= xdiff / _xrate ; 
					if (theObjects[m].pixelhinting) {
						clip.x = Math.floor(clip.x); 
					}					
				}
				if (theMode == 2 || theMode == 3) {
					var targety:Number = theObjects[m].starty + ((vwing / 100) * yP); 
					var ydiff:Number = clip.y - targety; 
					var yamount:Number = (ydiff / _yrate); 
					var yblur:Number = Math.abs(yamount) * 1.2; 
					clip.y -= ydiff / _yrate ; 	
					if (theObjects[m].pixelhinting) {
						clip.y = Math.floor(clip.y); 
					}	
				}
				
				if ((Math.floor(xblur) >= 1 || Math.floor(yblur) >= 1) && _blurred == true) {
					clip.filters = new Array( new BlurFilter(xblur, yblur, 1) ); 
				}						
				
			}
		}
		
	}
	
}