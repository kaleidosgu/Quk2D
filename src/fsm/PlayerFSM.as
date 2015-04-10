package fsm 
{
	import flash.display.Stage;
	import gameEvent.PlayerInputActionEvent;
	import gameEvent.PlayerInputActionType;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class PlayerFSM 
	{
		private var _stage:Stage = null;
		private var _player:FlxSprite = null;
		public function PlayerFSM( stage:Stage, player:FlxSprite ) 
		{
			_stage = stage;
			_player = player;
		}
		public function addListener():void
		{
			if ( _stage )
			{
				_stage.addEventListener( PlayerInputActionEvent.PLAYER_INPUT_ACTION_EVENT, onActionEvent );
			}
		}
		private function onActionEvent( evt:PlayerInputActionEvent ):void
		{
			if ( _player )
			{
				if ( evt.playerActionType == PlayerInputActionType.Player_Move_Left )
				{
					_player.acceleration.x -= 100;
				}
				else if ( evt.playerActionType == PlayerInputActionType.Player_Move_Right )
				{
					_player.acceleration.x += 100;
				}
				else if ( evt.playerActionType == PlayerInputActionType.Player_Move_Stop )
				{
					_player.acceleration.x = 0;
				}
			}
		}
	}

}