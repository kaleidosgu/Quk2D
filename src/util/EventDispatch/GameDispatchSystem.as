package util.EventDispatch 
{
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameDispatchSystem 
	{
		private var _stage:Stage = null;
		public function GameDispatchSystem( _inStage:Stage ) 
		{
			_stage = _inStage;
		}
		
		public function RegisterEvent( type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false ):void
		{
			if ( _stage != null )
			{
				_stage.addEventListener( type, listener, useCapture, priority, useWeakReference);
			}
		}
		public function UnRegisterEvent(type:String, listener:Function, useCapture:Boolean=false):void
		{
			if ( _stage != null )
			{
				_stage.removeEventListener( type, listener, useCapture );
			}
		}
		
		public function DispatchEvent( evt:Event ):void
		{
			if ( _stage != null )
			{
				_stage.dispatchEvent( evt );
			}
		}
		
	}

}