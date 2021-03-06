package com.pixelwelders.fx
{
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Earthquake
	{
		private static const FRAME_RATE		: int = 30;			// adjustable, but looks pretty good at 25
		private static var timer			: Timer;
		
		private static var image			: DisplayObject;
		private static var originalX		: int;
		private static var originalY		: int;
		
		private static var intensity		: int;
		private static var intensityOffset	: int;
		
		public function Earthquake()
		{
			// static class - do not instantiate
		}
		
		// === A P I ===
		public static function go( _image:DisplayObject, _intensity:Number = 10, _seconds:Number = 1 ): void
		{
			if ( timer )
			{
				timer.stop();
			}
			
			image = _image;
			originalX = image.x;
			originalY = image.y;
			
			intensity = _intensity;
			intensityOffset = intensity / 2;
			
			// truncations and integer math are faster
			var msPerUpdate:int = int( 1000 / FRAME_RATE );
			var totalUpdates:int = int( _seconds * 1000 / msPerUpdate );
			
			timer = new Timer( msPerUpdate, totalUpdates );
			timer.addEventListener( TimerEvent.TIMER, quake );
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, resetImage );
			
			timer.start();
		}
		
		public static function temp(): void {}
		
		
		// === ===
		private static function quake( event:TimerEvent ): void
		{
			//trace( intensity );
			var newX:int = originalX + Math.random() * intensity - intensityOffset;
			var newY:int = originalY + Math.random() * intensity - intensityOffset;
			
			image.x = newX;
			image.y = newY;
		}
		
		private static function resetImage( event:TimerEvent = null ): void
		{
			image.x = originalX;
			image.y = originalY;
			
			cleanup();
		}
		
		private static function cleanup(): void
		{
			timer = null;
			image = null;
		}
		

	}
}