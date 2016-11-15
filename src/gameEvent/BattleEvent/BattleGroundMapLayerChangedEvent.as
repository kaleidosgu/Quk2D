package gameEvent.BattleEvent 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BattleGroundMapLayerChangedEvent extends Event 
	{
		public static var BattleGroundMapLayerChanged:String = "BATTLE_GROUND_MAP_LAYER_CHANGED";		
		
		private var _mapLayer:uint = 0;
		public function BattleGroundMapLayerChangedEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
		public function get mapLayer():uint 
		{
			return _mapLayer;
		}
		
		public function set mapLayer(value:uint):void 
		{
			_mapLayer = value;
		}
		
	}

}