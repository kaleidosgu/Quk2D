package fsm 
{
	import flash.display.Stage;
	import gameEvent.PlayerInputActionEvent;
	import gameEvent.PlayerInputActionType;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import player.BasePlayerObject;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class PlayerFsmTest 
	{
		private var _stage:Stage = null;
		private var _player:BasePlayerObject = null;
		public function PlayerFsmTest( stage:Stage, player:BasePlayerObject ) 
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
			if ( _player && evt.playerObject == _player)
			{
				if ( evt.playerActionType == PlayerInputActionType.Player_Move_Left )
				{
					_player.acceleration.x -= _player.getSpeed();
					_player.facing = FlxObject.LEFT;
				}
				else if ( evt.playerActionType == PlayerInputActionType.Player_Move_Right )
				{
					_player.acceleration.x += _player.getSpeed();
					_player.facing = FlxObject.RIGHT;
				}
				else if ( evt.playerActionType == PlayerInputActionType.Player_Move_Stop )
				{
					_player.acceleration.x = 0;
				}
				else if ( evt.playerActionType == PlayerInputActionType.Player_Jump )
				{
					if ( _player.velocity.y == 0 )
					{
						//_player.velocity.y = -200;	
					}
				}
				else if ( evt.playerActionType == PlayerInputActionType.Player_Direction )
				{
					if ( _player.x >= FlxG.mouse.x )
					{
						//_player.facing = FlxObject.LEFT;
					}
					else
					{
						//_player.facing = FlxObject.RIGHT;
					}
				}
			}
		}
	}

}