package util.InputController 
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GamePlayInputController implements IInputController 
	{
		
		public function GamePlayInputController() 
		{
			
		}
		public function registeController( mgr:InputControllerManager ):void
		{
			mgr.registeController( this );
		}
		public function processMouseEvent( mouseEvt:MouseEvent ):Boolean
		{
			return false;
		}
		public function processKeyboardEvent( keyEvt:KeyboardEvent ):Boolean
		{
			return false;
		}
		
	}

}