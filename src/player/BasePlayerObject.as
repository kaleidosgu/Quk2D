package player 
{
	import Base.BaseGameObject;
	import gamemap.GameObjectMainTyp;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BasePlayerObject extends BaseGameObject 
	{
		private var _playerMapLayer:uint = 0;
		public function BasePlayerObject() 
		{
			
		}
		override public function getMainTyp():uint
		{
			return GameObjectMainTyp.GameObjectMainTyp_Player;
		}
		
		public function get playerMapLayer():uint 
		{
			return _playerMapLayer;
		}
		
		public function set playerMapLayer(value:uint):void 
		{
			_playerMapLayer = value;
		}
		
		public function getSpeed():Number
		{
			return 150;
		}
	}

}