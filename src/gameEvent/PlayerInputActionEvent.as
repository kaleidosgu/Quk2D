package gameEvent 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class PlayerInputActionEvent extends Event 
	{
		public static var PLAYER_INPUT_ACTION_EVENT:String = "PLAYER_INPUT_ACTION_EVENT";
		private var _playerActionType:uint = 0;
		private var _changeWeaponTyp:uint = 0;
		public function PlayerInputActionEvent( type:String, bubbles:Boolean=false, cancelable:Boolean = false) 
		{
			super( type, bubbles, cancelable );
			
		}
		
		public function get playerActionType():uint 
		{
			return _playerActionType;
		}
		
		public function set playerActionType(value:uint):void 
		{
			_playerActionType = value;
		}
		
		public function get changeWeaponTyp():uint 
		{
			return _changeWeaponTyp;
		}
		
		public function set changeWeaponTyp(value:uint):void 
		{
			_changeWeaponTyp = value;
		}
		
	}

}