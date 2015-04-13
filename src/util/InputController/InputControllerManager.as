package util.InputController 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import org.flixel.FlxG;
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
			
			_stageSprite.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveEvent);
			//_stageSprite.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		public function onMouseMoveEvent( evt:MouseEvent ):void
		{
			trace("mouse down");
			for each( var iCon:IInputController in _controllerArray )
			{
				var bProcess:Boolean = iCon.ProcessMouseMoveEvent( evt );
				if ( bProcess )
				{
					break;
				}
			}
		}
		public function onMouseEvent( evt:MouseEvent ):void
		{
			for each( var iCon:IInputController in _controllerArray )
			{
				var bProcess:Boolean = iCon.ProcessMouseMoveEvent( evt );
				if ( bProcess )
				{
					break;
				}
			}
		}
		public function registeController( iCon:IInputController ):void
		{
			_controllerArray.push( iCon );
		}
		protected function onKeyUp(FlashEvent:KeyboardEvent):void
		{
			loopControllerForKeyEvent( FlashEvent, false );
		}
		
		protected function onKeyDown(FlashEvent:KeyboardEvent):void
		{
			loopControllerForKeyEvent( FlashEvent, true );
		}
		private function loopControllerForKeyEvent( flashEvent:KeyboardEvent, keyDown:Boolean ):void
		{
			for each( var iCon:IInputController in _controllerArray )
			{
				var bProcess:Boolean = iCon.processKeyboardEvent( flashEvent, keyDown );
				if ( bProcess )
				{
					break;
				}
			}
		}
		public function dispatchEvent( evt:Event ):void
		{
			if ( _stageSprite )
			{
				_stageSprite.dispatchEvent( evt );
			}
		}
	}

}