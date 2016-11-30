package util.InputController 
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import gameEvent.PlayerInputActionEvent;
	import gameEvent.PlayerInputActionType;
	import gameplay.WeaponSystem.WeaponTypeDefine;
	import org.flixel.FlxG;
	import player.BasePlayerObject;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GamePlayInputController implements IInputController 
	{
		private var _mgr:InputControllerManager = null;
		private var _weaponStringAndTypMap:Object = null;
		
		private var _moveLeft:int = 0;
		private var _moveRight:int = 0;
		private var _Scissor:int = 0;
		private var _Stone:int = 0;
		private var _Paper:int = 0;
		private var _player:BasePlayerObject = null;
		public function GamePlayInputController() 
		{
			_weaponStringAndTypMap = new Object();
			_weaponStringAndTypMap[FlxG.keys.getKeyCode("ONE")] = WeaponTypeDefine.WEAPON_TYPE_MACHINE_GUN;
			_weaponStringAndTypMap[FlxG.keys.getKeyCode("TWO")] = WeaponTypeDefine.WEAPON_TYPE_SHOT_GUN;
			_weaponStringAndTypMap[FlxG.keys.getKeyCode("THREE")] = WeaponTypeDefine.WEAPON_TYPE_GRENADE_LAUNCHER;
			_weaponStringAndTypMap[FlxG.keys.getKeyCode("FOUR")] = WeaponTypeDefine.WEAPON_TYPE_ROCKET_LAUNCHER;
			_weaponStringAndTypMap[FlxG.keys.getKeyCode("FIVE")] = WeaponTypeDefine.WEAPON_TYPE_LIGHTING_LAUNCHER;
			_weaponStringAndTypMap[FlxG.keys.getKeyCode("SIX")] = WeaponTypeDefine.WEAPON_TYPE_PLASMA_GUN;
			_weaponStringAndTypMap[FlxG.keys.getKeyCode("SEVEN")] = WeaponTypeDefine.WEAPON_TYPE_RAIL_GUN;
			_weaponStringAndTypMap[FlxG.keys.getKeyCode("EIGHT")] = WeaponTypeDefine.WEAPON_TYPE_GAUNTLET;
		}
		public function SetKeyAction( left:int, right:int, scissor:int, stone:int, paper:int ):void
		{
			_moveLeft = left;
			_moveRight = right;
			_Scissor = scissor;
			_Stone = stone;
			_Paper = paper;
		}
		public function registeController( mgr:InputControllerManager ):void
		{
			mgr.registeController( this );
			_mgr = mgr;
		}
		public function setPlayer( player:BasePlayerObject ):void
		{
			_player = player;
		}
		public function ProcessMouseMoveEvent( mouseEvt:MouseEvent ):Boolean
		{
			var evt:PlayerInputActionEvent = null;
			evt = new PlayerInputActionEvent( PlayerInputActionEvent.PLAYER_INPUT_ACTION_EVENT );
			evt.playerObject = _player;
			evt.playerActionType = PlayerInputActionType.Player_Direction;
			_mgr.dispatchEvent( evt );
			return false;
		}
		public function processKeyboardEvent( keyEvt:KeyboardEvent, down:Boolean ):Boolean
		{
			var bRes:Boolean = false;
			var evt:PlayerInputActionEvent = null;
			evt = new PlayerInputActionEvent( PlayerInputActionEvent.PLAYER_INPUT_ACTION_EVENT );
			evt.playerObject = _player;
			if ( keyEvt.keyCode == _moveLeft )
			{
				if ( down == true )
				{
					evt.playerActionType = PlayerInputActionType.Player_Move_Left;
				}
				else
				{
					evt.playerActionType = PlayerInputActionType.Player_Move_Stop;
				}
			}
			else if ( keyEvt.keyCode == _moveRight )
			{
				evt.playerObject = _player;
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
				evt.playerActionType = PlayerInputActionType.Player_Jump;
			}
			else if ( keyEvt.keyCode == FlxG.keys.getKeyCode("H"))
			{
				if ( down == false )
				{
					evt.playerActionType = PlayerInputActionType.Player_ChangeDoor;	
				}
			}
			else
			{
				if ( _weaponStringAndTypMap[keyEvt.keyCode] != null )
				{
					var weaponTyp:uint = _weaponStringAndTypMap[keyEvt.keyCode];
					evt.playerActionType = PlayerInputActionType.Player_ChangeWeapon;
					evt.changeWeaponTyp = weaponTyp;
				}
			}
			if ( evt && evt.playerActionType != PlayerInputActionType.Player_Move_None )
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