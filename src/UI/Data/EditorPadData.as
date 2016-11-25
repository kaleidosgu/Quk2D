package UI.Data 
{
	/**
	 * ...
	 * @author kaleidos
	 */
	public class EditorPadData 
	{
		private var _currentLayer:uint = 0;
		private var _doorDstLayer:uint = 0;
		public function EditorPadData() 
		{
			
		}
		
		public function get currentLayer():uint 
		{
			return _currentLayer;
		}
		
		public function set currentLayer(value:uint):void 
		{
			_currentLayer = value;
		}
		
		public function get doorDstLayer():uint 
		{
			return _doorDstLayer;
		}
		
		public function set doorDstLayer(value:uint):void 
		{
			_doorDstLayer = value;
		}
		
	}

}