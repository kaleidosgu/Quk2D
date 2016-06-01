package gameEvent.sound 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class PlaySoundEvent extends Event 
	{
		public static var PLAY_SOUND_EVENT:String = "PLAY_SOUND_EVENT";	
		private var _strSound:String = "";
		public function PlaySoundEvent(type:String, bubbles:Boolean=false, cancelable:Boolean = false) 
		{
			super( type, bubbles, cancelable );
		}
		
		public function get strSound():String 
		{
			return _strSound;
		}
		
		public function set strSound(value:String):void 
		{
			_strSound = value;
		}
		
	}

}