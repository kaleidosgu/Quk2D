package util.InputController 
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class UIInputController implements IInputController 
	{
		
		public function UIInputController() 
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
			return true;
		}
		
	}

}