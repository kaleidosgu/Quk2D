package gameEvent.BattleEvent 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BulletGenerateExplosionEvent extends Event 
	{
		public var BULLET_GENERATE_EXPLOSION_EVENT:String = "BULLET_GENERATE_EXPLOSION_EVENT";
		private var _posX:Number = 0;
		private var _posY:Number = 0;
		private var _weaponType:uint = 0;
		public function BulletGenerateExplosionEvent( evtType:String ) 
		{
			super( type );
		}
		
	}

}