package gameplay 
{
	import flash.display.Stage;
	import flash.geom.Point;
	import gameEvent.PlayerInputActionEvent;
	import gameEvent.PlayerInputActionType;
	import gameplay.WeaponSystem.BulletAmmo.BaseBulletObject;
	import gameplay.WeaponSystem.PlayerWeaponStatus;
	import gameplay.WeaponSystem.WeaponAmmoPackage;
	import gameplay.WeaponSystem.WeaponAttribute;
	import gameplay.WeaponSystem.WeaponAttributeLoadFromXml;
	import gameplay.WeaponSystem.WeaponTypeDefine;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxParticle;
	import org.flixel.FlxPath;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
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
		
		public function GameShootingGamePlay( state:FlxState, player:FlxSprite, stage:Stage, outBulletGroup:FlxGroup ) 
		{
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
					fireBullet2( _playerSprite.x, _playerSprite.y, FlxG.mouse.x, FlxG.mouse.y );
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
				var startPoint:FlxPoint = new FlxPoint( startX, startY );
				var endPoint:FlxPoint = new FlxPoint( endX , endY );
				
				//var bulletSprite:FlxSprite = new FlxSprite(startX, startY, ImgBullet );
				var bulletSprite:BaseBulletObject = new BaseBulletObject( );
				bulletSprite.x = startX;
				bulletSprite.y = startY;
				bulletSprite.loadGraphic( ImgBullet );
				bulletSprite.setSelfGroup( _bulletGroup );
				
				bulletSprite.x = startPoint.x;
				bulletSprite.y = startPoint.y;
				var widthLength:Number = endPoint.x - startPoint.x ;
				var heightLength:Number = endPoint.y - startPoint.y ;
				var rLength:Number = Math.sqrt( widthLength * widthLength + heightLength * heightLength );
				var sinAngle:Number = heightLength / rLength;
				var cosAngle:Number = widthLength / rLength;
				bulletSprite.velocity.x = cosAngle* 1000 ;
				bulletSprite.velocity.y = sinAngle * 1000 ;
				_playerWeaponStatus.shoot();
				bulletSprite.weaponAttr = _playerWeaponStatus.currentWeaponAttr();
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