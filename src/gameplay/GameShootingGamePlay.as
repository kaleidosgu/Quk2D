package gameplay 
{
	import flash.display.Stage;
	import gameEvent.PlayerInputActionEvent;
	import gameEvent.PlayerInputActionType;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPath;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameShootingGamePlay 
	{
		[Embed(source = "../../res/images/bullet.png")] private static var ImgBullet:Class;
		private var _shootSwitchOn:Boolean = false;
		private var _playerSprite:FlxSprite = null;
		private var _gameState:FlxState = null;
		private var _gameStage:Stage = null;
		private var _lastTime:Number = 0;
		public function GameShootingGamePlay( state:FlxState, player:FlxSprite, stage:Stage ) 
		{
			_gameState = state;
			_playerSprite = player;
			_gameStage = stage;
			_gameStage.addEventListener( PlayerInputActionEvent.PLAYER_INPUT_ACTION_EVENT, onActionEvt );
		}
		
		public function update():void
		{
			if ( _shootSwitchOn )
			{
				if ( _playerSprite )
				{
					fireBullet( _playerSprite.x, _playerSprite.y, FlxG.mouse.x, FlxG.mouse.y );
				}
			}
		}
		private function onActionEvt( evt:PlayerInputActionEvent ):void
		{
			if ( evt.playerActionType == PlayerInputActionType.Player_Shoot_On )
			{
				_shootSwitchOn = true;
			}
			else if ( evt.playerActionType == PlayerInputActionType.Player_Shoot_Off )
			{
				_shootSwitchOn = false;
			}
		}
		private function fireBullet( startX:Number, startY:Number, endX:Number, endY:Number ):void
		{
			var canShoot:Boolean = false;
			var currTime:Number = new Date().time;
			if ( currTime - _lastTime > 700 )
			{
				_lastTime = currTime;
				canShoot = true;
			}
			if ( canShoot )
			{
				var startPoint:FlxPoint = new FlxPoint( startX, startY );
				var endPoint:FlxPoint = new FlxPoint( endX , endY );
				
				var bulletSprite:FlxSprite = new FlxSprite(startX, startY, ImgBullet );
				_gameState.add( bulletSprite );
				
				bulletSprite.x = startPoint.x;
				bulletSprite.y = startPoint.y;
				var widthLength:Number = endPoint.x - startPoint.x ;
				var heightLength:Number = endPoint.y - startPoint.y ;
				var rLength:Number = Math.sqrt( widthLength * widthLength + heightLength * heightLength );
				var sinAngle:Number = heightLength / rLength;
				var cosAngle:Number = widthLength / rLength;
				bulletSprite.velocity.x = cosAngle* 1000 ;
				bulletSprite.velocity.y = sinAngle * 1000 ;
			}
		}
		
		public function get shootSwitchOn():Boolean 
		{
			return _shootSwitchOn;
		}
		
		public function set shootSwitchOn(value:Boolean):void 
		{
			_shootSwitchOn = value;
		}
		
	}

}