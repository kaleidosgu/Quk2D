package gameplay.WeaponSystem 
{
	import Base.BaseGameObject;
	import gamemap.GameObjectMainTyp;
	import gameplay.GameExplosionGenerator;
	import gameplay.WeaponSystem.Explosion.BaseExplosionObject;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import player.BasePlayerObject;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BulletCollideMonitor 
	{
		[Embed(source = "../../../res/images/teleport.png")] private static var ImgExp:Class;
		
		private var _bulletGroup:FlxGroup 			= null;
		private var _playerGroup:FlxGroup			= null;
		private var _arrayBuildingGroup:Array 		= null;
		private var _mainPlayer:BasePlayerObject 	= null;
		private var _gameState:FlxState 			= null;
		private var _explosionGroup:FlxGroup		= null;
		public function BulletCollideMonitor( inExpGroup:FlxGroup, inBulletGroup:FlxGroup, inPlayerGroup:FlxGroup, inMainPlayer:BasePlayerObject, gameState:FlxState ) 
		{
			_bulletGroup 	= inBulletGroup;
			_playerGroup	= inPlayerGroup;
			_mainPlayer		= inMainPlayer;
			_gameState		= gameState;
			_explosionGroup	= inExpGroup;
		}
		
		public function update():void
		{
			FlxG.overlap( _playerGroup, _bulletGroup, playerCollideBullet );
			FlxG.overlap( _playerGroup, _explosionGroup, playerCollideExp );
			if ( _arrayBuildingGroup != null )
			{
				for each( var buildingGroup:FlxGroup in _arrayBuildingGroup )
				{
					FlxG.overlap( _bulletGroup, buildingGroup, BulletCollideBuilding );
				}
			}
		}
		protected function playerCollideExp( playerObj:BaseGameObject, expObj:BaseGameObject ):void
		{
			if ( playerObj.getMainTyp() == GameObjectMainTyp.GameObjectMainTyp_Player
				&& expObj.getMainTyp() == GameObjectMainTyp.GameObjectMainTyp_Explosion )
				{
					playerObj.collideByOtherObj( expObj );
					expObj.collideByOtherObj( playerObj );
				}
		}
		protected function playerCollideBullet( playerObj:BaseGameObject, bulletObj:BaseGameObject ):void
		{
			//if ( _mainPlayer != playerObj )
			{
				if ( playerObj.getMainTyp() == GameObjectMainTyp.GameObjectMainTyp_Player
				&& bulletObj.getMainTyp() == GameObjectMainTyp.GameObjectMainTyp_Bullet )
				{
					playerObj.collideByOtherObj( bulletObj );
					bulletObj.collideByOtherObj( playerObj );
					//GameExplosionGenerator.getIns().generateExplosion( playerObj.x, playerObj.y, _gameState );
				}
			}
		}
		
		private function generateExplosion( posX:Number, posY:Number ):void
		{
			var expObj:BaseExplosionObject = new BaseExplosionObject();
			expObj.x = posX - expObj.width / 2 ;
			expObj.y = posY - expObj.height / 2 ;
			expObj.loadGraphic( ImgExp, true, true, 16 );
			expObj.setSelfGroup( _explosionGroup );
		}
		protected function BulletCollideBuilding( bulletObj:BaseGameObject, buildingObj:BaseGameObject ):void
		{
			//替换成building
			//playerObj.collideByOtherObj( bulletObj );
			bulletObj.collideByOtherObj( buildingObj );
			GameExplosionGenerator.getIns().generateExplosion( bulletObj.x, bulletObj.y, _gameState );
			generateExplosion( bulletObj.x + bulletObj.width / 2, bulletObj.y + bulletObj.height / 2);
		}
		public function setBuildingGroup( arrayGroup:Array ):void
		{
			_arrayBuildingGroup = arrayGroup;
		}
	}

}