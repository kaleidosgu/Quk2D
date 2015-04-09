package util.InputController 
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class InputControllerManager 
	{
		private var _controllerArray:Array = new Array();
		private var _stageSprite:Stage = null;
		public function InputControllerManager( outStage:Stage ) 
		{
			_stageSprite = outStage;
			
			_stageSprite.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_stageSprite.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		public function registeController( iCon:IInputController ):void
		{
			_controllerArray.push( iCon );
		}
		protected function onKeyUp(FlashEvent:KeyboardEvent):void
		{
		}
		
		protected function onKeyDown(FlashEvent:KeyboardEvent):void
		{
			for each( var iCon:IInputController in _controllerArray )
			{
				var bProcess:Boolean = iCon.processKeyboardEvent( FlashEvent );
				if ( bProcess )
				{
					break;
				}
			}
		}
	}

}