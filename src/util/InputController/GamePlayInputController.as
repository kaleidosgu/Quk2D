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
		public function ProcessMouseMoveEvent( mouseEvt:MouseEvent ):Boolean
		{
			var evt:PlayerInputActionEvent = null;
			evt = new PlayerInputActionEvent( PlayerInputActionEvent.PLAYER_INPUT_ACTION_EVENT );
			evt.playerActionType = PlayerInputActionType.Player_Direction;
			_mgr.dispatchEvent( evt );
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
			else if ( keyEvt.keyCode == FlxG.keys.getKeyCode( "W" ) )
			{
				evt = new PlayerInputActionEvent( PlayerInputActionEvent.PLAYER_INPUT_ACTION_EVENT );
				evt.playerActionType = PlayerInputActionType.Player_Jump;
			}
			if ( evt )
			{
				_mgr.dispatchEvent( evt );	
				bRes = true;
			}
			return bRes;
		}

		public function processMouseEvent( mouseEvt:MouseEvent, down:Boolean ):Boolean
		{
			var evt:PlayerInputActionEvent = new PlayerInputActionEvent( PlayerInputActionEvent.PLAYER_INPUT_ACTION_EVENT );
			evt.playerActionType = down ? PlayerInputActionType.Player_Shoot_On : PlayerInputActionType.Player_Shoot_Off;
			_mgr.dispatchEvent( evt );
			return true;
		}		
	}

}