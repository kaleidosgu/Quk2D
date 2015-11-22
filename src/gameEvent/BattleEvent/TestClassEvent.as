package gameEvent.BattleEvent 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ddda
	 */
	public class TestClassEvent extends Event 
	{
		public static var TEST_NAME_CLASS:String = "TEST_NAME_CLASS";
		public function TestClassEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}