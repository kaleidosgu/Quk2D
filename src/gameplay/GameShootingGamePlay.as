package gameplay 
{
	import flash.display.Stage;
	import flash.geom.Point;
	import gameEvent.PlayerInputActionEvent;
	import gameEvent.PlayerInputActionType;
	import gameplay.WeaponSystem.BulletAmmo.BaseBulletObject;
	import gameplay.WeaponSystem.BulletGeneratePoint;
	import gameplay.WeaponSystem.PlayerWeaponStatus;
	import gameplay.WeaponSystem.WeaponAttributeLoadFromXml;
	import gameplay.WeaponSystem.WeaponShoot.BaseWeaponShoot;
	import gameplay.WeaponSystem.WeaponShoot.WeaponShootRailGun;
	import gameplay.WeaponSystem.WeaponShoot.WeaponShootShotGun;
	import gameplay.WeaponSystem.WeaponTypeDefine;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxParticle;
	import org.flixel.FlxPath;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import util.EventDispatch.GameDispatchSystem;
	import util.Math.MathRandomUtil;
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

		private var _lightbotArray:Array = new Array();
		
		private var _drawLineSprite:FlxSprite = null;
		
		private var _playerWeaponStatus:PlayerWeaponStatus = null;
		
		private var _weaponLoader:WeaponAttributeLoadFromXml = null;
		
		private var _bulletGroup:FlxGroup = null;
		
		private var _dspSystem:GameDispatchSystem = null;
		
		private var _bulletGeneratePoint:BulletGeneratePoint = new BulletGeneratePoint();
		
		private var _weaponShotObject:Object = new Object();
		public function GameShootingGamePlay( state:FlxState, player:FlxSprite, stage:Stage, outBulletGroup:FlxGroup, inEventDsp:GameDispatchSystem ) 
		{
			_dspSystem = inEventDsp;
			_bulletGroup = outBulletGroup;
			_gameState = state;
			_playerSprite = player;
			_gameStage = stage;
			_gameStage.addEventListener( PlayerInputActionEvent.PLAYER_INPUT_ACTION_EVENT, onActionEvt );
			
			_drawLineSprite = new FlxSprite(0, 0 );
			_drawLineSprite.makeGraphic(FlxG.width, FlxG.height, 0x000000 );
			_gameState.add(_drawLineSprite);
			
			_weaponLoader = new WeaponAttributeLoadFromXml();
			
			_playerWeaponStatus = new PlayerWeaponStatus( _weaponLoader );
			_initWeaponShot();
			
		}
		private function _initWeaponShot():void
		{
			_weaponShotObject[WeaponTypeDefine.WEAPON_TYPE_MACHINE_GUN] = new BaseWeaponShoot();
			//_weaponShotObject[WeaponTypeDefine.WEAPON_TYPE_SHOT_GUN] = new WeaponShootShotGun();
			_weaponShotObject[WeaponTypeDefine.WEAPON_TYPE_SHOT_GUN] = new WeaponShootRailGun();
		}
		public function changeWeapon( weaponType:uint ):void
		{
			
		}
		public function update():void
		{
			if ( _shootSwitchOn )
			{
				if ( _playerSprite )
				{
					//fireBullet( _playerSprite.x, _playerSprite.y, FlxG.mouse.x, FlxG.mouse.y );
					var startPoint:FlxPoint = _GetBulletGeneratePoint( );
					fireBullet2( startPoint.x, startPoint.y, FlxG.mouse.x, FlxG.mouse.y );
				}
			}
			//drawBulletGeneratePoint();
		}
		private function _GetBulletGeneratePoint():FlxPoint
		{
			var rctPlayer:FlxRect = new FlxRect();
			rctPlayer.x = _playerSprite.x;
			rctPlayer.y = _playerSprite.y;
			rctPlayer.width = _playerSprite.width;
			rctPlayer.height = _playerSprite.height;
			var mousePoint:FlxPoint = new FlxPoint( FlxG.mouse.x, FlxG.mouse.y );
			var _generatePointValue:FlxPoint = _bulletGeneratePoint.GeneratePoint( rctPlayer, mousePoint );	
			//_drawLineSprite.drawLine( _generatePointValue.x, _generatePointValue.y, _generatePointValue.x + 1, _generatePointValue.y + 1, 0xff0000 );
			return _generatePointValue;
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
			else if ( evt.playerActionType == PlayerInputActionType.Player_ChangeWeapon )
			{
				if ( _playerWeaponStatus.canChangeWeapon( evt.changeWeaponTyp ) )
				{
					_playerWeaponStatus.changeWeapon( evt.changeWeaponTyp );
				}
			}
		}
		private function fireBulletLighting( startX:Number, startY:Number, endX:Number, endY:Number ):void
		{
			var canShoot:Boolean = false;
			var currTime:Number = new Date().time;
			if ( currTime - _lastTime > 1000 )
			{
				_lastTime = currTime;
				canShoot = true;
			}
			if ( canShoot )
			{
				_drawLineSprite.fill( 0x000000 );
				createLightning( startX, startY, endX, endY );
			}
		}
		
		private function createLightning( startX:Number, startY:Number, endX:Number, endY:Number ):void
		{
			var ptXArray:Array = new Array();
			var currentPointX:Number = startX;
			ptXArray.push( currentPointX );
			for ( var ind:uint = 0; ind < 50; ind++ )
			{
				currentPointX = currentPointX + MathRandomUtil.randRange( 5, 10 );
				ptXArray.push ( currentPointX );
			}
			var ptArray:Array = new Array();
			var lastPointY:Number = 0;
			//ptArray.push( new Point( startX, 0 ) ) ;
			for each( var ptX:Number in ptXArray )
			{
				var localPointY:Number = MathRandomUtil.randRange( -25, 25 );
				if ( ( lastPointY + localPointY > 10 ) || ( lastPointY + localPointY < -10 ) )
				{
					localPointY = -localPointY;
				}
				lastPointY = localPointY;
				ptArray.push( new Point( ptX, localPointY ) );
			}
			
			var arrayGenerated:Boolean = !( _lightbotArray.length == 0 );
			var bulletIndex:uint = 0;
			var lastPtElement:Point = null;
			for each( var ptElement:Point in ptArray )
			{
				var posY:Number = ptElement.y + startY;
				if ( arrayGenerated == false )
				{
					var bulletSpriteNew:FlxSprite = new FlxSprite(ptElement.x, posY, ImgBullet );
					_gameState.add( bulletSpriteNew );	
					_lightbotArray.push( bulletSpriteNew );
				}
				else
				{
					var bulletSprite:FlxSprite = _lightbotArray[bulletIndex];
					bulletSprite.x = ptElement.x;
					bulletSprite.y = posY;
				}
				if ( lastPtElement != null )
				{
					_drawLineSprite.drawLine( lastPtElement.x , lastPtElement.y + startY, ptElement.x,  posY, 0xff0000 );
				}
				lastPtElement = ptElement;
				bulletIndex++;
			}
		}
		private function fireBullet2( startX:Number, startY:Number, endX:Number, endY:Number ):void
		{
			var canShoot:Boolean = _playerWeaponStatus.canShoot();
			if ( canShoot )
			{
				//_baseWeaponShoot = new BaseWeaponShoot( startX, startY, endX, endY, _playerWeaponStatus.currentWeaponAttr(), _dspSystem, _bulletGroup );
				//_baseWeaponShoot = new WeaponShootShotGun();
				var weaponTyp:uint = _playerWeaponStatus.currentWeaponAttr().weaponType;
				var _baseWeaponShoot:BaseWeaponShoot = _weaponShotObject[weaponTyp];
				if ( _baseWeaponShoot != null )
				{
					_baseWeaponShoot.SetPosition( startX, startY, endX, endY );
					_baseWeaponShoot.WeaponFire( _dspSystem, _bulletGroup, _playerWeaponStatus.currentWeaponAttr() );

					_playerWeaponStatus.shoot();
				}
			}
			else
			{
				//todo
				//不能发射的音效
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