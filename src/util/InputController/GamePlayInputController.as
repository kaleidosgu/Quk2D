package util.InputController 
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import gameEvent.PlayerInputActionEvent;
	import gameEvent.PlayerInputActionType;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GamePlayInputController implements IInputController 
	{
		private var _mgr:InputControllerManager = null;
		public function GamePlayInputController() 
		{
			
		}
		public function registeController( mgr:InputControllerManager ):void
		{
			mgr.registeController( this );
			_mgr = mgr;
		}
		public function processMouseEvent( mouseEvt:MouseEvent ):Boolean
		{
			return false;
		}
		public function processKeyboardEvent( keyEvt:KeyboardEvent, down:Boolean ):Boolean
		{
			var bRes:Boolean = false;
			var evt:PlayerInputActionEvent = null;
			if ( keyEvt.keyCode == FlxG.keys.getKeyCode( "A" ) )
			{
				evt = new PlayerInputActionEvent( PlayerInputActionEvent.PLAYER_INPUT_ACTION_EVENT );
				if ( down == true )
				{
					evt.playerActionType = PlayerInputActionType.Player_Move_Left;
				}
				else
				{
					evt.playerActionType = PlayerInputActionType.Player_Move_Stop;
				}
			}
			else if ( keyEvt.keyCode == FlxG.keys.getKeyCode( "D" ) )
			{
				evt = new PlayerInputActionEvent( PlayerInputActionEvent.PLAYER_INPUT_ACTION_EVENT );
				if ( down == true )
				{
					evt.playerActionType = PlayerInputActionType.Player_Move_Right;
				}
				else
				{
					evt.playerActionType = PlayerInputActionType.Player_Move_Stop;
				}
			}
			if ( evt )
			{
				_mgr.dispatchEvent( evt );	
				bRes = true;
			}
			return bRes;
		}
		
	}

}