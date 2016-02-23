package gameEvent.BattleEvent 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BulletGenerateExplosionEvent extends Event 
	{
		public static var BULLET_GENERATE_EXPLOSION_EVENT:String = "BULLET_GENERATE_EXPLOSION_EVENT";
		
		private var _posX:Number = 0;
		private var _posY:Number = 0;
		private var _preX:Number = 0;
		private var _preY:Number = 0;
		private var _weaponType:uint = 0;
		public function BulletGenerateExplosionEvent( type:String, bubbles:Boolean=false, cancelable:Boolean = false ) 
		{
			super( type, bubbles, cancelable );
		}
		
		public function get posX():Number 
		{
			return _posX;
		}
		
		public function set posX(value:Number):void 
		{
			_posX = value;
		}
		
		public function get posY():Number 
		{
			return _posY;
		}
		
		public function set posY(value:Number):void 
		{
			_posY = value;
		}
		
		public function get weaponType():uint 
		{
			return _weaponType;
		}
		
		public function set weaponType(value:uint):void 
		{
			_weaponType = value;
		}
		
		public function get preX():Number 
		{
			return _preX;
		}
		
		public function set preX(value:Number):void 
		{
			_preX = value;
		}
		
		public function get preY():Number 
		{
			return _preY;
		}
		
		public function set preY(value:Number):void 
		{
			_preY = value;
		}
		
	}

}