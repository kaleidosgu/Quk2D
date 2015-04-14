package util.InputController 
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public interface IInputController 
	{
		function registeController( mgr:InputControllerManager ):void;
		function processMouseEvent( mouseEvt:MouseEvent, down:Boolean ):Boolean;
		function ProcessMouseMoveEvent( mouseEvt:MouseEvent ):Boolean;
		
		function processKeyboardEvent( keyEvt:KeyboardEvent, down:Boolean ):Boolean;
	}
	
}